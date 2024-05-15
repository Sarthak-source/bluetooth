// Define the state for the home page
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class HomePageState {
  final List<BluetoothDevice> devicesList;
  final Map<Guid, List<int>> readValues;
  final BluetoothDevice? connectedDevice;
  final List<BluetoothService> services;

  HomePageState({
    required this.devicesList,
    required this.readValues,
    required this.connectedDevice,
    required this.services,
  });

  // Initial state for the home page
  factory HomePageState.initialState() {
    return HomePageState(
      devicesList: [],
      readValues: {},
      connectedDevice: null,
      services: [],
    );
  }

  // Implement copyWith method
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
