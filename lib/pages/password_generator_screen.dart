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
            width: 300,
            child: TextField(
              controller: passwordController,
              readOnly: true,
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
              Text("Password length (${passwordLength.toInt()})"),
              SizedBox(
                width: 200,
                child: Slider(
                    label: passwordLength.toString(),
                    min: 0,
                    max: 24,
                    divisions: 24,
                    value: passwordLength,
                    onChanged: (value) {
                      setState(() {
                        passwordLength = value.roundToDouble();
                      });
                      _generatePassword(passwordLength.toInt());
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
                        _generatePassword(passwordLength.toInt());
                      }))
            ],
          ),
        ],
      ),
    );
  }

  void _generatePassword(int length) {
    var charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    if (specialCharacters) {
      charset += '!@#\$%^&*()_+°¨£;?ç€';
    }

    final random = Random.secure();
    final password =
        List.generate(length, (_) => charset[random.nextInt(charset.length)])
            .join();

    passwordController.text = password;
  }

  void _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: passwordController.text));

    const snackBar = SnackBar(
      content: Text("Password copied to clipboard !"),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
