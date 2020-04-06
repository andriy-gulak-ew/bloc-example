import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String imageUrl;

  const ImageView({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imageUrl), fit: BoxFit.cover),
              ),
            ),
            BackButton(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
