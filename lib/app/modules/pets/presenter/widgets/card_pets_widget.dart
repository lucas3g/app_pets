import 'package:app_pets/app/modules/pets/domain/entities/pets_entity.dart';
import 'package:app_pets/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardPetsWidget extends StatelessWidget {
  final PetsEntity pets;
  final int index;
  const CardPetsWidget({Key? key, required this.pets, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.colors.primary),
      ),
      child: ListTile(
        onTap: () async {
          await Modular.to.pushNamed('/pets/detail',
              arguments: {'pet': pets, 'index': index});
        },
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(pets.imagePet),
        ),
        title: Text('Breed: ${pets.breed}'),
        subtitle: Text('Life Span: ${pets.lifeSpan}'),
      ),
    );
  }
}
