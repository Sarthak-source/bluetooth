// lib/redux-store/reducers/home_reducers.dart
import 'package:first_project/redux-store/actions/home_actions.dart';
import 'package:first_project/redux-store/models/home_state.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// Reducer function for the home page state
HomePageState homeReducer(HomePageState state, dynamic action) { // Change the parameter type to HomePageState
  if (action is AddDeviceAction) {
    // Handle adding a device to the devicesList
    final updatedDevicesList = List<BluetoothDevice>.from(state.devicesList);
    updatedDevicesList.add(action.device);
    
    return state.copyWith(devicesList: updatedDevicesList);
  } else if (action is ConnectDeviceAction) {
    // Handle connecting a device
    return state.copyWith(connectedDevice: action.device);
  } else if (action is UpdateServicesAction) {
    // Handle updating services for a connected device
    return state.copyWith(services: action.services);
  } else if (action is UpdateReadValuesAction) {
    // Handle updating read values for a characteristic
    final updatedReadValues = Map<Guid, List<int>>.from(state.readValues);
    updatedReadValues[action.uuid] = action.value;
    
    return state.copyWith(readValues: updatedReadValues);
  }
  
  // Return the original state if no action matches
  return state;
}
