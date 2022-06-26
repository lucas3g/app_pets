import 'package:app_pets/app/core_module/types/either.dart';
import 'package:app_pets/app/modules/auth/domain/entities/auth_entity.dart';
import 'package:app_pets/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:app_pets/app/modules/auth/domain/params/login_params.dart';
import 'package:app_pets/app/modules/auth/domain/repositories/login_repostory_interface.dart';
import 'package:app_pets/app/modules/auth/domain/validators/auth_validator.dart';

abstract class ILoginUseCase {
  Future<Either<IAuthException, AuthEntity>> call(
      {required LoginParams params});
}

class LoginUseCase implements ILoginUseCase {
  final ILoginRepository loginRepository;

  LoginUseCase({
    required this.loginRepository,
  });

  @override
  Future<Either<IAuthException, AuthEntity>> call(
      {required LoginParams params}) async {
    if (!AuthValidor.validateEmail(email: params.email)) {
      return left(
        const AuthException(message: 'Email invalido'),
      );
    }

    return await loginRepository.login(params: params);
  }
}
