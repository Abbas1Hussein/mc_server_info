import 'package:mc_server_info/mc_server_info.dart';
import 'package:test/test.dart';

void main() {
  getMCServerInfoAndPrint(String url) async {
    final response = await MinecraftServerInfo.getUrl(url);
    print('----------------- $url -----------------------');
    print(response.toString());
  }

  test(
    'Test on real server list', () async {
      await getMCServerInfoAndPrint('bedrock.jartex.fun:19132');

      await getMCServerInfoAndPrint('buzz.fadecloud.com:19132');

      await getMCServerInfoAndPrint('play.cosmicpe.me:19132');

      await getMCServerInfoAndPrint('ecpehub.net:19132');

      await getMCServerInfoAndPrint('grandtheft.mcpe.me:19132');

      await getMCServerInfoAndPrint('geyser.pixelblockmc.com:19132');

      await getMCServerInfoAndPrint('lobby.nethergames.org:19132');

      await getMCServerInfoAndPrint('play.inpvp.net:19132');
    },
    timeout: Timeout(Duration(seconds: 3)),
  );

  test('Test server info', () async {
    final response = await MinecraftServerInfo.getUrl('bedrock.jartex.fun:19132');
    expect(response.version, isNotNull);
    expect(response.players, isPositive);
    expect(response.maxPlayers, isPositive);
    expect(response.gameType, isNotNull);
    expect(response.serverId, isNotNull);
    expect(response.software, isNotNull);
    expect(response.isOnline, isNotNull);
  });

  test('Test invalid server', () async {
    try {
      await MinecraftServerInfo.getUrl('invalid.server.com:19132');
    } catch (e) {
      expect(
        e,
        isA<HostException>(),
        reason: 'Expected HostException when connecting to invalid server',
      );
    }
  });

  test('Test offline server', () async {
    try {
      await MinecraftServerInfo.getUrl('Dgkgnkf.aternos.me:52553');
    } catch (e) {
      expect(
        e,
        isA<ServerTimeOutException>(),
        reason: 'Expected ServerTimeOutException when connecting to offline server',
      );
    }
  });
}
