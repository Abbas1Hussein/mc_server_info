import 'package:mc_server_info/mc_server_info.dart';

void main() async {
  try {
    var serverInfo = await MinecraftServerInfo.getUrl(
      'Dgkgnkf.aternos.me:52553',
    );
    print('server status ${serverInfo.isOnline}');
    if (serverInfo.isOnline) {
      print(serverInfo.toString());
    }
  } on ServerTimeoutException {
    print('Server did not respond within the specified timeout period.');
  } catch (e) {
    print('An error occurred: $e');
  }
}
