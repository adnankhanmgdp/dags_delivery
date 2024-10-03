import 'package:flutter/material.dart';
import '../utils/image_res.dart';

Widget appImage(
    {String imagePath = ImageRes.idIcon,
      double width = 16,
      double height = 16}) {
  return Image.asset(
    imagePath,
    width: width,
    height: height,
  );
}

Widget appImageWithColor(
    {String imagePath = ImageRes.idIcon,
      double width = 16,
      double height = 16,
      Color imageColor = Colors.white}) {
  return Image.asset(
    imagePath,
    width: width,
    height: height,
    color: imageColor,
  );
}

Widget circularProfileImage({double radius = 50, String? profilePicUrl}) {
  return CircleAvatar(
    radius: radius,
    backgroundImage: profilePicUrl != null && profilePicUrl.isNotEmpty
        ? NetworkImage(profilePicUrl)
        : const AssetImage(ImageRes.profileimage) as ImageProvider,
  );
}