# Minecraft Server Info

A Dart package for retrieving information about Minecraft servers.

## Usage

```dart
import 'package:minecraft_server_info/minecraft_server_info.dart';

void main() async {
  try {
    var serverInfo = await MinecraftServerInfo.get(
      host: 'mc.hypixel.net',
      port: 25565,
      timeout: const Duration(seconds: 10),
    );
    print('Server is online: ${serverInfo.isOnline}');
    if (serverInfo.isOnline) {
      print('Current players: ${serverInfo.players}');
      print('Max players: ${serverInfo.maxPlayers}');
      print('MOTD: ${serverInfo.motd}');
      print('gameType: ${serverInfo.gameType}');
      print('ServerId: ${serverInfo.serverId}');
      print('version: ${serverInfo.version}');
      print('software: ${serverInfo.software}');
    }
  } on ServerTimeoutException {
    print('Server did not respond within the specified timeout period.');
  } catch (e) {
    print('An error occurred: $e');
  }
}
```

## Features

- Retrieve information about Minecraft servers, including whether the server is online or offline, the current number of players, the maximum number of players, the MOTD, version, software, serverId, gameType,
- Built-in timeout handling in case the server does not respond within the specified period.
- Lightweight and easy to use.

## Methods

### `get`

Sends a ping packet to the specified server and returns information about the server.

Throws a `ServerTimeoutException` if the server does not respond within the specified `timeout` period.

```dart
static Future<PongData> get({
    required String host,
    required int port,
    Duration timeout = const Duration(seconds: 10),
})
```

### `getUrl`

Get information about the server by url "<host>:<port>".

```dart
static Future<PongData> getUrl(String url)
```

## Installation

To use this package, add `minecraft_server_info` as a [dependency in your `pubspec.yaml` file](https://flutter.dev/docs/development/packages-and-plugins/using-packages).