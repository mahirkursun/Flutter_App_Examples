import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImagePreview extends StatefulWidget {
  Asset images;
  List<Asset> resim;
  ImagePreview({this.images, this.resim});
  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  void initState() {
    super.initState();
  }

  void resmiSil() {
    widget.resim.remove(widget.images);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Resim"),
            Spacer(
              flex: 1,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              iconSize: 40,
              onPressed: () {
                setState(() {
                  resmiSil();
                });
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 100 / 100,
          height: MediaQuery.of(context).size.height * 100 / 100,
          child: AssetThumb(
            asset: widget.images,
            height: 400,
            width: 250,
          ),
        ),
      ),
    );
  }
}
