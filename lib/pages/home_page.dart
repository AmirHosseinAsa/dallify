import 'package:dallify/application.dart';
import 'package:dallify/commands/request.dart';
import 'package:flutter/material.dart';
import 'package:dallify/utils/constants.dart';
import 'package:dallify/models/generated_image_records_database.dart';
import 'package:dallify/widgets/custom_sidebar.dart';
import 'package:dallify/widgets/custom_titlebar.dart';
import 'package:dallify/widgets/result_container.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  @override
  void onWindowClose() async {
  await  shutdownServer();
    Navigator.of(context).pop();
    windowManager.destroy();
  }

  @override
  void initState() {
    context.read<GeneratedImageRecordsDatabase>().makeAllBrandNewFalse();
    windowManager.addListener(this);
    windowManager.setPreventClose(true);
    super.initState();
  }

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
                      showHistory: false,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
