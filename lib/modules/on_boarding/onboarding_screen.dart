import 'package:flutter/material.dart';
import 'package:shop_application/modules/login/shop_login_screen.dart';
import 'package:shop_application/shared/components/componants.dart';
import 'package:shop_application/shared/network/local/cache_helper.dart';
import 'package:shop_application/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.title,
    @required this.image,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      title: 'On boarding 1 Title',
      image: "lib/assets/onboarding_1.png",
      body: "On Boarding 1 body",
    ),
    BoardingModel(
      title: 'On boarding 2 Title',
      image: "lib/assets/onboarding_1.png",
      body: "On Boarding 2 body",
    ),
    BoardingModel(
      title: 'On boarding 3 Title',
      image: "lib/assets/onboarding_1.png",
      body: "On Boarding 3 body",
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.savaData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(
              text: 'SKIP',
              function: submit,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(
                        () {
                          isLast = true;
                        },
                      );
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: <Widget>[
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

Widget buildBoardingItem(BoardingModel boardingModel) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Image(
            image: AssetImage("${boardingModel.image}"),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "${boardingModel.title}",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "${boardingModel.body}",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
