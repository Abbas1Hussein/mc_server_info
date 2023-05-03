import 'dart:io';
import 'dart:math';

import 'package:udp/udp.dart';

import 'pong_data.dart';
import 'utils/timeout_exception.dart';
import 'utils/unconnected_constant.dart';
import 'utils/utils.dart';

/// A class for retrieving Minecraft server information.
class MinecraftServerInfo {
  MinecraftServerInfo._();

  /// Sends a ping packet to the specified server and returns information about the server.
  ///
  /// Throws a [ServerTimeoutException] if the server does not respond within the specified [timeout] period.
  static Future<ServerModel> get({
    required String host,
    required int port,
    int timeout = 10,
  }) async {
    // Bind a UDP socket to any available endpoint
    UDP sendSocket = await UDP.bind(Endpoint.any());

    // Send the ping packet to the server
    sendSocket.send(_buildPingPacket(), await Utils.hostLookup(host, port));

    // Wait for a response from the server
    var rawPong = await (sendSocket
        .asStream()
        .timeout(Duration(seconds: timeout),
            onTimeout: (_) => throw ServerTimeoutException())
        .first);


    // Close the UDP socket
    sendSocket.close();

    // Parse the raw response into a PongData object
    return ServerModel.fromBytes((rawPong)!.data);
  }

  /// get information about the server by url "<host>:<port>".
  static Future<ServerModel> getUrl(String url) async {
    final data = url.split(':');
    return await get(host: data.first, port: int.tryParse(data.last) ?? 25565);
  }

  /// Builds a ping packet to send to the server.
  static List<int> _buildPingPacket() {
    final builder = BytesBuilder();

    // Add the unconnected ping ID and other required bytes
    builder.addByte(UnconnectedConstants.unconnectedPingId);
    builder.add(UnconnectedConstants.empty8Bytes);
    builder.add(UnconnectedConstants.unconnectedMagic);

    // Add two random 32-bit integers for the client ID
    builder
        .add(Utils.encodeEndian(Random.secure().nextInt(pow(2, 32) as int), 4));
    builder
        .add(Utils.encodeEndian(Random.secure().nextInt(pow(2, 32) as int), 4));

    return builder.toBytes();
  }
}
