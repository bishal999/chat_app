import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/components/rounded_button.dart';

class welcome_screen extends StatefulWidget {
  static const String id = "welcome_screen";
  @override
  State<welcome_screen> createState() => _welcome_screenState();
}

class _welcome_screenState extends State<welcome_screen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    // animation.addStatusListener((status) {
    //  if(status==AnimationStatus.completed)
    //  {
    //    controller.reverse(from: 1.0);
    //  }
    //  else if(status==AnimationStatus.dismissed)
    //  {
    //    controller.forward();
    //  }
    // });
    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: animation.value,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('images/logo.png'),
                              height: 70,
                            ),
                            TypewriterAnimatedTextKit(
                              text: ['Flash Chat'],
                              textStyle: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w800,
                                color: Colors.amberAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Roundedbutton(
                onpressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                colour: Colors.blueAccent,
                title: "Login",
              ),
              Roundedbutton(
                onpressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                title: "Register",
                colour: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
