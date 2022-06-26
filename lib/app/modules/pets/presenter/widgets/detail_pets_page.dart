import 'package:app_pets/app/modules/pets/domain/entities/pets_entity.dart';
import 'package:app_pets/app/theme/app_theme.dart';
import 'package:app_pets/app/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailPetPage extends StatefulWidget {
  const DetailPetPage({Key? key}) : super(key: key);

  @override
  State<DetailPetPage> createState() => _DetailPetPageState();
}

class _DetailPetPageState extends State<DetailPetPage> {
  final PetsEntity pet = Modular.args.data['pet'];
  final int index = Modular.args.data['index'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pet.breed,
          style: AppTheme.textStyles.appBar,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: context.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: pet.imagePet,
                width: context.screenWidth * 0.5,
                errorWidget: (_, __, ___) {
                  return Icon(
                    Icons.error_outline_rounded,
                    color: AppTheme.colors.primary,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Temperament: ${pet.temperament}',
            ),
            Text(
              'Origin: ${pet.origin}',
            )
          ],
        ),
      ),
    );
  }
}
