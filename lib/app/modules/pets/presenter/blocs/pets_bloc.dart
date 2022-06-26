import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_pets/app/modules/pets/domain/usecases/get_pets_usecase.dart';
import 'package:app_pets/app/modules/pets/presenter/blocs/events/pets_events.dart';
import 'package:app_pets/app/modules/pets/presenter/blocs/states/pets_states.dart';

class PetsBloc extends Bloc<PetsEvents, PetsStates> {
  final GetPetsUseCase getPetsUseCase;

  PetsBloc({
    required this.getPetsUseCase,
  }) : super(PetsInitialState()) {
    on<GetPetsAPIEvent>(_getPetsAPI);
    on<PetsFilterLocalEvent>(_petsFilter);
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
}
