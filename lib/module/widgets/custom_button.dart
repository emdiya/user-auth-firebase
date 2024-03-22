import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.isGradient = true,
    this.textColor,
    this.height,
    this.radius = 10,
    this.isTinyButton = false,
    this.width,
    this.isDisabledButton = false,
  });
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isGradient;
  final bool isDisabledButton;
  final double radius;
  final void Function() onPressed;
  final double? height;
  final double? width;
  final bool isTinyButton;
  @override
  Widget build(BuildContext context) {
    return isTinyButton
        ? Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: backgroundColor ?? context.theme.colorScheme.primary,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Center(
                child: Text(
                  title,
                  style: context.textTheme.labelLarge?.copyWith(
                      color: textColor ?? Colors.white, fontSize: 10),
                ),
              ),
            ),
          )
        : Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDisabledButton
                  ? Colors.grey
                  : backgroundColor ?? context.theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(radius),
              gradient: isGradient
                  ? LinearGradient(
                      begin: const Alignment(1.2, -0.353),
                      end: const Alignment(-1.8, 1),
                      colors: <Color>[
                        context.theme.colorScheme.primary,
                       Colors.purple,
                          Colors.purple.withOpacity(.95)
                      ],
                      stops: const <double>[0, 0.416, 1],
                      tileMode: TileMode.mirror,
                    )
                  : null,
            ),
            child: ElevatedButton(
              onPressed: isDisabledButton ? null : onPressed,
              style: isGradient
                  ? ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    )
                  : ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      shadowColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      overlayColor: MaterialStatePropertyAll(
                          Colors.pink[100]!.withOpacity(.1)),
                    ),
              child: Text(
                title,
                style: context.textTheme.labelLarge
                    ?.copyWith(color: textColor ?? Colors.white, fontSize: 16),
              ),
            ),
          );
  }
}

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.borderColor,
    this.borderWidth = 1.0,
    this.titleColor,
    this.height = 50,
    this.radius = 10,
    this.titleFontSize = 16,
    this.isTinyButton = false,
    this.width,
  });
  final String title;
  final void Function() onPressed;
  final Color? borderColor;
  final Color? titleColor;
  final double titleFontSize;
  final double borderWidth;
  final double? width;
  final double height;
  final double radius;
  final bool isTinyButton;
  @override
  Widget build(BuildContext context) {
    return isTinyButton
        ? Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                width: borderWidth,
                color: borderColor ?? context.theme.colorScheme.primary,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Center(
                child: Text(
                  title,
                  style: context.textTheme.labelLarge?.copyWith(
                      color: titleColor ?? context.theme.colorScheme.primary,
                      fontSize: 10),
                ),
              ),
            ),
          )
        : SizedBox(
            height: height,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.blue.shade900.withOpacity(.1);
                    }
                    return Colors.transparent;
                  },
                ),
                side: MaterialStatePropertyAll(
                  BorderSide(
                    width: borderWidth,
                    color: borderColor ?? context.theme.colorScheme.secondary,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),
                  ),
                ),
              ),
              child: Text(
                title,
                style: context.textTheme.labelLarge?.copyWith(
                    color: titleColor ?? context.theme.colorScheme.primary,
                    fontSize: titleFontSize),
              ),
            ),
          );
  }
}