import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dallify/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:dallify/application.dart';
import 'package:dallify/commands/request.dart';
import 'package:dallify/models/generated_image_records_database.dart';
import 'package:dallify/setup.dart';
import 'package:process_run/cmd_run.dart';
import 'package:provider/provider.dart';

void main() async {
  await setup();
  await configureServer();
  WidgetsFlutterBinding.ensureInitialized();
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
    win.title = 'Dallify';
    win.maximize();
    win.show();
  });
}

Future<void> configureServer() async {
  if (!await checkWebsiteStatus()) {
    await startServer();
  } else {
    await shutdownServer();
    await startServer();
  }
}
