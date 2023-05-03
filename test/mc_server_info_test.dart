import 'package:mc_server_info/mc_server_info.dart';
import 'package:test/test.dart';

void main() {
  /// https://minecraftservers.org/index/1
  _getMCServerInfoAndPrint(String url) async {
    final response = await MinecraftServerInfo.getUrl(url);
    print('----------------------------------------');
    print(response.toString());
    print('----------------------------------------');
  }

  test(
    'Test on real server list',
    () async {
      await _getMCServerInfoAndPrint('play.cosmicpe.me:19132');

      await _getMCServerInfoAndPrint('ecpehub.net:19132');

      await _getMCServerInfoAndPrint('grandtheft.mcpe.me:19132');

      await _getMCServerInfoAndPrint('geyser.pixelblockmc.com:19132');

      await _getMCServerInfoAndPrint('bedrock.jartex.fun:19132');

      await _getMCServerInfoAndPrint('lobby.nethergames.org:19132');

      await _getMCServerInfoAndPrint('play.inpvp.net:19132');

      await _getMCServerInfoAndPrint('hub.opblocks.com');

      },
    timeout: Timeout(Duration(seconds: 30)),
  );
}
