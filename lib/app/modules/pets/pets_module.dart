import 'package:app_pets/app/modules/pets/domain/repositories/pets_repository_interface.dart';
import 'package:app_pets/app/modules/pets/domain/usecases/get_pets_usecase.dart';
import 'package:app_pets/app/modules/pets/external/datasources/get_pets_datasource.dart';
import 'package:app_pets/app/modules/pets/infra/datasources/pets_datasources_interface.dart';
import 'package:app_pets/app/modules/pets/infra/repositories/pets_repository.dart';
import 'package:app_pets/app/modules/pets/presenter/blocs/pets_bloc.dart';
import 'package:app_pets/app/modules/pets/presenter/pets_page.dart';
import 'package:app_pets/app/modules/pets/presenter/widgets/detail_pets_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PetsModule extends Module {
  @override
  final List<Bind> binds = [
    //DATASOURCES
    Bind.factory<IPetsDataSource>(
      (i) => GetPetsDataSource(clientHttp: i()),
    ),

    //REPOSITORIES
    Bind.factory<IPetsRepository>(
      (i) => PetsReposistory(petsDataSource: i()),
    ),

    //USECASES
    Bind.factory<IGetPetsUseCase>(
      (i) => GetPetsUseCase(petsRepository: i()),
    ),

    //BLOC
    Bind.factory<PetsBloc>(
      (i) => PetsBloc(getPetsUseCase: i(), localStorage: i()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => PetsPage(
            petsBloc: Modular.get<PetsBloc>(),
          )),
    ),
    ChildRoute(
      '/detail',
      child: (context, args) => const DetailPetPage(),
    ),
  ];
}
