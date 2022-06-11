import 'dart:developer';
import 'dart:math' as math;

import 'package:drawer_app/constants.dart';
import 'package:drawer_app/custom_scroll_behavior.dart';
import 'package:drawer_app/drawer.dart';
import 'package:drawer_app/homepage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehavior(),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  var animationController = CustomAnimationControl.stop;
  bool isDrawerOpened = false;
  TimelineTween<Prop> createTween() {
    var size = MediaQuery.of(context).size;
    final tween = TimelineTween<Prop>();
    tween
        .addScene(
          curve: Curves.easeInCirc,
          begin: const Duration(seconds: 0),
          end: const Duration(seconds: 1),
        )
        .animate(Prop.translateX,
            tween: Tween(begin: 0.0, end: size.width - (56 + 20)))
        .animate(
          Prop.radius,
          tween: Tween(begin: 0.0, end: size.height * size.width),
          shiftBegin: const Duration(milliseconds: 850),
        )
        .animate(Prop.translateY,
            tween: Tween(begin: 0.0, end: size.height - (56 + 20)));
    return tween;
  }

  _openDrawer() {
    setState(() {
      animationController = CustomAnimationControl.play;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        isDrawerOpened = true;
      });
    });
  }

  _closeDrawer() {
    setState(() {
      animationController = CustomAnimationControl.playReverse;
      isDrawerOpened = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var tween = createTween();
    return Stack(
      children: [
        CustomAnimation<double>(
          control: animationController,
          curve: Curves.easeIn,
          duration: tween.duration,
          tween: Tween(begin: -MediaQuery.of(context).size.height, end: 0.0),
          builder: (context, child, value) {
            return Transform(
              transform: Matrix4.identity()
                ..translate(
                  0.0, value,
                  // (math.pi / 180) * value),
                ),
              child: child!,
            );
          },
          child: DrawerWidget(),
        ),
        CustomAnimation<TimelineValue<Prop>>(
          tween: tween,
          duration: tween.duration,
          curve: tween.curve,
          control: animationController,
          builder: (context, child, anim) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(anim.get(Prop.radius))),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              transform: Matrix4.identity()
                ..translate(
                    anim.get(Prop.translateX), anim.get(Prop.translateY)),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isDrawerOpened
                    ? _buildCloseDrawerButton()
                    : HomePage(openDrawer: _openDrawer),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCloseDrawerButton() {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: FloatingActionButton(
        backgroundColor: kLightColor,
        onPressed: _closeDrawer,
        child: Icon(Icons.close),
      ),
    );
  }
}
