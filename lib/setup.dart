import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dallify/models/generate_image_record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dallify/utils/constants.dart';

Future<void> setup() async {
  final Directory _appDocDir = await getApplicationDocumentsDirectory();
  final Directory _appDocDirFolder =
      Directory(_appDocDir.path + '/' + AplicationName);
  if (!await _appDocDirFolder.exists()) {
    await _appDocDirFolder.create(recursive: true);
  }
  await Hive.initFlutter(_appDocDirFolder.path);
  Hive.registerAdapter(GenerateImageRecordAdapter());
  await Hive.openBox<GenerateImageRecord>('generatedResults');
}
