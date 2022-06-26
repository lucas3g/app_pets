import 'package:app_pets/app/core_module/services/client_http/client_http_interface.dart';
import 'package:app_pets/app/modules/auth/external/datasources/login_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ClientHttpMock extends Mock implements IClientHttp {}

void main() {
  late IClientHttp clientHttp;
  late LoginDataSource loginDataSource;

  setUp(() {
    clientHttp = ClientHttpMock();
    loginDataSource = LoginDataSource(clientHttp: clientHttp);
  });

  test('should return a Email if found in API', () async {
    when(
      () => clientHttp.get('/login'),
    ).thenAnswer(
      (_) async => BaseResponse(
        baseReponse,
        BaseRequest(url: '/login', method: 'GET'),
      ),
    );

    final result = await loginDataSource.login(email: 'teste@gmail.com');

    expect(result, 'teste@gmail.com');
  });

  test('should return a "" if not found a email in API', () async {
    when(
      () => clientHttp.get('/login'),
    ).thenAnswer(
      (_) async => BaseResponse(
        baseReponse,
        BaseRequest(url: '/login', method: 'GET'),
      ),
    );

    final result = await loginDataSource.login(email: 'teste4@gmail.com');

    expect(result, "");
  });
}

final baseReponse = [
  {"email": "teste@gmail.com"},
  {"email": "teste1@gmail.com"},
  {"email": "teste2@gmail.com"},
  {"email": "teste3@gmail.com"},
];
