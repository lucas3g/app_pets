abstract class IPetsException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IPetsException({
    required this.message,
    this.stackTrace,
  });
}

class PetsException extends IPetsException {
  const PetsException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
