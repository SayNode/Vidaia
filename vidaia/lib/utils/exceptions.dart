class InvalidSeedException implements Exception {
  final String cause;
  InvalidSeedException(this.cause);
  @override
  String toString() {
    return cause;
  }
}