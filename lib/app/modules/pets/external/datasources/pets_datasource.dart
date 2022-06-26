import 'package:app_pets/app/core_module/services/client_http/client_http_interface.dart';
import 'package:app_pets/app/modules/pets/infra/datasources/pets_datasources_interface.dart';

class PetsDataSource implements IPetsDataSource {
  final IClientHttp clientHttp;

  PetsDataSource({
    required this.clientHttp,
  });

  @override
  Future<List> getPets() async {
    clientHttp.setBaseUrl('https://api.thedogapi.com/v1/');

    final resultDogs = await clientHttp.get('/breeds');

    clientHttp.setBaseUrl('https://api.thecatapi.com/v1/');

    final resultCats = await clientHttp.get('/breeds');

    final List<dynamic> listPets = [];

    listPets.add(resultDogs);
    listPets.add(resultCats);

    return listPets;
  }
}
