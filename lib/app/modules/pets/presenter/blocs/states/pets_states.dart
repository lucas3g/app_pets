import 'package:app_pets/app/modules/pets/domain/entities/pets_entity.dart';

abstract class PetsStates {
  final List<PetsEntity> pets;
  final String filter;

  PetsSuccessState success({List<PetsEntity>? pets, String? filter}) {
    return PetsSuccessState(
      pets: pets ?? this.pets,
      filter: filter ?? this.filter,
    );
  }

  PetsLoadingState loading() {
    return PetsLoadingState(
      pets: pets,
      filter: filter,
    );
  }

  PetsErrorState error(String message) {
    return PetsErrorState(
      message: message,
      filter: filter,
      pets: pets,
    );
  }

  AuthLogOutState logOut() {
    return AuthLogOutState(filter: filter, pets: pets);
  }

  List<PetsEntity> get filtredList {
    if (filter.isEmpty) {
      return pets;
    }

    return pets
        .where(
          (pet) => (pet.breed.toLowerCase().contains(
                filter.toLowerCase(),
              )),
        )
        .toList();
  }

  PetsStates({
    required this.pets,
    required this.filter,
  });
}

class PetsInitialState extends PetsSuccessState {
  PetsInitialState() : super(pets: [], filter: '');
}

class PetsLoadingState extends PetsStates {
  PetsLoadingState({required super.pets, required super.filter});
}

class PetsSuccessState extends PetsStates {
  PetsSuccessState({required super.pets, required super.filter});
}

class PetsErrorState extends PetsStates {
  final String message;

  PetsErrorState({
    required this.message,
    required super.pets,
    required super.filter,
  });
}

class AuthLogOutState extends PetsStates {
  AuthLogOutState({required super.pets, required super.filter});
}
