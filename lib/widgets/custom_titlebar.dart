import 'package:dallify/commands/savefile.dart';
import 'package:dallify/widgets/gradient_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:dallify/utils/constants.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: backgroun_titlebar,
      padding: const EdgeInsets.only(top: 5, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(height: 40, child: Image.asset('assets/logo.png')),
              SizedBox(
                width: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: GradientText(
                  AplicationName,
                  style: const TextStyle(fontSize: 23),
                  gradient: reversedGradientTheme,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(bottom: 3, right: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: darkenGradientTheme,
                borderRadius: BorderRadius.circular(5),
              ),
              child: ElevatedButton.icon(
                onPressed: () async {
                  await openDownloadFolder();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                icon: const Icon(
                  Icons.folder,
                  color: Colors.white,
                ),
                label: Text('Open Folder'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
