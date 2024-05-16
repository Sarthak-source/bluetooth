import 'dart:developer';

import 'package:first_project/redux-store/models/app_state.dart';
import 'package:first_project/redux-store/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final viewModel = HomeViewModel.fromStore(store, context);

    return StreamBuilder<List<BluetoothDevice>>(
      stream: viewModel.devicesListStream,
      builder: (context, snapshot) {
        log("helleo ${snapshot.data.toString()}");
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            unselectedItemColor: Colors.purple,
            selectedItemColor: Colors.purple,
            currentIndex: 0,
            onTap: (index) {
              // Handle navigation to different screens here
              switch (index) {
                case 0:
                  // Navigate to Home screen
                  // You may implement navigation logic here
                  break;
                case 1:
                  // Navigate to Alerts screen
                  // You may implement navigation logic here
                  break;
                case 2:
                  // Navigate to Recharge screen
                  // You may implement navigation logic here
                  break;
                case 3:
                  // Navigate to User screen
                  // You may implement navigation logic here
                  break;
                default:
              }
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.purple,
                ),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.purple,
                ),
                label: 'Alerts',
              ),
              BottomNavigationBarItem(
                icon: FloatingActionButton(
                  onPressed: () {
                    // Handle floating action button press
                  },
                  backgroundColor: const Color.fromARGB(255, 191, 33, 243),
                  child: const Icon(Icons.bluetooth),
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.currency_rupee,
                  color: Colors.purple,
                ),
                label: 'Recharge',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.purple,
                ),
                label: 'User',
              ),
            ],
          ),
          appBar: AppBar(
            title: const Text('Home Page'),
          ),
          body: Column(
            children: [
              Expanded(
                child: _buildDeviceList(snapshot.data ?? [], viewModel),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDeviceList(
      List<BluetoothDevice> devicesList, HomeViewModel viewModel) {
    if (viewModel.isLoading) {
      // Show a circular progress indicator while loading
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (devicesList.isEmpty) {
      // Show a message when no devices are available
      return const Center(
        child: Text('No devices found'),
      );
    } else {
      return ListView.builder(
        itemCount: devicesList.length,
        itemBuilder: (context, index) {
          final device = devicesList[index];
          return Card(
            child: InkWell(
              onTap: () {
                viewModel.connectToDevice(device);
              },
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(device.platformName.isEmpty
                          ? 'Unknown'
                          : device.platformName),
                      subtitle: Text(device.remoteId.str,style: const TextStyle(fontSize: 12),),
                    ),
                  ),
                  IconButton(
                    icon: viewModel.isLoading? const Icon(Icons.bluetooth):const Icon(Icons.bluetooth_connected),
                    onPressed: () {
                      viewModel.connectToDevice(device).then((_) {
                        // Show the connected device value in a popup
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Connected Device'),
                              content: Text(
                                viewModel.connectedDevice != null
                                    ? viewModel.connectedDevice!.platformName
                                            .isNotEmpty
                                        ? viewModel
                                            .connectedDevice!.platformName
                                        : 'Unknown'
                                    : 'No device connected',
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
