import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class HomePageState {
  final List<BluetoothDevice> devicesList;
  final Map<Guid, List<int>> readValues;
  final BluetoothDevice? connectedDevice;
  final List<BluetoothService> services;
  late StreamController<List<BluetoothDevice>> _devicesListController; // Add this line

  HomePageState({
    required this.devicesList,
    required this.readValues,
    required this.connectedDevice,
    required this.services,
  }) {
    _devicesListController = StreamController<List<BluetoothDevice>>.broadcast(); // Initialize the stream controller
  }

  Stream<List<BluetoothDevice>> get devicesListStream => _devicesListController.stream; // Define the devicesListStream getter

  factory HomePageState.initialState() {
    return HomePageState(
      devicesList: [],
      readValues: {},
      connectedDevice: null,
      services: [],
    );
  }

  HomePageState copyWith({
    List<BluetoothDevice>? devicesList,
    Map<Guid, List<int>>? readValues,
    BluetoothDevice? connectedDevice,
    List<BluetoothService>? services,
  }) {
    return HomePageState(
      devicesList: devicesList ?? this.devicesList,
      readValues: readValues ?? this.readValues,
      connectedDevice: connectedDevice ?? this.connectedDevice,
      services: services ?? this.services,
    );
  }
}
