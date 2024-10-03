import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class text24normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final String fontfamily;

  const text24normal(
      {super.key,
      this.text = "",
      this.fontWeight = FontWeight.normal,
      this.color = AppColors.primaryText,
      this.fontfamily = "Inter"});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: color,
            fontWeight: fontWeight,
            fontSize: 24,
            fontFamily: fontfamily));
  }
}

class text16normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final String fontfamily;
  final TextAlign align;

  const text16normal(
      {super.key,
      this.text = "",
      this.fontWeight = FontWeight.normal,
      this.color = AppColors.primaryText,
      this.fontfamily = "Inter",
      this.align = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        style: TextStyle(
            color: color,
            fontWeight: fontWeight,
            fontSize: 16,
            fontFamily: fontfamily,
            letterSpacing: 0.0));
  }
}

class textcustomnormal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final String fontfamily;
  final TextAlign align;

  const textcustomnormal(
      {super.key,
      this.text = "",
      this.fontWeight = FontWeight.normal,
      this.color = AppColors.primaryText,
      this.fontSize = 10,
      this.fontfamily = "Inter",
      this.align=TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        style: TextStyle(
            color: color,
            fontWeight: fontWeight,
            fontSize: fontSize,
            fontFamily: fontfamily
        ));
  }
}

class text14normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final String fontfamily;
  final TextAlign align;

  const text14normal(
      {super.key,
      this.text = "",
      this.fontWeight = FontWeight.normal,
      this.color = AppColors.primaryText,
      this.fontfamily = "Inter",
      this.align = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        style: TextStyle(
            color: color,
            fontWeight: fontWeight,
            fontSize: 14,
            fontFamily: fontfamily));
  }
}

class text20normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final String fontfamily;

  const text20normal(
      {super.key,
      this.text = "",
      this.fontWeight = FontWeight.normal,
      this.color = AppColors.primaryText,
      this.fontfamily = "Inter"});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: color,
            fontWeight: fontWeight,
            fontSize: 20,
            fontFamily: fontfamily));
  }
}

class textUnderline extends StatelessWidget {
  final text;

  const textUnderline({super.key, this.text = ""});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            letterSpacing: 0.5,
            color: AppColors.primaryText,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.primaryText),
      ),
    );
  }
}

class dashLine extends StatelessWidget {
  final Color color;
  final double width;
  final double height;

  const dashLine({
    super.key,
    this.color = Colors.grey,
    this.width= 400,
    this.height= 2
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }
}
