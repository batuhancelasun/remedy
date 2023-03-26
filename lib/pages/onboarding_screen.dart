import 'package:flutter/material.dart';
import 'package:remedy/component/onboarding_page.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(208, 242, 255, 1),
      body: PageView(
        controller: controller,
        //physics: const NeverScrollableScrollPhysics(), //kaydırarak geçme
        children: [
          OnBoardingPage(
            image: Image.asset("images/remedy.png"),
            title: "Welcome",
            description:
                "Welcome to best and only pharmacy app. Let us introduce the app to you.",
            noOfScreen: 3,
            onNextPressed: changeScreen,
            currentScreenNo: 0,
            onSkipPressed: changeScreen,
          ),
          OnBoardingPage(
            image: Image.asset("images/delivery.png"),
            title: "Fastest Delivery",
            description: "We offer fastest delivery you have ever seen.",
            noOfScreen: 3,
            onNextPressed: changeScreen,
            currentScreenNo: 1,
            onSkipPressed: changeScreen,
          ),
          OnBoardingPage(
            image: Image.asset("images/welcome.png"),
            title: "Let's Get Started",
            description: "Log in or sign up to meet new era of the pharmacy.",
            noOfScreen: 3,
            onNextPressed: changeScreen,
            currentScreenNo: 2,
            onSkipPressed: changeScreen,
          ),
        ],
      ),
    );
  }

  void changeScreen(int nextScreenNo) {
    controller.animateToPage(nextScreenNo,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic);
  }
}
