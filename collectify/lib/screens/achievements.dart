import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:collectify/utils/sharedpref_util.dart';


class Achievements extends StatefulWidget {
  const Achievements({super.key});

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  late Future<List<dynamic>> achievementList;
  late Future<List<dynamic>> userAchievementList;
  late Future<List<dynamic>> isAchieved;


  @override
  void initState() {
    super.initState();
    achievementList = getAchievements();
    userAchievementList = getUserAchievements();
  }


  // Define the getUserInfo function
  Future<List<dynamic>> getAchievements() async {
    try {
      String apiUrl =
          'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/getAchievements';
      var response = await http.get(
        Uri.parse(apiUrl),
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Request successful, you can handle the response data here
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> jsonArray = jsonResponse['achievements'] ?? [];

        return jsonArray;
      } else {
        // Request failed, handle the error
        print('Error response: ${response.statusCode}');
        throw Exception('Failed to get achievementss.');
      }
    } catch (e){
      // Handle errors, such as invalid credentials
      print('Errorloading profile: $e');
      throw Exception('Failed to get achievements Error: $e');
    }
  }


  // Define the getUserInfo function
  Future<List<dynamic>> getUserAchievements() async {
    try {
      var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
      String apiUrl =
          'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/userAchievements';
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'userID': userID,
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Request successful, you can handle the response data here
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> jsonArray = jsonResponse['achievements'] ?? [];


        return jsonArray;
      } else {
        // Request failed, handle the error
        print('Error response: ${response.statusCode}');
        throw Exception('Failed to get user achievementss fixedd.');
      }
    } catch (e) {
      // Handle errors, such as invalid credentials
      print('Errorloading profile: $e');
      throw Exception('Failed to get user achievements  Error: $e');
    }
  }


  

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: const Text("Achievements"),
    ),
    body: Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10, bottom: 20),
      child: FutureBuilder<List<dynamic>>(
        future: Future.wait([achievementList, userAchievementList]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // or some loading indicator
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          List<dynamic> achievements = snapshot.data![0];
          List<dynamic> userAchievements = snapshot.data![1];

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
            ),
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              bool isAchieved = userAchievements.contains(achievements[index]['docID']);

              if (isAchieved) {
                return AchievedWidget(
                  achievementTitle: achievements[index]['title'],
                  achievementURL: achievements[index]['starURL'],
                );
              } else {
                return UnachievedWidget(
                  achievementTitle: achievements[index]['title'],
                  achievementURL: achievements[index]['starURL'],
                );
              }
            },
          );
        },
      ),
    ),
  );
}
}



class AchievedWidget extends StatelessWidget {
  
  final String achievementTitle;
  final String achievementURL;

  const AchievedWidget(
      {super.key, required this.achievementTitle,  required this.achievementURL});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://cdn.vectorstock.com/i/preview-1x/93/60/royal-achievement-concept-3d-insignia-vector-42179360.jpg'),
        ),
        const SizedBox(
          height: 5,
        ),
        Text('${achievementTitle}'),
      ],
    );
  }
}


class UnachievedWidget extends StatelessWidget {
  const UnachievedWidget(
      {super.key, required this.achievementTitle,  required this.achievementURL});

  final String achievementTitle;
  final String achievementURL;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30), // Set your desired radius
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.grey, // Change this color to customize the grey shade
              BlendMode.saturation,
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://cdn.vectorstock.com/i/preview-1x/93/60/royal-achievement-concept-3d-insignia-vector-42179360.jpg'),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text('${achievementTitle}'),
      ],
    );
  }
}
