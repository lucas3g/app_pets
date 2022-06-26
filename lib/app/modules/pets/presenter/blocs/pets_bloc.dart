import 'package:app_pets/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_pets/app/modules/pets/domain/usecases/get_pets_usecase.dart';
import 'package:app_pets/app/modules/pets/presenter/blocs/events/pets_events.dart';
import 'package:app_pets/app/modules/pets/presenter/blocs/states/pets_states.dart';

class PetsBloc extends Bloc<PetsEvents, PetsStates> {
  final GetPetsUseCase getPetsUseCase;
  final ILocalStorage localStorage;

  PetsBloc({
    required this.getPetsUseCase,
    required this.localStorage,
  }) : super(PetsInitialState()) {
    on<GetPetsAPIEvent>(_getPetsAPI);
    on<PetsFilterLocalEvent>(_petsFilter);
    on<AuthLogOutEvent>(_logout);
  }

  Future<void> _getPetsAPI(GetPetsAPIEvent event, emit) async {
    emit(state.loading());
    final result = await getPetsUseCase();
    result.fold(
        (error) => emit(
              state.error(
                error.message,
              ),
            ), (success) {
      success.shuffle();
      return emit(state.success(pets: success));
    });
  }

  void _petsFilter(PetsFilterLocalEvent event, emit) {
    emit(state.success(filter: event.value));
  }

  Future<void> _logout(AuthLogOutEvent event, emit) async {
    emit(state.loading());
    final result = await localStorage.removeData('logado');

    if (result) {
      return emit(state.logOut());
    }

    return emit(state.error('Error'));
  }
}
