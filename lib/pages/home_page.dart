import 'package:flutter/material.dart';
import 'package:dallify/utils/constants.dart';
import 'package:dallify/models/generated_image_records_database.dart';
import 'package:dallify/widgets/custom_sidebar.dart';
import 'package:dallify/widgets/custom_titlebar.dart';
import 'package:dallify/widgets/result_container.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<GeneratedImageRecordsDatabase>().makeAllBrandNewFalse();
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
