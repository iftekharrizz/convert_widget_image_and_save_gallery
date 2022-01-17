import 'dart:io';
import 'dart:typed_data';

import 'package:convert_widget_image_example/utils.dart';
import 'package:convert_widget_image_example/widget/card_widget.dart';
import 'package:convert_widget_image_example/widget/title_widget.dart';
import 'package:convert_widget_image_example/widget/widget_to_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Convert Widget To Image';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey key1;
  GlobalKey key2;
  Uint8List bytes1;
  Uint8List bytes2;

  /* Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }*/

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TitleWidget('Widgets'),
            WidgetToImage(
              builder: (key) {
                this.key1 = key;

                return CardWidget(title: 'Title1', description: 'Description1');
              },
            ),
            WidgetToImage(
              builder: (key) {
                this.key2 = key;

                return CardWidget(title: 'Title2', description: 'Description2');
              },
            ),
            TitleWidget('Images'),
            buildImage(bytes1),
            buildImage(bytes2),
          ],
        ),
        bottomSheet: Container(
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            child: RaisedButton(
              color: Colors.white,
              child: Text('Capture'),
              onPressed: () async {
                //print(buildImage(this.bytes1));
                final bytes1 = await Utils.capture(key1);
                final bytes2 = await Utils.capture(key2);
                // _saveScreen(bytes1);
                var image = bytes2.toString();
                final result = await ImageGallerySaver.saveImage(bytes1);
                //ImageGallerySaver.saveFile(image,isReturnPathOfIOS: true,name: "my image");
                print("_________${result}");

                setState(() {
                  this.bytes1 = bytes1;
                  this.bytes2 = bytes2;
                });
              },
            ),
          ),
        ),
      );

  Widget buildImage(Uint8List bytes) =>
      bytes != null ? Image.memory(bytes) : Container();
}
