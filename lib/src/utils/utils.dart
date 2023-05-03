import 'dart:io';

import 'package:udp/udp.dart';

enum EndianType {
  littleEndian,
  bigEndian,
}

/// A utility class that provides common functionality used in the library.
class Utils {
  /// Looks up the host with the given [host] and [port], and returns an [Endpoint] object.
  ///
  /// Throws an [ArgumentError] if the [port] is not between 1 and 65535.
  static Future<Endpoint> hostLookup(String host, int port) async {
    if (!(1 <= port && 65535 >= port)) {
      throw ArgumentError(
        "Invalid port. Make sure that the port is between 1 and 65535!",
      );
    }
    final firstHost = (await InternetAddress.lookup(host, type: InternetAddressType.IPv4))[0];

    return Endpoint.multicast(firstHost, port: Port(port));
  }

  /// Encodes the given [n] into a list of bytes with the given [padding] and [endianType].
  ///
  /// [endianType] is optional, and defaults to [EndianType.bigEndian].
  static List<int> encodeEndian(
    int n,
    int padding, {
    endianType = EndianType.bigEndian,
  }) {
    final filledBytes = n.bitLength ~/ 8 + ((n.bitLength % 8 > 0) ? 1 : 0);

    List<int> builderList = <int>[];
    for (int i = 0; i < filledBytes; i++) {
      builderList.add(n & 255);
      n >>= 8;
    }

    if (padding > filledBytes) {
      builderList.addAll(List.filled(padding - filledBytes, 0));
    }

    return endianType == EndianType.bigEndian
        ? builderList
        : (builderList.reversed as List<int>);
  }
}
