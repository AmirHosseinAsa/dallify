import 'dart:convert';
import 'package:dallify/utils/constants.dart';
import 'package:dallify/widgets/custom_scaffold_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:process_run/cmd_run.dart';

Future getData(url) async {
  Response response = await get(url);
  return response.body;
}

Future<List<String>> fetchRecordResult(
    BuildContext context, String prompt) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:$portServ'),
    headers: {'prompt': prompt},
  );

  switch (response.statusCode) {
    case 200:
      try {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<String> stringList =
            jsonList.map((item) => item.toString()).toList();
        return stringList;
      } catch (e) {
        return [];
      }
    case 403:
      CustomScaffoldMessageWidget.show(
          context, 'Error: Your prompt has been blocked');
      throw Exception('Error: Your prompt has been blocked');

    case 401:
      await shutdownServer();
      await startServer();
      await Future.delayed(Duration(milliseconds: 1500));
      return fetchRecordResult(context, prompt);

    case 500:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Try again'),
        ),
      );
      await shutdownServer();
      await startServer();
      throw Exception('Error: Try again');

    default:
      CustomScaffoldMessageWidget.show(context,
          'Unknown error: Please refer to the "About" page for contact information to reach out to the developer for assistance.');
      throw Exception('Failed to fetch data from API');
  }
}

Future<void> shutdownServer() async {
  try {
    await http.head(Uri.parse('http://127.0.0.1:$portServ/shutdown'));
  } catch (e) {
    print(e);
  }
}

Future<bool> checkWebsiteStatus() async {
  try {
    final response =
        await http.head(Uri.parse('http://127.0.0.1:$portServ/status'));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

Future<void> startServer() async {
  try {
    // runCmd(ProcessCmd('python', ['-m', 'flask', 'run', '-p', portServ],
    //     workingDirectory: 'python'));
    runCmd(ProcessCmd('python -m flask run -p $portServ', [],
        workingDirectory: 'python'));
  } catch (e) {
    print('Failed to start server: $e');
  }
}
