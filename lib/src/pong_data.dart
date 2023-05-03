import 'dart:convert';

/// A class that represents the data contained in a Minecraft server pong packet.
class ServerModel {
  /// Indicates whether the Minecraft server is online (true) or offline (false).
  bool isOnline;

  /// The game type of the Minecraft server.
  String gameType;

  /// The message of the day of the Minecraft server.
  String motd;

  /// The number of players currently connected to the Minecraft server.
  int players;

  /// The maximum number of players allowed on the Minecraft server.
  int maxPlayers;

  /// The unique identifier of the Minecraft server.
  String serverId;

  /// The software of the Minecraft server.
  String software;

  /// The version of the Minecraft server.
  String version;

  ServerModel({
    required this.isOnline,
    this.gameType = "",
    this.serverId = "",
    this.software = "",
    this.motd = "",
    this.version = "",
    this.players = 0,
    this.maxPlayers = 0,
  });

  /// A factory constructor that creates a [ServerModel] instance from a list of bytes.
  factory ServerModel.fromBytes(List<int> bytes) {
    var split = utf8.decode(bytes, allowMalformed: true).split(";");
    if (split.length > 5) {
      final statusServer = split[1].toLowerCase().contains('offline') ? false : true;
      return ServerModel(
        isOnline: statusServer,
        motd: utf8.decode(split[1].codeUnits, allowMalformed: true),
        version: split[3],
        players: int.parse(split[4]),
        maxPlayers: int.parse(split[5]),
        serverId: split.length > 6 ? split[6] : "",
        software: split.length > 7 ? split[7] : "",
        gameType: split.length > 8 ? split[8] : "",
      );
    }
    return ServerModel(isOnline: false);
  }

  /// A method that returns a string representation of the [ServerModel] instance.
  @override
  String toString() {
    return 'motd:$motd;version:$version;players:$players;maxPlayers:$maxPlayers;serverId:$serverId;software:$software;gameType:$gameType;'
        .split(';')
        .join('\n');
  }
}
