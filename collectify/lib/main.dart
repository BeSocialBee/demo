import 'package:collectify/screens/achievements.dart';
import 'package:collectify/screens/create_profile.dart';
import 'package:collectify/screens/daily_spin_screen.dart';
import 'package:collectify/screens/leaderboard.dart';
import 'package:collectify/screens/login.dart';
import 'package:collectify/screens/home.dart';
import 'package:collectify/screens/market.dart';
import 'package:collectify/screens/my_account.dart';
import 'package:collectify/screens/my_collections.dart';
import 'package:collectify/screens/search.dart';
import 'package:collectify/screens/sign_up.dart';
import 'package:collectify/screens/splash_screen.dart';
import 'package:collectify/screens/visitorHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icon.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'api/firebase_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
      apiKey: "AIzaSyAfn5y0hEhLo-7z-qE4cOM-G7uzvCuAdSA",
      appId: "collectify-e6bbe",
      messagingSenderId: "4418173781",
      projectId: "collectify-e6bbe",
    ),
  );
  //await FirebaseApi().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BoolProvider(),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            "/MainPage": (context) => MainPage(),
            "/Home": (context) => Home(),
            "/Login": (context) => LoginScreen(),
            "/Signup": (context) => SignUpScreen(),
            "/MyCollection": (context) => MyCollection(),
            "/Market": (context) => Market(),
            "/Leaderboard": (context) => LeaderBoardScreen1(),
            "/MyAccount": (context) => MyAccount(),
            "/CreateProfile": (context) => CreateProfile(),
            "/visitorHome": (context) => VisitorHome(),
          },
          debugShowCheckedModeBanner: false,
          title: "Collectify",
          home: SplashScreen(),
        ));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeFirebase(); // Call the function to initialize Firebase
  }

  // Function to initialize Firebase
  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      print("Firebase initialized.");
    } catch (e) {
      print("Error initializing Firebase: $e");
    }
  }

  Widget? _getpage(int _currentIndex) {
    switch (_currentIndex) {
      case 0:
        return Home();
      case 1:
        return Market();
      case 2:
        return Achievements();
      case 3:
        return LeaderBoardScreen1();
      case 4:
        return MyCollection();
      // case 4:
      //   return MyAccount();
      default:
        return Center(
          child: Text("Welcome to ${_currentIndex} page"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        "/Home": (context) => Home(),
        "/Login": (context) => LoginScreen(),
        "/Signup": (context) => SignUpScreen(),
        "/MyCollection": (context) => MyCollection(),
        "/Market": (context) => Market(),
        "/Leaderboard": (context) => LeaderBoardScreen1(),
        "/MyAccount": (context) => MyAccount(),
        "/CreateProfile": (context) => CreateProfile(),
        "/visitorHome": (context) => VisitorHome(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _getpage(_currentIndex),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Home'),
              activeColor: Colors.red,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: LineIcon.shoppingCart(),
              title: Text('Market'),
              activeColor: Colors.purpleAccent,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: FaIcon(
                FontAwesomeIcons.trophy,
                color: Colors.yellow,
                size: 20,
              ),
              title: Text(
                'Rewards',
              ),
              activeColor: Colors.pink,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.leaderboard),
              title: Text('Ranks'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.card_travel),
              title: Text('My Cards'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          //bottomNavigationBar: myBottomNavigationBar(),
          ),
      // initialRoute: MainPage.id,
      routes: {
        // MainPage.id: (context) => MainPage(),
        // Market.id: (context) => Market(),
        // MyCollection.id: (context) => MyCollection(),
      },
    );
  }
}
