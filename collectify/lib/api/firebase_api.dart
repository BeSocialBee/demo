import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final FirebaseMessaging messaging  = FirebaseMessaging.instance;
  
  Future<void> initNotification() async {
    await messaging .requestPermission();
    final fcmToken = await messaging .getToken().then((token) {
      print("Firebase Messaging Token: $token\n");
    });

    print('token: $fcmToken');
  }
}
