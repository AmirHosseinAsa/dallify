import 'dart:convert';
import 'package:dallify/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:process_run/cmd_run.dart';

Future getData(url) async {
  Response response = await get(url);
  return response.body;
}

Future<List<String>> fetchRecordResult(String prompt) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:$portServ?prompt=' + prompt));
  if (response.statusCode == 200) {
    try {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<String> stringList =
          jsonList.map((item) => item.toString()).toList();
      return stringList;
    } catch (e) {
      return [];
    }
  } else {
    throw Exception('Failed to fetch data from API');
  }
}

Future<void> shutdownServer() async {
  try {
    await http.get(Uri.parse('http://127.0.0.1:$portServ/shutdown'));
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
    runCmd(ProcessCmd('python', ['-m', 'flask', 'run', '-p', portServ],
        workingDirectory: 'python'));
  } catch (e) {
    print('Failed to start server: $e');
  }
}
