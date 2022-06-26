import 'package:app_pets/app/core_module/types/either.dart';
import 'package:app_pets/app/modules/auth/domain/entities/auth_entity.dart';
import 'package:app_pets/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:app_pets/app/modules/auth/domain/params/login_params.dart';

abstract class ILoginRepository {
  Future<Either<IAuthException, AuthEntity>> login(
      {required LoginParams params});
}
