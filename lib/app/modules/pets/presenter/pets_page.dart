import 'dart:async';

import 'package:app_pets/app/modules/pets/presenter/blocs/events/pets_events.dart';
import 'package:app_pets/app/modules/pets/presenter/blocs/pets_bloc.dart';
import 'package:app_pets/app/modules/pets/presenter/blocs/states/pets_states.dart';
import 'package:app_pets/app/theme/app_theme.dart';
import 'package:app_pets/app/utils/constants.dart';
import 'package:app_pets/app/utils/loading_widget.dart';
import 'package:app_pets/app/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PetsPage extends StatefulWidget {
  final PetsBloc petsBloc;
  const PetsPage({Key? key, required this.petsBloc}) : super(key: key);

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  late StreamSubscription sub;
  final filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.petsBloc.add(GetPetsAPIEvent());

    sub = widget.petsBloc.stream.listen((state) {
      if (state is PetsErrorState) {
        MySnackBar(message: state.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pets for adoption',
          style: AppTheme.textStyles.appBar,
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'List of pets',
              style: AppTheme.textStyles.titleList,
            ),
            const Divider(),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: filterController,
              onChanged: (value) {
                widget.petsBloc.add(PetsFilterLocalEvent(value: value));
              },
              decoration: InputDecoration(
                counterText: '',
                hintText: 'Search by breed',
                label: const Text('Breed'),
                filled: true,
                isDense: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade700,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppTheme.colors.primary,
                  ),
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder<PetsBloc, PetsStates>(
                  bloc: widget.petsBloc,
                  builder: (context, state) {
                    if (state is! PetsSuccessState) {
                      return LoadingWidget(
                          size: Size(context.screenHeight, 200), radius: 10);
                    }

                    final pets = (state).filtredList;

                    if (pets.isEmpty) {
                      return const Center(
                        child: Text('Empty data'),
                      );
                    }

                    return ListView.separated(
                      itemBuilder: (_, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppTheme.colors.primary),
                          ),
                          child: ListTile(
                            onTap: () async {
                              await Modular.to.pushNamed('/pets/detail',
                                  arguments: {
                                    'pet': pets[index],
                                    'index': index
                                  });
                            },
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  NetworkImage(pets[index].imagePet),
                            ),
                            title: Text('Breed: ${pets[index].breed}'),
                            subtitle:
                                Text('Life Span: ${pets[index].lifeSpan}'),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemCount: pets.length,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
