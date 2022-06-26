import 'package:app_pets/app/modules/pets/domain/entities/pets_entity.dart';

class PetsAdapter {
  static PetsEntity fromMap(dynamic map) {
    return PetsEntity(
      breed: map['name'] ?? '',
      lifeSpan: map['life_span'] ?? '',
      imagePet: map['image']?['url'] ?? '',
      temperament: map['temperament'] ?? '',
      bredFor: map['bred_for'] ?? '',
      origin: map['origin'] ?? '',
    );
  }
}
