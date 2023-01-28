import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class CustomCircleImage extends StatelessWidget {
  const CustomCircleImage({Key? key, required this.radius, required this.image})
      : super(key: key);
  final double radius;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        height: 48,
        width: 48,
        child: image,
      ),
    );
  }
}

class CustomImageBorder extends StatelessWidget {
  const CustomImageBorder(
      {Key? key, required this.file, this.height, this.width})
      : super(key: key);
  final String file;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Image.file(
          File(file),
          fit: BoxFit.cover,
          height: height,
          width: width,
        ));
  }
}

class CustomImageBytesBorder extends StatelessWidget {
  const CustomImageBytesBorder(
      {Key? key,
      required this.bytes,
      this.height,
      this.width,
      this.fit = BoxFit.cover})
      : super(key: key);
  final Uint8List bytes;
  final double? height;
  final double? width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Image.memory(
          bytes,
          fit: fit,
          height: height,
          width: width,
        ));
  }
}
