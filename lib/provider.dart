import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VISS {
  static const requestId = "flutter-gsoc-app";
  static const String vehicleSpeed = "Vehicle.Speed";
  static const String kuksaAuthToken = "Vehicle.Speed";

  static void init(WebSocket socket, WidgetRef ref) {
    authorize(socket, ref);
    subscribe(socket, ref, vehicleSpeed);
    update(socket, ref);
  }

  static void update(WebSocket socket, WidgetRef ref) {
    get(socket, ref, vehicleSpeed);
  }

  static void authorize(WebSocket socket, WidgetRef ref) {
    Map<String, dynamic> map = {
      "action": "authorize",
      "tokens": kuksaAuthToken,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void get(WebSocket socket, WidgetRef ref, String path) {
    Map<String, dynamic> map = {
      "action": "get",
      "tokens": kuksaAuthToken,
      "path": path,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void set(WebSocket socket, WidgetRef ref, String path, String value) {
    Map<String, dynamic> map = {
      "action": "set",
      "tokens": kuksaAuthToken,
      "path": path,
      "requestId": requestId,
      "value": value
    };
    socket.add(jsonEncode(map));
  }

  static void subscribe(WebSocket socket, WidgetRef ref, String path) {
    Map<String, dynamic> map = {
      "action": "subscribe",
      "tokens": kuksaAuthToken,
      "path": path,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void parseData(WidgetRef ref, String data) {
    final vehicleSignal = ref.read(speedProvider.notifier);

    Map<String, dynamic> dataMap = jsonDecode(data);
    if (dataMap["action"] == "subscription" || dataMap["action"] == "get") {
      if (dataMap.containsKey("data")) {
        if ((dataMap["data"] as Map<String, dynamic>).containsKey("dp") &&
            (dataMap["data"] as Map<String, dynamic>).containsKey("path")) {
          String path = dataMap["data"]["path"];
          Map<String, dynamic> dp = dataMap["data"]["dp"];
          if (dp.containsKey("value")) {
            if (dp["value"] != "---") {
              switch (path) {
                case vehicleSpeed:
                  vehicleSignal.update(speed: double.parse(dp["value"]));
                  break;
                default:
                  print("$path Not Available yet!");
              }
            } else {
              print("ERROR:Value not available yet! Set Value of $path");
            }
          } else {
            print("ERROR:'value': Key not found!");
          }
        } else if ((!dataMap["data"] as Map<String, dynamic>)
            .containsKey("path")) {
          print("ERROR:'path':key not found !");
        } else if ((dataMap["data"] as Map<String, dynamic>)
            .containsKey("dp")) {
          print("ERROR:'dp':key not found !");
        }
      } else {
        print("ERROR:'data':key not found!");
      }
    }
  }
}

final speedProvider = StateNotifierProvider<VehicleNotifier, Vehicle>(
  (ref) => VehicleNotifier(),
);

class VehicleNotifier extends StateNotifier<Vehicle> {
  VehicleNotifier() : super(_initialValue);
  static final Vehicle _initialValue = Vehicle(
    speed: 160,
  );
  void update({
    double? speed,
  }) {
    state = state.copyWith(
      speed: speed,
    );
  }
}

class Vehicle {
  final double speed;
  Vehicle({
    required this.speed,
  });

  Vehicle copyWith({
    double? speed,
  }) {
    return Vehicle(
      speed: speed ?? (this.speed),
    );
  }
}
