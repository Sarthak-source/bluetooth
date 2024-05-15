// lib/redux-store/actions/home_actions.dart
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// Action to add a device to the devices list
class AddDeviceAction {
  final BluetoothDevice device;

  AddDeviceAction(this.device);
}

// Action to connect a device
class ConnectDeviceAction {
  final BluetoothDevice device;

  ConnectDeviceAction(this.device);
}

// Action to update services for a connected device
class UpdateServicesAction {
  final List<BluetoothService> services;

  UpdateServicesAction(this.services);
}

// Action to update read values for a characteristic
class UpdateReadValuesAction {
  final Guid uuid;
  final List<int> value;

  UpdateReadValuesAction(this.uuid, this.value);
}
