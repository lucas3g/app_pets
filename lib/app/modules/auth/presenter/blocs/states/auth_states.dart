import 'package:app_pets/app/modules/auth/domain/entities/auth_entity.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {
  final AuthEntity authEntity;

  AuthSuccessState({
    required this.authEntity,
  });
}

class AuthErrorState extends AuthStates {
  final String message;

  AuthErrorState({
    required this.message,
  });
}
