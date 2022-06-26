import 'package:app_pets/app/core_module/types/either.dart';
import 'package:app_pets/app/modules/auth/domain/entities/auth_entity.dart';
import 'package:app_pets/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:app_pets/app/modules/auth/domain/params/login_params.dart';
import 'package:app_pets/app/modules/auth/domain/repositories/login_repostory_interface.dart';
import 'package:app_pets/app/modules/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginRepositoryMock extends Mock implements ILoginRepository {}

void main() {
  late ILoginRepository loginRepository;
  late LoginUseCase loginUseCase;

  late LoginParams params;
  late LoginParams paramsIncorrect;

  setUp(() {
    params = LoginParams(email: 'teste@gmail.com');

    paramsIncorrect = LoginParams(email: 'teste.gmail.com');

    loginRepository = LoginRepositoryMock();
    loginUseCase = LoginUseCase(loginRepository: loginRepository);
  });

  test('should be return AuthEntity', () async {
    when(
      () => loginRepository.login(params: params),
    ).thenAnswer((_) async => right(AuthEntity(email: 'teste1@gmail.com')));

    final result = await loginUseCase(params: params);

    expect(result.fold(id, id), isA<AuthEntity>());
  });

  test('should be return AuthException if email incorrect', () async {
    when(
      () => loginRepository.login(params: paramsIncorrect),
    ).thenThrow(
        (_) async => left(const AuthException(message: 'Email invalido')));

    final result = await loginUseCase(params: paramsIncorrect);

    expect(result.fold(id, id), isA<AuthException>());
  });
}
