import 'dart:async';

import 'package:app_pets/app/core_module/services/shared_preferences/adapters/shared_params.dart';
import 'package:app_pets/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:app_pets/app/modules/auth/domain/params/login_params.dart';
import 'package:app_pets/app/modules/auth/presenter/blocs/auth_bloc.dart';
import 'package:app_pets/app/modules/auth/presenter/blocs/events/auth_events.dart';
import 'package:app_pets/app/modules/auth/presenter/blocs/states/auth_states.dart';
import 'package:app_pets/app/theme/app_theme.dart';
import 'package:app_pets/app/utils/constants.dart';
import 'package:app_pets/app/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

class AuthPage extends StatefulWidget {
  final AuthBloc authBloc;
  final ILocalStorage localStorage;
  const AuthPage({Key? key, required this.authBloc, required this.localStorage})
      : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  GlobalKey<FormState> keyEmail = GlobalKey<FormState>();

  late StreamSubscription sub;

  Future<void> saveLogin() async {
    await widget.localStorage
        .setData(params: SharedParams(key: 'logado', value: 'S'));
  }

  @override
  void initState() {
    super.initState();

    sub = widget.authBloc.stream.listen((state) async {
      if (state is AuthSuccessState) {
        await saveLogin();

        await Future.delayed(const Duration(milliseconds: 500));
        Modular.to.navigate('/pets/');
      }

      if (state is AuthErrorState) {
        MySnackBar(message: state.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: SizedBox(
            height: context.screenHeight * 0.93,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Lottie.asset('assets/images/pet.json', width: 200),
                    Text(
                      'Pets for adoption',
                      style: AppTheme.textStyles.title,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('App access'),
                    const SizedBox(height: 15),
                    Form(
                      key: keyEmail,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: 'Type your e-mail',
                          label: const Text('Email'),
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
                    ),
                    const SizedBox(height: 15),
                    BlocBuilder<AuthBloc, AuthStates>(
                        bloc: widget.authBloc,
                        builder: (context, state) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            width: state is AuthLoadingState ||
                                    state is AuthSuccessState
                                ? 40
                                : context.screenWidth,
                            height: 40,
                            child: GestureDetector(
                              onTap: () {
                                if (!keyEmail.currentState!.validate()) {
                                  return;
                                }
                                widget.authBloc.add(
                                  AuthLoginEvent(
                                    loginParams: LoginParams(
                                      email: emailController.text.trim(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    state is AuthLoadingState ||
                                            state is AuthSuccessState
                                        ? 40
                                        : 10,
                                  ),
                                  color: AppTheme.colors.primary,
                                ),
                                child: state is AuthLoadingState
                                    ? const Center(
                                        child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : state is AuthSuccessState
                                        ? const Icon(
                                            Icons.check_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.login,
                                                color:
                                                    AppTheme.colors.iconLogin,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                'Sign in',
                                                style: AppTheme
                                                    .textStyles.buttonSigin,
                                              ),
                                            ],
                                          ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
