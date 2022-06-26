import 'package:app_pets/app/app_module.dart';
import 'package:app_pets/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:app_pets/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 4));

    await Modular.isModuleReady<AppModule>();

    final localStorage = Modular.get<ILocalStorage>();

    if (localStorage.getData('logado') == 'S') {
      Modular.to.navigate('/pets/');
    } else {
      Modular.to.navigate('/auth/');
    }
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/pet.json',
              repeat: false,
              width: 100,
            ),
            Text(
              'Pets for adoption',
              style: AppTheme.textStyles.title,
            ),
          ],
        ),
      ),
    );
  }
}
