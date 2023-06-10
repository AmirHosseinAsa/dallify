import 'package:flutter/material.dart';
import 'package:dallify/utils/constants.dart';
import 'package:dallify/widgets/custom_sidebar.dart';
import 'package:dallify/widgets/custom_titlebar.dart';
import 'package:dallify/widgets/result_container.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_container_generated_image,
      body: Column(
        children: [
          CustomTitleBar(),
          Expanded(
            child: Row(
              children: [
                CustomSideBar(),
                Expanded(
                  child: ClipRect(
                      child: ResultContainer(
                    showHistory: true,
                  )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
