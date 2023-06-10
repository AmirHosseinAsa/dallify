import 'package:flutter/material.dart';
import 'package:dallify/utils/constants.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

// import 'package:http/http.dart' as http;
import 'package:process_run/cmd_run.dart';

Future<bool> downloadAndSaveFile(BuildContext context, String url) async {
  try {
    final PathProviderWindows provider = PathProviderWindows();
    String? downloadsDirectory = '';

    downloadsDirectory = await provider.getDownloadsPath();
    var firstPath = downloadsDirectory! + '/' + AplicationName;

    final Directory _appDownloadDirFolder = Directory(firstPath);
    if (!await _appDownloadDirFolder.exists()) {
      await _appDownloadDirFolder.create(recursive: true);
    }

    await runCmd(ProcessCmd(
      'python',
      ['-m', 'save.py', '-U', url, '-P', firstPath],
      workingDirectory: 'python',
      runInShell: true,
    ));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('File saved successfully in : ' + firstPath),
      ),
    );

    return true;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error while saving file'),
      ),
    );
    return false;
  }
}

Future<void> openDownloadFolder() async {
  final PathProviderWindows provider = PathProviderWindows();
  String? downloadsDirectory = '';

  downloadsDirectory = await provider.getDownloadsPath();
  var firstPath = downloadsDirectory! + '/' + AplicationName;

  final Directory _appDownloadDirFolder = Directory(firstPath);
  if (!await _appDownloadDirFolder.exists()) {
    await _appDownloadDirFolder.create(recursive: true);
  }
  await launch('file://$firstPath');
}
