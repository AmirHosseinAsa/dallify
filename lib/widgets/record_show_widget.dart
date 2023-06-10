import 'package:dallify/widgets/save_image_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:dallify/utils/constants.dart';
import 'package:dallify/models/generate_image_record.dart';
import 'package:dallify/models/generated_image_records_database.dart';
import 'package:provider/provider.dart';
import 'generate_button_widget.dart';
import '../commands/request.dart';

// ignore: must_be_immutable
class RecordShowWidget extends StatefulWidget {
  RecordShowWidget({super.key, required this.generateImageRecord});
  GenerateImageRecord generateImageRecord;
  @override
  State<RecordShowWidget> createState() => _RecordShowWidgetState();
}

class _RecordShowWidgetState extends State<RecordShowWidget> {
  bool _isLoading = false;

  Future<void> _fetchResult() async {
    context
        .read<GeneratedImageRecordsDatabase>()
        .updateMakeGenerating(widget.generateImageRecord);

    setState(() {
      _isLoading = true;
    });
    try {
      widget.generateImageRecord.urls =
          await fetchRecordResult(widget.generateImageRecord.prompt);
    } catch (e) {
      print(e);
      setState(() {
        hasError = true;
        widget.generateImageRecord.delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: Your prompt has been blocked'),
          ),
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
        canGenerate = true;
        context
            .read<GeneratedImageRecordsDatabase>()
            .updateUrls(widget.generateImageRecord);
        GenerateButtonWidget.valueNotifier.value = true;
      });
    }
  }

  @override
  void initState() {
    if (!widget.generateImageRecord.generating) _fetchResult();
    super.initState();
  }

  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    var loopLenth =
        _isLoading ? 4 : widget.generateImageRecord.urls?.length ?? 0;
    loopLenth = loopLenth > 4 ? 4 : loopLenth;

    return Visibility(
      visible: !hasError,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.generateImageRecord.prompt,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Visibility(
                  visible: !_isLoading,
                  child: IconButton(
                    onPressed: () async {
                      context
                          .read<GeneratedImageRecordsDatabase>()
                          .remove(widget.generateImageRecord);
                    },
                    icon: Icon(
                      Icons.remove_circle_outline_sharp,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            GridView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width <
                        MediaQuery.of(context).size.height
                    ? 2
                    : 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: loopLenth,
              itemBuilder: (context, index) {
                return _isLoading
                    ? Container(
                        padding: EdgeInsets.all(50),
                        child: spinkitPulse,
                      )
                    : !hasError
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/loading.gif',
                                  fit: BoxFit.fitHeight,
                                  alignment: Alignment.center,
                                  image:
                                      widget.generateImageRecord.urls![index],
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: -13,
                                  child: SaveImageButton(
                                      url: widget
                                          .generateImageRecord.urls![index])),
                            ],
                          )
                        : SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
