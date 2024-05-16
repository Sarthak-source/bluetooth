import 'package:first_project/redux-store/models/app_state.dart';
import 'package:first_project/redux-store/view_models/log_in_view_model.dart';
import 'package:first_project/views/let_go.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
      converter: (store) => LoginViewModel.fromStore(store),
      builder: (context, viewModel) {
        return _LoginScreenContent(viewModel: viewModel);
      },
    );
  }
}

class _LoginScreenContent extends StatefulWidget {
  final LoginViewModel viewModel;

  const _LoginScreenContent({required this.viewModel});

  @override
  _LoginScreenContentState createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<_LoginScreenContent> {
  late bool _agreedToTerms;

  @override
  void initState() {
    super.initState();
    _agreedToTerms = widget.viewModel.agreedToTerms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              'assets/image.png',
              height: 150,
            ),
            const SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(hintText: 'email'),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(hintText: 'password'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, newSetState) {
                      return AlertDialog(
                        title: const Text("terms and conditions"),
                        content: Column(
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: 'Hello ',
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text:
                                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. \n2It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.\n3 It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _agreedToTerms,
                                  onChanged: (newValue) {
                                    newSetState(() {
                                      setState(() {
                                        _agreedToTerms = newValue!;
                                      });
                                    });
                                  },
                                ),
                                const Expanded(
                                  child: Text(
                                    'I agree to the terms and conditions',
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: _agreedToTerms
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LetsGoPage(),
                                      ),
                                    );
                                  }
                                : null,
                            child: const Text("Agree and Continue"),
                          ),
                        ],
                      );
                    });
                  },
                );
              },
              child: const Text('Log in'),
            ),
            const SizedBox(height: 20),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
