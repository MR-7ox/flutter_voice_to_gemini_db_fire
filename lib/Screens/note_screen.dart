import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // coverts to json

class Note_Screen extends StatelessWidget {
  TextEditingController importantpoints = TextEditingController();
  TextEditingController tools = TextEditingController();
  TextEditingController tasks = TextEditingController();
  TextEditingController prompt = TextEditingController();
  TextEditingController formulas = TextEditingController();

  Future<void> send_Prompt() async {
    final url = Uri.parse('http://10.143.83.36:5000/recieve');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'text/plain'},
      body: prompt.text,
    );

    if (response.statusCode == 200) {
      print("Server responded : ${response.body}");

      final String reply = response.body;
      print(reply);
    } else {
      print("connection failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: prompt,
              decoration: InputDecoration.collapsed(hintText: "Type"),
            ),
            ElevatedButton(onPressed: send_Prompt, child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
