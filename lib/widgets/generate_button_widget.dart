import 'package:dallify/widgets/custom_scaffold_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:dallify/utils/constants.dart';
import 'package:dallify/models/generate_image_record.dart';
import 'package:dallify/models/generated_image_records_database.dart';
import 'package:provider/provider.dart';
import 'package:animate_gradient/animate_gradient.dart';

class GenerateButtonWidget extends StatefulWidget {
  const GenerateButtonWidget({Key? key}) : super(key: key);

  @override
  _GenerateButtonWidgetState createState() => _GenerateButtonWidgetState();

  static final ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(true);
}

class _GenerateButtonWidgetState extends State<GenerateButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  void initiateAnimation() {
    _controller = (AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat(reverse: false));
  }

  @override
  void initState() {
    initiateAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSubmit() async {
    if (ModalRoute.of(context)?.settings.name != '/') {
      Navigator.pushNamed(context, '/');
    }
    if (textFiledGenerateValue != '' &&
        GenerateButtonWidget.valueNotifier.value) {
      textFiledGenerateValue = textFiledGenerateValue.trim();
      textFiledGenerateValue = textFiledGenerateValue[0].toUpperCase() +
          textFiledGenerateValue.substring(1);
      context
          .read<GeneratedImageRecordsDatabase>()
          .add(GenerateImageRecord(prompt: textFiledGenerateValue));
      GenerateButtonWidget.valueNotifier.value = false;
    } else if (textFiledGenerateValue == '') {
      CustomScaffoldMessageWidget.show(context, 'Please enter youre prompt');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GenerateButtonWidget.valueNotifier,
      builder: (BuildContext context, bool value, Widget? child) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: value
              ? AnimateGradient(
                  primaryBegin: Alignment.topRight,
                  primaryEnd: Alignment.topLeft,
                  secondaryBegin: Alignment.bottomLeft,
                  secondaryEnd: Alignment.bottomRight,
                  primaryColors: const [
                    Color.fromARGB(255, 0, 89, 148),
                    Color.fromARGB(255, 0, 142, 167),
                    Color.fromARGB(255, 0, 89, 148),
                  ],
                  secondaryColors: const [
                    Color.fromARGB(255, 0, 89, 148),
                    Color.fromARGB(255, 0, 142, 167),
                    Color.fromARGB(255, 0, 89, 148),
                  ],
                  controller: _controller,
                  child: ElevatedButton.icon(
                    onPressed: value ? _onSubmit : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    icon: const Icon(
                      Icons.track_changes_outlined,
                      color: Colors.white,
                    ),
                    label: Text(
                      'GENERATE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : ElevatedButton.icon(
                  onPressed: value ? _onSubmit : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  icon: Container(
                    width: 24,
                    height: 24,
                    padding: const EdgeInsets.all(2.0),
                    child: const CircularProgressIndicator(
                      color: const Color.fromARGB(255, 179, 179, 179),
                      strokeWidth: 3,
                    ),
                  ),
                  label: Text(
                    'GENERATING',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 179, 179, 179)),
                  ),
                ),
        );
      },
    );
  }
}
