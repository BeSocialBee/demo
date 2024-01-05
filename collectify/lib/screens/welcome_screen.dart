import 'login.dart';
import 'sign_up.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      // upperBound: 100.0,
      // ! Curve kullanırken upperbound değeri en fazla 1 olabilir o yüzden upperbound kullanılmamalıdır.
    );
    // animation = CurvedAnimation(parent: controller!, curve: Curves.bounceOut);

    animation =
        ColorTween(begin: Colors.red, end: Colors.blue).animate(controller!);
    //! Belirtilen renkler arasında geçiş yaparak bir animasyon oluşturur.

    controller!.forward();
    // controller!.reverse(from: 1.0);
    //! Animasyonun tersten başlamasını sağlar.

    animation!.addStatusListener((status) {
      print(status);
      //! Animasyonun tamamlanma durumunu gösterir.
      /*
      if(status == AnimationStatus.completed){
        controller!.reverse(from: 1.0);
      }
      else if( status == AnimationStatus.dismissed){
        controller!.forward();
      }*/
      //! Yukarıdaki if-else, animasyonun sonsuz halde tekrar etmesini sağlıyor.
    });

    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
  //! Animasyonun fazla kaynak harcamaması için dispose fonskiyonu kullanılır.
  //! Başka sayfaya geçildiğinde animasyonun arka planda çalışmasını önler.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    //height: animation!.value * 100,

                    height: 60,
                  ),
                ),
                //! AnimatedTextKit paketi yazılar için animasyon sunan bir pakettir.
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      '${controller!.value.toInt()}%',
                      textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TyperAnimatedText(
                      'Flash Chat',
                      textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                  stopPauseOnTap: true,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              colour: Colors.lightBlueAccent,
              buttonTitle: 'Log in',
              buttonCallback: () {
                //Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              colour: Colors.blueAccent,
              buttonTitle: 'Register',
              buttonCallback: () {
                //Navigator.pushNamed(context, RegistrationScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
