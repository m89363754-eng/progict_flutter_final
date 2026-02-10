import 'package:flutter/material.dart';
import 'package:flutter_application_14/features/Into_of_app/FirstPage.dart';
import 'package:flutter_application_14/features/Into_of_app/SecondPage.dart';
import 'package:flutter_application_14/features/Into_of_app/ThirdPage.dart';
 
class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}
class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();
  int currentIndex = 0;
  List <Widget>pages = [
    FirstPage(),
    SecondPage(),
    ThirdPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 40),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "ProTask",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children: pages,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: currentIndex == index ? 25 : 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.black
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (currentIndex < 2) {
                    controller.nextPage(
                      duration: Duration(milliseconds:200),
                      curve: Curves.easeIn,
                    );
                  }
                },
                child: Text(
                  currentIndex == 2 ? "Get Started" : "Continue",
                  style:
                  
                   TextStyle(fontSize: 18 ,color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}