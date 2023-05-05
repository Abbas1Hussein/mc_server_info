import 'package:mc_server_info/mc_server_info.dart';

void main() async {
  try {
    var serverInfo = await MinecraftServerInfo.get(
      host: 'bedrock.jartex.fun',
      port: 19132,
      timeout: const Duration(seconds: 10),
    );
    print('Server is online: ${serverInfo.isOnline}');
    if (serverInfo.isOnline) {
      print('Current players: ${serverInfo.players}');
      print('Max players: ${serverInfo.maxPlayers}');
      print('gameType: ${serverInfo.gameType}');
      print('ServerId: ${serverInfo.serverId}');
      print('version: ${serverInfo.version}');
      print('software: ${serverInfo.software}');
    }
  } on ServerTimeOutException catch (e) {
    print('Server did not respond within the specified timeout period: $e');
  } on HostException catch (e) {
    print('Invalid host: $e');
  } catch (e) {
    print('An error occurred: $e');
  }
}

