import 'package:app_pets/app/modules/pets/domain/entities/pets_entity.dart';

abstract class PetsStates {}

class PetsInitialState extends PetsSuccessState {
  PetsInitialState() : super(pets: []);
}

class PetsLoadingState extends PetsStates {}

class PetsSuccessState extends PetsStates {
  final List<PetsEntity> pets;

  PetsSuccessState({
    required this.pets,
  });
}

class PetsErrorState extends PetsStates {
  final String message;

  PetsErrorState({
    required this.message,
  });
}
