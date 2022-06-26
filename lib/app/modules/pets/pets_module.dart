import 'package:app_pets/app/modules/pets/presenter/pets_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PetsModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => const PetsPage()),
    ),
  ];
}
