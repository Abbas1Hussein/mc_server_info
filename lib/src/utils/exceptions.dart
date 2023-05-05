class ServerTimeOutException implements Exception {
  final String _message;

  ServerTimeOutException([
    this._message = "Server did not reply in time.?",
  ]);

  @override
  String toString() => "ServerTimeOutException: $_message";
}

class HostException implements Exception {
  final String _message;

  HostException([
    this._message = "No such host is known.",
  ]);

  @override
  String toString() => "HostException: $_message";
}