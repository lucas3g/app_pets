import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_pets/app/modules/auth/domain/usecases/login_usecase.dart';
import 'package:app_pets/app/modules/auth/presenter/blocs/events/auth_events.dart';
import 'package:app_pets/app/modules/auth/presenter/blocs/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final LoginUseCase loginUseCase;

  AuthBloc({
    required this.loginUseCase,
  }) : super(AuthInitialState()) {
    on<AuthLoginEvent>(_loginSignIn);
  }

  Future<void> _loginSignIn(AuthLoginEvent event, emit) async {
    emit(AuthLoadingState());
    final result = await loginUseCase(params: event.loginParams);
    result.fold(
      (error) {
        emit(AuthErrorState(message: error.message));
      },
      (success) {
        emit(AuthSuccessState(authEntity: success));
      },
    );
  }
}
