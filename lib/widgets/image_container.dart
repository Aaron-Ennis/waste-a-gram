import "package:flutter/material.dart";

class ImageContainer extends StatelessWidget {
  final imageUrl;
  const ImageContainer({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
