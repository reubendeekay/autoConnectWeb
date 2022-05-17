import 'package:flutter/material.dart';

class MechanicPhotos extends StatelessWidget {
  MechanicPhotos(this.pictures, {Key? key}) : super(key: key);
  List<dynamic> pictures;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 15),
      children: pictures
          .map((e) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: AspectRatio(
                aspectRatio: 16 / 7,
                child: Image.network(
                  e,
                  fit: BoxFit.cover,
                ),
              )))
          .toList(),
    );
  }
}
