import 'package:app_pets/app/core_module/types/either.dart';
import 'package:app_pets/app/modules/auth/domain/entities/auth_entity.dart';
import 'package:app_pets/app/modules/auth/domain/params/login_params.dart';
import 'package:app_pets/app/modules/auth/infra/datasources/login_datasource_interface.dart';
import 'package:app_pets/app/modules/auth/infra/repositories/login_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../login_params_map.dart';

class LoginDataSourceMock extends Mock implements ILoginDataSource {}

void main() {
  late ILoginDataSource loginDataSource;
  late LoginRepository loginRepository;

  late LoginParams loginParams;

  setUp(() {
    loginParams = LoginParams(email: 'teste@gmail.com');

    loginDataSource = LoginDataSourceMock();
    loginRepository = LoginRepository(loginDataSource: loginDataSource);
  });

  test('should be return AuthEntity', () async {
    when(
      () => loginDataSource.login(email: loginParams.email),
    ).thenAnswer((_) async => LoginParamsMap);

    final result = await loginRepository.login(params: loginParams);

    expect(result.fold(id, id), isA<AuthEntity>());
  });
}
