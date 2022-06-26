import 'package:app_pets/app/core_module/constants/constants.dart';
import 'package:app_pets/app/core_module/services/client_http/client_http_interface.dart';
import 'package:app_pets/app/modules/pets/infra/datasources/pets_datasources_interface.dart';

class PetsDataSource implements IPetsDataSource {
  final IClientHttp clientHttp;

  PetsDataSource({
    required this.clientHttp,
  });

  @override
  Future<List> getPets() async {
    clientHttp.setBaseUrl(baseURLDogs);

    final resultDogs = await clientHttp.get('/breeds');

    clientHttp.setBaseUrl(baseURLCats);

    final resultCats = await clientHttp.get('/breeds');

    final List<dynamic> listPets = [...resultDogs.data, ...resultCats.data];

    return listPets;
  }
}
