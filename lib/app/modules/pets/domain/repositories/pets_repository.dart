import 'package:app_pets/app/core_module/types/either.dart';
import 'package:app_pets/app/modules/pets/domain/entities/pets_entity.dart';
import 'package:app_pets/app/modules/pets/domain/exceptions/pets_exception.dart';

abstract class IPetsRepository {
  Future<Either<IPetsException, List<PetsEntity>>> getPets();
}
