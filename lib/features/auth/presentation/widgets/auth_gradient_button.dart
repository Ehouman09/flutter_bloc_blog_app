import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {

  const AuthGradientButton({super.key, required this.buttonText});
  final String buttonText;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration:  BoxDecoration(
        gradient: const LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2,
              //AppPallete.gradient3,
        ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7)
      ),
      child: ElevatedButton(
        onPressed: (){},
        child: Text(
          buttonText,
          style: TextStyle(
            //color: ,
              fontSize: 17,
              fontWeight: FontWeight.w600
          ),
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: AppPallete.transparentColor,
          //elevation: 0.0,
          shadowColor: AppPallete.transparentColor
        ),
      ),
    );
  }
}
