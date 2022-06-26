import 'package:app_pets/app/core_module/services/client_http/client_http_interface.dart';
import 'package:app_pets/app/modules/auth/infra/datasources/login_datasource_interface.dart';

class LoginDataSource implements ILoginDataSource {
  final IClientHttp clientHttp;

  LoginDataSource({
    required this.clientHttp,
  });

  @override
  Future login({required String email}) async {
    final response = await clientHttp.get('/login');

    final value = List.from(response.data).toList();

    final result = value.firstWhere(
      (e) => e['email'] == email,
      orElse: () => '',
    );

    if (result.isNotEmpty) {
      return result['email'];
    }

    return '';
  }
}
