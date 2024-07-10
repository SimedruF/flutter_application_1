import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Google Generative AI Example')),
        body: Center(child: GenerativeAIForm()),
      ),
    );
  }
}

class GenerativeAIForm extends StatefulWidget {
  @override
  _GenerativeAIFormState createState() => _GenerativeAIFormState();
}

class _GenerativeAIFormState extends State<GenerativeAIForm> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';

  Future<void> _sendPrompt() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/generate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'prompt': _controller.text,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _response = jsonDecode(response.body)['generated_text'];
      });
    } else {
      setState(() {
        _response = 'Failed to generate text';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Enter a prompt'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _sendPrompt,
            child: Text('Generate'),
          ),
          SizedBox(height: 20),
          Text(_response),
        ],
      ),
    );
  }
}
