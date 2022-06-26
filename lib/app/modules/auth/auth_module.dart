import 'package:app_pets/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:app_pets/app/modules/auth/domain/repositories/login_repostory_interface.dart';
import 'package:app_pets/app/modules/auth/domain/usecases/login_usecase.dart';
import 'package:app_pets/app/modules/auth/external/datasources/login_datasource.dart';
import 'package:app_pets/app/modules/auth/infra/datasources/login_datasource_interface.dart';
import 'package:app_pets/app/modules/auth/infra/repositories/login_repository.dart';
import 'package:app_pets/app/modules/auth/presenter/auth_page.dart';
import 'package:app_pets/app/modules/auth/presenter/blocs/auth_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    //DATASOURCES
    Bind.factory<ILoginDataSource>(
      (i) => LoginDataSource(clientHttp: i()),
    ),

    //REPOSITORIES
    Bind.factory<ILoginRepository>(
      (i) => LoginRepository(loginDataSource: i()),
    ),

    //USECASES
    Bind.factory<ILoginUseCase>(
      (i) => LoginUseCase(loginRepository: i()),
    ),

    //BLOC
    Bind.factory<AuthBloc>(
      (i) => AuthBloc(loginUseCase: i()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => AuthPage(
            authBloc: Modular.get<AuthBloc>(),
            localStorage: Modular.get<ILocalStorage>(),
          )),
    ),
  ];
}
