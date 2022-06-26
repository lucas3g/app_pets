import 'package:app_pets/app/core_module/types/either.dart';
import 'package:app_pets/app/modules/auth/domain/entities/auth_entity.dart';
import 'package:app_pets/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:app_pets/app/modules/auth/domain/params/login_params.dart';
import 'package:app_pets/app/modules/auth/domain/repositories/login_repostory_interface.dart';
import 'package:app_pets/app/modules/auth/infra/adapters/login_adapter.dart';
import 'package:app_pets/app/modules/auth/infra/datasources/login_datasource_interface.dart';

class LoginRepository implements ILoginRepository {
  final ILoginDataSource loginDataSource;

  LoginRepository({
    required this.loginDataSource,
  });

  @override
  Future<Either<IAuthException, AuthEntity>> login(
      {required LoginParams params}) async {
    try {
      final Map result = await loginDataSource.login(email: params.email);

      if (result.isEmpty) {
        return left(const AuthException(message: 'Email não encontrado'));
      }

      final value = LoginAdapter.fromMap(result);

      return right(value);
    } on IAuthException catch (e) {
      return left(e);
    } catch (e) {
      return left(AuthException(message: e.toString()));
    }
  }
}
