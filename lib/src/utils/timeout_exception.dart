class ServerTimeoutException implements Exception {
  final String _message;

  ServerTimeoutException([
    this._message = "Server did not reply in time. Is it offline?",
  ]);

  @override
  String toString() => "ServerTimeoutException: $_message";
}
