import 'package:hive/hive.dart';
part 'generate_image_record.g.dart';

@HiveType(typeId: 1)
class GenerateImageRecord extends HiveObject {
  @HiveField(0)
  late final String prompt;

  @HiveField(1)
  late List<String>? urls;

  @HiveField(2)
  late bool generating = false;

  @HiveField(3)
  late DateTime? CreateDate = DateTime.now();

  @HiveField(4)
  late bool? isBrandNew = true;

  GenerateImageRecord({required this.prompt, this.urls});
}
