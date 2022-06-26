import 'package:apps_education/constants/setting_Reusable.dart';
import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin(
      {Key? key,
      required this.backgroundColor,
      required this.child,
      required this.borderColor,
      required this.onTap,
      required this.radius})
      : super(key: key);
  final double? radius;
  final Color backgroundColor;
  final Widget child;
  final Color borderColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: backgroundColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 25),
                side: BorderSide(color: borderColor))
                ),
                onPressed: onTap,
                child: child,
      ),
    );
  }
}

class RegisterTextField extends StatelessWidget {
  const RegisterTextField({
    Key? key,
    required this.title,
    required this.hintText,
    this.controller,
    this.enabled = true,
  }) : super(key: key);
  final String title;
  final String hintText;
  final bool enabled;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: Setting_Reusable.color.greyBorder),
          ),
          child: TextField(
            enabled: enabled,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Setting_Reusable.color.greyHintText,
                )),
          ),
        ),
      ],
    );
  }
}