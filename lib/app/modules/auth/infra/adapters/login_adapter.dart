import 'package:app_pets/app/modules/auth/domain/entities/auth_entity.dart';

class LoginAdapter {
  static AuthEntity fromMap(dynamic map) {
    return AuthEntity(email: map['email']);
  }
}
