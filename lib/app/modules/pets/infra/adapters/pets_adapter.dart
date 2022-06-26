import 'package:app_pets/app/modules/pets/domain/entities/pets_entity.dart';

class PetsAdapter {
  static PetsEntity fromMap(dynamic map) {
    return PetsEntity(
      breed: map['breed'],
      lifeSpan: map['life_span'],
      imageDog: map['image']['url'],
      temperament: map['temperament'],
      bredFor: map['bred_for'],
      origin: map['origin'],
    );
  }
}
