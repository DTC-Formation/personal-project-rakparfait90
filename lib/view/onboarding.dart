import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/fandraisana.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return OnBoardingSlider(
      headerBackgroundColor: Colors.white,
      finishButtonText: 'Get Started',
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
      ),
      onFinish: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const Fandraisana(),
          ),
        );
      },
      skipTextButton: const Icon(
        Icons.close_outlined,
        color: primary,
      ),
      skipIcon: const Icon(
        Icons.close_outlined,
        color: primary,
      ),
      background: [
        Image.asset(
          'assets/images/onboarding/chapelet.jpg',
          height: size.height,
        ),
        Image.asset(
          'assets/images/onboarding/chapelet.jpg',
          height: size.height,
        ),
        Image.asset(
          'assets/images/onboarding/chapelet.jpg',
          height: size.height,
        ),
      ],
      totalPage: 3,
      speed: 1.8,
      pageBodies: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Column(
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'Ne manquez jamais une prière avec notre rappel de prière',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Column(
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'Suivez les lectures quotidiennes avec des réflexions quotidiennes.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Column(
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'Suivez les lectures quotidiennes avec des réflexions quotidiennes.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
