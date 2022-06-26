import 'package:app_pets/app/modules/auth/auth_module.dart';
import 'package:app_pets/app/modules/pets/pets_module.dart';
import 'package:app_pets/app/modules/splash/splash_module.dart';

import 'core_module/core_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Module> imports = [
    CoreModule(),
    SplashModule(),
    AuthModule(),
    PetsModule(),
  ];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/pets', module: PetsModule()),
  ];
}
