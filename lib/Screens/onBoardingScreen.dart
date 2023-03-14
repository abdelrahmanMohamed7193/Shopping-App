import 'package:flutter/material.dart';
import 'package:shoppingapp/Screens/shop_login_screen.dart';
import 'package:shoppingapp/shared/component.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../network/local/cash_helper.dart';


class BoardingModel {
  final String? image;
  final String? title;
  final String? body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> Boarding = [
    BoardingModel(
      image: "assets/images/onBoarding1.jpg",
      title: 'onBoard 1 title',
      body: 'onBoard 1 body',
    ),
    BoardingModel(
      image: "assets/images/onBoarding1.jpg",
      title: 'onBoard 2 title',
      body: 'onBoard 2 body',
    ),
    BoardingModel(
      image: "assets/images/onBoarding1.jpg",
      title: 'onBoard 3 title',
      body: 'onBoard 3 body',
    ),
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          myDefaultTextButton(
              function: () {
               submit() ;
              },
              text: "skip" ,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == Boarding.length - 1) {
                    setState(() {
                      isLast = true;
                      // print("lastOne");
                    });
                  } else {
                    setState(() {
                      isLast = false;
                      //(print("Not Last"));
                    });
                  }
                },
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(Boarding[index]),
                itemCount: Boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: Boarding.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.deepPurple,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                     submit() ;

                    } else {
                    boardController.nextPage(
                    duration: const Duration(
                    milliseconds: 750,
                    ),
                    curve: Curves.fastLinearToSlowEaseIn,
                    );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }


  void submit() {
    CashHelper.saveData(
      key:"onBoarding",
      value: true,
    ).then((value) {
      if (value==true) {
        navigateAndFinish(
          context: context,
          widget: ShopLoginScreen(),
        );
      }
    });
  }

  Widget buildBoardingItem(BoardingModel model) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage("${model.image}"),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text("${model.title}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 20.0,
          ),
          Text("${model.body}",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
        ],
      );
}
