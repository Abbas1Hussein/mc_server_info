import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:udp/udp.dart';

import 'server_model.dart';
import 'utils/exceptions.dart';
import 'utils/unconnected_constant.dart';
import 'utils/utils.dart';

/// A class for retrieving Minecraft server information.
class MinecraftServerInfo {
  MinecraftServerInfo._();

  /// Sends a ping packet to the specified server and returns information about the server.
  ///
  /// Throws a [ServerTimeOutException] if the server does not respond within the specified [timeout] period.
  static Future<ServerModel> get({
    required String host,
    required int port,
    Duration timeout = const Duration(seconds: 5),
  }) async {
    try {
      // Bind a UDP socket to any available endpoint
      UDP? sendSocket = await UDP.bind(Endpoint.any());

      // Send the ping packet to the server
      sendSocket.send(_buildPingPacket(), await Utils.hostLookup(host, port));

      // Wait for a response from the server
      final Datagram? rawPong = await sendSocket.asStream().first.timeout(
        timeout,
        onTimeout: () => throw ServerTimeOutException(),
      );
      // Close the UDP socket
      sendSocket.close();
      sendSocket = null;
      // Parse the raw response into a PongData object
      return ServerModel.fromBytes((rawPong)!.data);
    } on SocketException catch(e) {
      throw HostException();
    }
  }

  /// get information about the server by url "<host>:<port>".
  static Future<ServerModel> getUrl(
    String url, [
    Duration timeout = const Duration(seconds: 5),
  ]) async {
    final data = url.split(':');
    if (data.length == 2) {
      return await get(host: data.first, port: int.parse(data.last), timeout: timeout);
    }
    throw Exception('The Port must be input');
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
