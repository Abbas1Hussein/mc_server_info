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
      // CosmicPE
      await _getMCServerInfoAndPrint('play.cosmicpe.me:19132');
      // ECPE
      await _getMCServerInfoAndPrint('ecpehub.net:19132');
      // GrandTheftMCPE
      await _getMCServerInfoAndPrint('grandtheft.mcpe.me:19132');
    },
    timeout: Timeout(Duration(minutes: 1)),
  );
}
