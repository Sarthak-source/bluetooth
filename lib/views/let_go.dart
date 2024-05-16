import 'package:first_project/views/home_in.dart';
import 'package:flutter/material.dart';

class LetsGoPage extends StatefulWidget {
  const LetsGoPage({Key? key}) : super(key: key);

  @override
  State<LetsGoPage> createState() => _LetsGoPageState();
}

class _LetsGoPageState extends State<LetsGoPage> {

  @override
  Widget build(BuildContext context) {
  //   final HomeViewModel viewModel = HomeViewModel(
  //   devicesList: [], // Provide empty list or default value
  //   connectedDevice: null, // Provide default value
  //   services: [], // Provide empty list or default value
  //   readValues: {}, // Provide empty map or default value
  //   addDevice: (BluetoothDevice device) {}, // Provide a dummy function or default value
  //   connectDevice: (BluetoothDevice device) {}, // Provide a dummy function or default value
  //   store: store, context: context, // Provide a dummy store or default value
  // );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image.png',
              height: 150,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(  ),
                  ),
                );
              },
              child: const Text("Let's go"),
            )
          ],
        ),
      ),
    );
  }
}
