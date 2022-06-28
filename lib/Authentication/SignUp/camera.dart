import 'package:flutter/material.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<Asset>? images;
  List<Asset>? resultList;
  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImages() async {
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images!,
        materialOptions: const MaterialOptions(
          actionBarTitle: "FlutterCorner.com",
        ),
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      images = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Multi Image Picker - FlutterCorner.com'),
        ),
        body: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: pickImages,
              child: const Text("Pick images"),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(images!.length, (index) {
                  Asset asset = images![index];
                  return AssetThumb(
                    asset: asset,
                    width: 400,
                    height: 300,
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
