
import 'package:flutter/material.dart';

class CircleAvatarImage extends StatelessWidget {
  final String? imageUrl;
  final double? radius;

  const CircleAvatarImage({super.key, required this.imageUrl,this.radius=20});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(imageUrl ?? ""),
    );
  }
}
