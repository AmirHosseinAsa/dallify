import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dallify/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:dallify/application.dart';
import 'package:dallify/commands/request.dart';
import 'package:dallify/models/generated_image_records_database.dart';
import 'package:dallify/setup_hive.dart';
import 'package:provider/provider.dart';

void main() async {
  await setupHive();
  await configureServer();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeneratedImageRecordsDatabase()),
      ],
      child: const Application(),
    ),
  );

  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(800, 600);
    win.minSize = initialSize;
    win.alignment = Alignment.center;
    win.title = AplicationName;
    win.maximize();
    win.show();
  });
}

Future<void> configureServer() async {
  await WidgetsFlutterBinding.ensureInitialized();
  if (!await checkWebsiteStatus()) {
    await startServer();
  } else {
    await shutdownServer();
    await Future.delayed(Duration(milliseconds: 1500));
    await startServer();
  }
}
