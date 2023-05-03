/// Constants used for unconnected ping/pong packets.
class UnconnectedConstants {
  /// Magic bytes that start a unconnected ping/pong packet.
  static const unconnectedMagic = [
    0,
    -1,
    -1,
    0,
    -2,
    -2,
    -2,
    -2,
    -3,
    -3,
    -3,
    -3,
    18,
    52,
    86,
    120
  ];

  /// Empty 8-byte array used for padding in unconnected ping/pong packets.
  static const empty8Bytes = [0, 0, 0, 0, 0, 0, 0, 0];

  /// ID used to identify an unconnected ping packet.
  static const unconnectedPingId = 0x01;

  /// ID used to identify an unconnected pong packet.
  static const unconnectedPongId = 0x1C;
}
