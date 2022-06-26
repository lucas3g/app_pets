import 'package:app_pets/app/core_module/types/either.dart';
import 'package:app_pets/app/modules/pets/domain/entities/pets_entity.dart';
import 'package:app_pets/app/modules/pets/domain/exceptions/pets_exception.dart';
import 'package:app_pets/app/modules/pets/domain/repositories/pets_repository_interface.dart';
import 'package:app_pets/app/modules/pets/infra/adapters/pets_adapter.dart';
import 'package:app_pets/app/modules/pets/infra/datasources/pets_datasources_interface.dart';

class PetsReposistory implements IPetsRepository {
  final IPetsDataSource petsDataSource;

  PetsReposistory({
    required this.petsDataSource,
  });

  @override
  Future<Either<IPetsException, List<PetsEntity>>> getPets() async {
    try {
      final response = await petsDataSource.getPets();

      late List<PetsEntity> result = [];

      for (var item in response) {
        result.add(PetsAdapter.fromMap(item));
      }

      return right(result);
    } on PetsException catch (e) {
      return left(e);
    } catch (e) {
      return left(PetsException(message: e.toString()));
    }
  }
}
