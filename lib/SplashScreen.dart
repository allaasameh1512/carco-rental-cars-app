
import "package:animated_splash_screen/animated_splash_screen.dart";
import "package:carco/profile.dart";
import "package:carco/welcome.dart";
import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

class SplashScreen extends StatelessWidget{
  const SplashScreen ({super.key});

  get splash => null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen ( 
     splash:
     Column(
      children: [
        Center(
         child: LottieBuilder.asset("assets/assets/assets/Lottie/Animation - 1714745145234.json"),
        )

      ],
    ),
       nextScreen: const welcome(),
       splashIconSize:400,
       backgroundColor: Colors.white,
    );
  }
}

