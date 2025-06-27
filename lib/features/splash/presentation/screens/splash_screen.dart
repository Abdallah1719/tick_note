import 'package:flutter/material.dart';
import 'package:tick_note/core/routes/routes_constances.dart';
import 'package:tick_note/core/routes/routes_methods.dart';
import 'package:tick_note/core/utils/index.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.primaryColor,
      body: SplashScreenBody(),
    );
  }
}

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    fadingAnimation = Tween<double>(
      begin: .2,
      end: 1.2,
    ).animate(animationController!);

    animationController?.repeat(reverse: true);
    // bool isOnBoardingVisited =
    //     getIt<CacheHelper>().getData(key: "isOnBoardingVisited") ?? false;
    // if (isOnBoardingVisited == true) {
    goToNextView(context, RoutesConstances.notesPath);
    // } else {
    //   goToNextView(context, RoutesConstances.onBoardingPath);
    // }
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeTransition(
          opacity: fadingAnimation!,
          child: Center(
            child: Text(
              'Tick Note',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  void goToNextView(context, path) {
    Future.delayed(Duration(seconds: 3), () {
      RoutesMethods.replacementNavigate(context, path);
    });
  }
}
