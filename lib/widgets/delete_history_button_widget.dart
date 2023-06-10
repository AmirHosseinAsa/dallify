import 'package:flutter/material.dart';
import 'package:dallify/models/generated_image_records_database.dart';
import 'package:provider/provider.dart';

class DeleteHistoryWidget extends StatefulWidget {
  const DeleteHistoryWidget({Key? key}) : super(key: key);

  @override
  _DeleteHistoryWidgetState createState() => _DeleteHistoryWidgetState();

  static final ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(true);
}

class _DeleteHistoryWidgetState extends State<DeleteHistoryWidget> {
  showAlertDialog(BuildContext context) {
    Widget yesButton = TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 163, 44, 35))),
      child: Text(
        "Yes",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        context.read<GeneratedImageRecordsDatabase>().clearHistory();
        Navigator.of(context).pop();
      },
    );
    Widget noButton = TextButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 146, 139, 139))),
      child: Text(
        "No",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure?"),
      alignment: Alignment.center,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            yesButton,
            noButton,
          ],
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          showAlertDialog(context);
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            backgroundColor: Color.fromARGB(255, 158, 4, 4)),
        icon: const Icon(Icons.delete_forever),
        label: Text(
          'CLEAR',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
