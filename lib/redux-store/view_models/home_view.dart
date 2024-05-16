import 'dart:async';
import 'dart:developer';

import 'package:first_project/redux-store/actions/home_actions.dart';
import 'package:first_project/redux-store/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:redux/redux.dart';

class HomeViewModel with ChangeNotifier {
  final List<BluetoothDevice> devicesList;
  BluetoothDevice? connectedDevice;
  final List<BluetoothService> services;
  final Map<Guid, List<int>> readValues;
  final Function(BluetoothDevice) addDevice;
  final Function(BluetoothDevice) connectDevice;
  final Store<AppState> store;
  final BuildContext context;
  bool isLoading;
  bool hasError;
  String error;
  late StreamController<List<BluetoothDevice>> _devicesListController;

  HomeViewModel({
    required this.devicesList,
    required this.connectedDevice,
    required this.services,
    required this.readValues,
    required this.addDevice,
    required this.connectDevice,
    required this.store,
    required this.context,
    this.isLoading = false,
    this.hasError = false,
    this.error = '',
  }) {
    _devicesListController = StreamController<List<BluetoothDevice>>();
    initBluetooth();
  }

  Stream<List<BluetoothDevice>> get devicesListStream =>
      _devicesListController.stream;

  initBluetooth() async {
    Set<String> uniqueDeviceIds = {};

    var subscription = FlutterBluePlus.onScanResults.listen(
      (results) {
        if (results.isNotEmpty) {
          List<BluetoothDevice> newList = [];
          for (ScanResult result in results) {
            if (!uniqueDeviceIds
                .contains(result.device.remoteId.str.toString())) {
              log("result.device.advName ${result.device.advName}");
              addDevice(result.device);
              uniqueDeviceIds.add(result.device.remoteId.str.toString());
              newList.add(result.device);
            }
          }
          _devicesListController.add(newList);
        }
      },
      onError: (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      },
    );

    FlutterBluePlus.cancelWhenScanComplete(subscription);

    await FlutterBluePlus.adapterState
        .where((val) => val == BluetoothAdapterState.on)
        .first;

    await FlutterBluePlus.startScan();

    await FlutterBluePlus.isScanning.where((val) => val == false).first;
    FlutterBluePlus.connectedDevices.map((device) {
      if (!uniqueDeviceIds.contains(device.remoteId.str.toString())) {
        addDevice(device);
        uniqueDeviceIds.add(device.remoteId.str.toString());
      }
    });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      isLoading = true;
      notifyListeners();

      await device.connect();
      services.clear();
      services.addAll(await device.discoverServices());

      connectedDevice = device;

      isLoading = false;

     

      
      notifyListeners();
    } catch (e) {
      isLoading = false;
      hasError = true;
      error = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose(); // Invoke the overridden method from ChangeNotifier
    _devicesListController.close();
  }

  factory HomeViewModel.fromStore(Store<AppState> store, BuildContext context) {
    var viewModel = HomeViewModel(
      devicesList: store.state.homePageState.devicesList,
      connectedDevice: store.state.homePageState.connectedDevice,
      services: store.state.homePageState.services,
      readValues: store.state.homePageState.readValues,
      addDevice: (BluetoothDevice device) =>
          store.dispatch(AddDeviceAction(device)),
      connectDevice: (BluetoothDevice device) =>
          store.dispatch(ConnectDeviceAction(device)),
      store: store,
      context: context,
    );

    return viewModel;
  }
}
