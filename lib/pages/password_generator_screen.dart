import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordGeneratorScreen extends StatefulWidget {
  const PasswordGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<PasswordGeneratorScreen> createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  final passwordController = TextEditingController();
  double passwordLength = 12;
  bool specialCharacters = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                _generatePassword(passwordLength.toInt());
              },
              child: const Text("Generate")),
          SizedBox(
            width: 200,
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      onTap: () {
                        _copyToClipboard();
                      },
                      child: const Icon(Icons.copy))),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Password length"),
              SizedBox(
                width: 200,
                child: Slider(
                    label: passwordLength.toString(),
                    min: 0,
                    max: 24,
                    value: passwordLength,
                    onChanged: (value) {
                      setState(() {
                        passwordLength = value.roundToDouble();
                      });
                    }),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Use special character"),
              SizedBox(
                  width: 200,
                  child: Switch(
                      value: specialCharacters,
                      onChanged: (switchValue) {
                        setState(() {
                          specialCharacters = switchValue;
                        });
                      }))
            ],
          ),
        ],
      ),
    );
  }

  void _generatePassword(int passwordLength) {
    passwordController.text = Random().nextInt(500000000).toString();
  }

  void _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: passwordController.text));

    const snackBar = SnackBar(
      content: Text("Password copied to clipboard !"),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
