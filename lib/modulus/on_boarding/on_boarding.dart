import 'package:flutter/material.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../styles/colors.dart';
import '../login_screen/login_screen.dart';

class BoardingModel {
  final String image;

  final String title;

  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  //list of BoardingModel to save the 3 photos
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/on_boarding/p1.png',
      title: "E-COMMERCE",
      body: "Download Our Shopping Application and buy using your smartphone",
    ),
    BoardingModel(
      image: 'assets/on_boarding/p2.png',
      title: "ORDER ONLINE",
      body: "Make an order sitting on a sofa",
    ),
    BoardingModel(
      image: 'assets/on_boarding/p3.png',
      title: "DELIVERY SERVICE",
      body: "Modern Delivering Technologies",
    ),
  ];

  // this var to control of pageView from FloatingActionButton
  var boardController = PageController();

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          const LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            onPressed: () {
              submit();
            },
            text: 'Skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel boarding) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                boarding.image,
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            boarding.title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: defaultColor,),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            boarding.body,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(color: defaultColor,),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      );
}
