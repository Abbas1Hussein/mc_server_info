import 'package:mc_server_info/mc_server_info.dart';

void main() async {
  try {
    var serverInfo = await MinecraftServerInfo.getUrl('play.cosmicpe.me:19132');
    print('server status ${serverInfo.isOnline}');
    if (serverInfo.isOnline) {
      print(serverInfo.toString());
    }
  } on ServerTimeOutException {
    print('Server did not respond within the specified timeout period.');
  } catch (e) {
    print('An error occurred: $e');
  }
}
