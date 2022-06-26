import 'package:app_pets/app/core_module/services/client_http/client_http_interface.dart';
import 'package:app_pets/app/modules/auth/infra/datasources/login_datasource_interface.dart';

class LoginDataSource implements ILoginDataSource {
  final IClientHttp clientHttp;

  LoginDataSource({
    required this.clientHttp,
  });

  @override
  Future login({required String email}) async {
    clientHttp.setBaseUrl('https://mocki.io/v1/');
    final response =
        await clientHttp.get('/54429d0e-f9e6-4340-8fba-fb20eb2112e7');

    final value = List.from(response.data).toList();

    final result = value.firstWhere(
      (e) => e['email'] == email,
      orElse: () => '',
    );

    if (result.isNotEmpty) {
      return result;
    }

    return '';
  }
}
