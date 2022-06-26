import 'package:app_pets/app/core_module/types/either.dart';
import 'package:app_pets/app/modules/pets/domain/entities/pets_entity.dart';
import 'package:app_pets/app/modules/pets/infra/datasources/pets_datasources_interface.dart';
import 'package:app_pets/app/modules/pets/infra/repositories/pets_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class PetsDataSourceMock extends Mock implements IPetsDataSource {}

void main() {
  late IPetsDataSource petsDataSource;
  late PetsReposistory petsReposistory;

  setUp(() {
    petsDataSource = PetsDataSourceMock();
    petsReposistory = PetsReposistory(petsDataSource: petsDataSource);
  });

  test('should return list of PetsEntity', () async {
    when(
      () => petsDataSource.getPets(),
    ).thenAnswer((_) async => <PetsEntity>[]);

    final result = await petsReposistory.getPets();

    expect(result.fold(id, id), isA<List<PetsEntity>>());
  });
}
