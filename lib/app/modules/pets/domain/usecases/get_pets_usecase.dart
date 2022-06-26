import 'package:app_pets/app/core_module/types/either.dart';
import 'package:app_pets/app/modules/pets/domain/entities/pets_entity.dart';
import 'package:app_pets/app/modules/pets/domain/exceptions/pets_exception.dart';
import 'package:app_pets/app/modules/pets/domain/repositories/pets_repository.dart';

abstract class IGetPetsUseCase {
  Future<Either<IPetsException, List<PetsEntity>>> call();
}

class GetPetsUseCase implements IGetPetsUseCase {
  final IPetsRepository petsRepository;

  GetPetsUseCase({
    required this.petsRepository,
  });

  @override
  Future<Either<IPetsException, List<PetsEntity>>> call() async {
    return await petsRepository.getPets();
  }
}
