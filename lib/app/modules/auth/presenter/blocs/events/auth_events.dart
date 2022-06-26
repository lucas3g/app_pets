import 'package:app_pets/app/modules/auth/domain/params/login_params.dart';

abstract class AuthEvents {}

class AuthLoginEvent extends AuthEvents {
  final LoginParams loginParams;

  AuthLoginEvent({
    required this.loginParams,
  });
}
