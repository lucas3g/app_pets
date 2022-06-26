import 'package:app_pets/app/core_module/types/either.dart';
import 'package:app_pets/app/modules/pets/domain/entities/pets_entity.dart';
import 'package:app_pets/app/modules/pets/domain/repositories/pets_repository_interface.dart';
import 'package:app_pets/app/modules/pets/domain/usecases/get_pets_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class PetsRepositoryMock extends Mock implements IPetsRepository {}

void main() {
  late IPetsRepository petsRepository;
  late GetPetsUseCase getPetsUseCase;

  setUp(() {
    petsRepository = PetsRepositoryMock();
    getPetsUseCase = GetPetsUseCase(petsRepository: petsRepository);
  });

  test('should return list of PetsEntity', () async {
    when(
      () => petsRepository.getPets(),
    ).thenAnswer((_) async => right(<PetsEntity>[]));

    final result = await getPetsUseCase();

    expect(result.fold(id, id), isA<List<PetsEntity>>());
  });
}
