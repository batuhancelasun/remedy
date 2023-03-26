import 'package:flutter/material.dart';
import 'package:remedy/component/rounded_button.dart';
import 'package:remedy/pages/login_register_page.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(
      {Key? key,
      required this.image,
      required this.title,
      required this.description,
      required this.noOfScreen,
      required this.onNextPressed,
      required this.currentScreenNo,
      required this.onSkipPressed})
      : super(key: key);

  final Image image;

  final String title;

  final String description;

  final int noOfScreen;

  final Function(int) onNextPressed;

  final int currentScreenNo;

  final Function(int) onSkipPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image,
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 30, color: Color.fromRGBO(3, 65, 114, 1)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      description,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedButton(
                    title: "Skip",
                    onPressed: () {
                      onSkipPressed(currentScreenNo + 2);
                    }),
                Row(
                  children: [
                    for (int index = 0; index < noOfScreen; index++)
                      createProggressDots(
                          (index == currentScreenNo) ? true : false)
                  ],
                ),
                RoundedButton(
                    title: "Next",
                    onPressed: () {
                      if (currentScreenNo == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      } else {
                        onNextPressed(currentScreenNo + 1);
                      }
                    })
              ],
            )
          ],
        ));
  }

  Widget createProggressDots(bool isActiveScreen) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActiveScreen ? 15 : 10,
      width: 10,
      decoration: BoxDecoration(
          color: isActiveScreen
              ? const Color.fromRGBO(82, 222, 160, 1)
              : const Color.fromRGBO(3, 65, 114, 1),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}
