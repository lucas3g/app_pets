abstract class AuthValidor {
  static bool validateEmail({required String email}) {
    return email.contains('@');
  }
}
