import 'package:first_project/redux-store/models/app_state.dart';
import 'package:first_project/redux-store/view_models/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      converter: (store) => HomeViewModel.fromStore(store, context),
      builder: (context, viewModel) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            unselectedItemColor: Colors.purple, // Set the font color to purple
            selectedItemColor: Colors.purple,
            currentIndex: 0, // Set the default index to 0 (Home)
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
                  Icons.money,
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
                child: _buildDeviceList(viewModel),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDeviceList(HomeViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (viewModel.hasError) {
      return Center(
        child: Text('Error: ${viewModel.error}'),
      );
    } else {
      return ListView.builder(
        itemCount: viewModel.devicesList.length,
        itemBuilder: (context, index) {
          final device = viewModel.devicesList[index];
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
                      subtitle: Text(device.remoteId.str),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.bluetooth),
                    onPressed: () {
                      viewModel.connectToDevice(device);
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



// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;
//   final List<BluetoothDevice> devicesList = <BluetoothDevice>[];
//   final Map<Guid, List<int>> readValues = <Guid, List<int>>{};

//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> {
//   final _writeController = TextEditingController();
//   BluetoothDevice? _connectedDevice;
//   List<BluetoothService> _services = [];

//   _addDeviceTolist(final BluetoothDevice device) {
//     if (!widget.devicesList.contains(device)) {
//       setState(() {
//         widget.devicesList.add(device);
//       });
//     }
//   }

//   _initBluetooth() async {
//     var subscription = FlutterBluePlus.onScanResults.listen(
//       (results) {
//         if (results.isNotEmpty) {
//           for (ScanResult result in results) {
//             log(result.device.advName);
//             _addDeviceTolist(result.device);
//           }
//         }
//       },
//       onError: (e) => ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(e.toString()),
//         ),
//       ),
//     );

//     FlutterBluePlus.cancelWhenScanComplete(subscription);

//     await FlutterBluePlus.adapterState
//         .where((val) => val == BluetoothAdapterState.on)
//         .first;

//     await FlutterBluePlus.startScan();

//     await FlutterBluePlus.isScanning.where((val) => val == false).first;
//     FlutterBluePlus.connectedDevices.map((device) {
//       _addDeviceTolist(device);
//     });
//   }

//   @override
//   void initState() {
//     () async {
//       _initBluetooth();
//     }();
//     super.initState();
//   }

//   ListView _buildListViewOfDevices() {
//     List<Widget> containers = <Widget>[];
//     for (BluetoothDevice device in widget.devicesList) {
//       containers.add(
//         Card(
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 child: Column(
//                   children: <Widget>[
//                     Text(device.platformName.toString()),
//                     //Text(device.remoteId.toString()),
//                   ],
//                 ),
//               ),
//               TextButton(
//                 child: const Text(
//                   'Connect',
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 onPressed: () async {
//                   FlutterBluePlus.stopScan();
//                   try {
//                     await device.connect();
//                   } on PlatformException catch (e) {
//                     if (e.code != 'already_connected') {
//                       rethrow;
//                     }
//                   } finally {
//                     _services = await device.discoverServices();
//                   }
//                   setState(() {
//                     _connectedDevice = device;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return ListView(
//       padding: const EdgeInsets.all(8),
//       children: <Widget>[
//         ...containers,
//       ],
//     );
//   }

//   List<ButtonTheme> _buildReadWriteNotifyButton(
//       BluetoothCharacteristic characteristic) {
//     List<ButtonTheme> buttons = <ButtonTheme>[];

//     if (characteristic.properties.read) {
//       buttons.add(
//         ButtonTheme(
//           minWidth: 10,
//           height: 20,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4),
//             child: TextButton(
//               child: const Text('READ', style: TextStyle(color: Colors.black)),
//               onPressed: () async {
//                 try {
//                   List<int>? value = await characteristic.read();
//                   setState(() {
//                     widget.readValues[characteristic.uuid] = value;
//                   });
//                 } catch (e) {
//                   print('Error reading characteristic: $e');
//                 }
//               },
//             ),
//           ),
//         ),
//       );
//     }
//     if (characteristic.properties.write) {
//       buttons.add(
//         ButtonTheme(
//           minWidth: 10,
//           height: 20,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4),
//             child: ElevatedButton(
//               child: const Text('WRITE', style: TextStyle(color: Colors.black)),
//               onPressed: () async {
//                 await showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: const Text("Write"),
//                         content: Row(
//                           children: <Widget>[
//                             Expanded(
//                               child: TextField(
//                                 controller: _writeController,
//                               ),
//                             ),
//                           ],
//                         ),
//                         actions: <Widget>[
//                           TextButton(
//                             child: const Text("Send"),
//                             onPressed: () {
//                               characteristic.write(
//                                   utf8.encode(_writeController.value.text));
//                               Navigator.pop(context);
//                             },
//                           ),
//                           TextButton(
//                             child: const Text("Cancel"),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                         ],
//                       );
//                     });
//               },
//             ),
//           ),
//         ),
//       );
//     }
//     if (characteristic.properties.notify) {
//       buttons.add(
//         ButtonTheme(
//           minWidth: 10,
//           height: 20,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4),
//             child: ElevatedButton(
//               child:
//                   const Text('NOTIFY', style: TextStyle(color: Colors.black)),
//               onPressed: () async {
//                 characteristic.lastValueStream.listen((value) {
//                   setState(() {
//                     widget.readValues[characteristic.uuid] = value;
//                   });
//                 });
//                 await characteristic.setNotifyValue(true);
//               },
//             ),
//           ),
//         ),
//       );
//     }

//     return buttons;
//   }

//   ListView _buildConnectDeviceView() {
//     List<Widget> containers = <Widget>[];

//     for (BluetoothService service in _services) {
//       List<Widget> characteristicsWidget = <Widget>[];

//       for (BluetoothCharacteristic characteristic in service.characteristics) {
//         characteristicsWidget.add(
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: Text(characteristic.uuid.toString(),
//                           maxLines: 2,
//                           style: const TextStyle(fontWeight: FontWeight.bold)),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: <Widget>[
//                     ..._buildReadWriteNotifyButton(characteristic),
//                   ],
//                 ),
//                 Row(
//                   children: <Widget>[
//                     Expanded(
//                         child: Text(
//                             'Value: ${widget.readValues[characteristic.uuid]}')),
//                   ],
//                 ),
//                 const Divider(),
//               ],
//             ),
//           ),
//         );
//       }

//       containers.add(
//         Card(
//           child: InkWell(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return StatefulBuilder(builder: (context, newSetState) {
//                     return AlertDialog(
//                       //title: const Text("terms and conditions"),
//                       content: Column(
//                         children: characteristicsWidget,
//                       ),
//                       actions: <Widget>[
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text("Cancel"),
//                         ),
//                         // TextButton(
//                         //   onPressed: _agreedToTerms
//                         //       ? () {
//                         //           Navigator.push(
//                         //             context,
//                         //             MaterialPageRoute(
//                         //               builder: (context) =>
//                         //                   const LetsGoPage(),
//                         //             ),
//                         //           );
//                         //         }
//                         //       : null,
//                         //   child: const Text("Agree and Continue"),
//                         // ),
//                       ],
//                     );
//                   });
//                 },
//               );
//             },
//             child: Column(
//               children: [
//                 Text(service.uuid.toString()),
//               ],
//             ),
//           ),
//         ),
//       );
//     }

//     return ListView(
//       padding: const EdgeInsets.all(8),
//       children: <Widget>[
//         ...containers,
//       ],
//     );
//   }

//   ListView _buildView() {
//     if (_connectedDevice != null) {
//       return _buildConnectDeviceView();
//     }
//     return _buildListViewOfDevices();
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: _buildView(),
//       );
// }
