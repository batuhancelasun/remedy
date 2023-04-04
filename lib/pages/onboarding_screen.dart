import 'package:flutter/material.dart';

import '../component/onboarding_page.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  PageController controller = PageController(initialPage: 0);

  //We use this function to change the screen.
  void changeScreen(int nextScreenNo) {
    controller.animateToPage(nextScreenNo,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(208, 242, 255, 1),
      body: PageView(
        controller: controller,
        //User has to click next or skip to change screen. They can not scroll the screen and change it.
        physics: const NeverScrollableScrollPhysics(),
        children: [
          //We use our onboarding page model to create our onboarding screen easily.
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
}
