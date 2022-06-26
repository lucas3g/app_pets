abstract class PetsEvents {}

class GetPetsAPIEvent extends PetsEvents {}

class PetsFilterLocalEvent extends PetsEvents {
  final String value;

  PetsFilterLocalEvent({
    required this.value,
  });
}

class AuthLogOutEvent extends PetsEvents {}
