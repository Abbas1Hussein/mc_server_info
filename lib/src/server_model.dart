import 'dart:convert';

/// A class that represents the data contained in a Minecraft server pong packet.
class ServerModel {

  /// Indicates whether the Minecraft server is online (true) or offline (false).
  bool isOnline;

  /// The game type of the Minecraft server.
  String gameType;

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
    this.version = "",
    this.players = 0,
    this.maxPlayers = 0,
  });

  /// A factory constructor that creates a [ServerModel] instance from a list of bytes.
  factory ServerModel.fromBytes(List<int> bytes) {
    var split = utf8.decode(bytes, allowMalformed: true).split(";");
    print(split);
    print(split.length);
    final statusServer = split[1].toLowerCase().contains('offline') ? false : true;
    if (split.length <= 10) {
      return ServerModel(
        isOnline: statusServer,
        version: split[3],
        players: int.parse(split[4]),
        maxPlayers: int.parse(split[5]),
        serverId: split[6],
        software: split[7],
        gameType: split[8],
      );
    }
    if (split.length > 10 && split.length < 13) {
      return ServerModel(
        isOnline: statusServer,
        version: split[4],
        players: int.parse(split[5]),
        maxPlayers: int.parse(split[6]),
        serverId: split[7],
        software: split[8],
        gameType: split[9],
      );
    }
    if (split.length >= 13) {
      return ServerModel(
        isOnline: statusServer,
        version: split[3],
        players: int.parse(split[4]),
        maxPlayers: int.parse(split[5]),
        serverId: split[6],
        software: split[7],
        gameType: split[8],
      );
    }
    return ServerModel(isOnline: false);
  }

  /// A method that returns a string representation of the [ServerModel] instance.
  @override
  String toString() {
    return 'version:$version;players:$players;maxPlayers:$maxPlayers;serverId:$serverId;software:$software;gameType:$gameType;'
        .split(';')
        .join('\n');
  }
}
