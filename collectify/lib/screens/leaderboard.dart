import 'package:collectify/screens/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icon.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaderBoardScreen1 extends StatefulWidget {
  @override
  State<LeaderBoardScreen1> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen1> {
  late Future<List<dynamic>> leaderboardData;
  FluttermojiFunctions fluttermoji = FluttermojiFunctions();

  @override
  void initState() {
    super.initState();
    leaderboardData = getLeaderBoard();
  }

  Future<List<dynamic>> getLeaderBoard() async {
    try {
      String apiUrl =
          'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/getLeaderboard';
      var response = await http.get(
        Uri.parse(apiUrl),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            jsonDecode(response.body); // Decode the response body as a Map
        final List<dynamic> jsonArray = jsonResponse['usersData'] ??
            []; // Access the "cardsData" key to get the array of cards
        return jsonArray;
      } else {
        throw Exception(
            'Failed to fetch cards.'); // Request failed, handle the error
      }
    } catch (e, stackTrace) {
      print('Failed to get leaderboard.Error: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to get leaderboard. Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Leaderboard',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Outfit',
                  color: Color(0xFF14181B),
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: FutureBuilder(
        future: leaderboardData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data available.'),
            );
          } else {
            var user1 = snapshot.data![0];
            var user2 = snapshot.data![1];
            var user3 = snapshot.data![2];
            print(fluttermoji.decodeFluttermojifromString(user2['avatarURL']));
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          WinnerContainer(
                            url: fluttermoji.decodeFluttermojifromString(
                                user2['avatarURL']),
                            winnerName: user2['username'],
                            height: 120,
                            rank: '2',
                            balance: user2['balance'].toDouble(),
                            showcaseCardURL: user2['showcase_card'],
                            color: Colors.green,
                          ),
                          WinnerContainer(
                            // Birinci kişinin bilgileri
                            isFirst: true,
                            color: Colors.orange,
                            url: fluttermoji.decodeFluttermojifromString(
                                user1['avatarURL']),
                            winnerName: user1['username'],

                            balance: user1['balance'].toDouble(),
                            showcaseCardURL: user1['showcase_card'],
                          ),
                          WinnerContainer(
                            //Üçüncü kişinin bilgileri
                            url: fluttermoji.decodeFluttermojifromString(
                                user3['avatarURL']),
                            winnerName: user3['username'],

                            balance: user3['balance'].toDouble(),
                            showcaseCardURL: user3['showcase_card'],
                            height: 120,
                            rank: '3',
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 760.0,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0)),
                              color: Colors.white),
                          child: ListView.builder(
                              itemCount: snapshot.data!.length - 3,
                              itemBuilder: (context, index) {
                                var user = snapshot.data![index + 3];
                                return ContestantList(
                                  url: fluttermoji.decodeFluttermojifromString(
                                      user['avatarURL']),
                                  name: user['username'],
                                  balance: user['balance'].toDouble(),
                                  showcaseCardURL: user['showcase_card'],
                                  rank: '${index + 4}',
                                );
                              }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class WinnerContainer extends StatelessWidget {
  bool? isFirst;
  Color? color;
  String? winnerPosition;
  String? url;
  String? winnerName;
  String? rank;
  double? height;
  String? showcaseCardURL;
  double? balance;
  WinnerContainer(
      {this.isFirst = false,
      this.color,
      this.balance,
      this.showcaseCardURL,
      this.winnerPosition,
      this.winnerName,
      this.rank,
      this.height,
      this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileView(
                      url: url!,
                      username: winnerName!,
                      showcaseCardURL: showcaseCardURL!,
                      balance: balance!,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.yellow.shade600,
                      Colors.orange,
                      Colors.red
                    ]),
                    border: Border.all(
                      color:
                          Colors.amber, //kHintColor, so this should be changed?
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: height ?? 150.0,
                      width: 100.0,
                      decoration: const BoxDecoration(
                        color: MyColors.calculatorButton,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Stack(
                children: [
                  if (isFirst!)
                    Image.asset(
                      'images/taj.png',
                      height: 70.0,
                      width: 105.0,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 30.0),
                    child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.yellow.shade600,
                            Colors.orange,
                            Colors.red
                          ]),
                          border: Border.all(
                            color: Colors
                                .amber, //kHintColor, so this should be changed?
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipOval(
                              clipBehavior: Clip.antiAlias,
                              child: Center(
                                  child: CircleAvatar(
                                child: SvgPicture.string(
                                  url!,
                                  height: 200, // Set your desired height
                                  width: 200, // Set your desired width
                                ),
                              ))),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 115.0, left: 45.0),
                    child: Container(
                      height: 20.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color ?? Colors.red,
                      ),
                      child: Center(
                          child: Text(
                        rank ?? '1',
                        style: const TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 150.0,
              child: Container(
                width: 100.0,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        winnerName ?? 'Emma Aria',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        rank ?? '1',
                        style: TextStyle(
                          color: color ?? Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContestantList extends StatelessWidget {
  String? url;
  String? name;
  String? rank;
  String? showcaseCardURL;
  double? balance;
  ContestantList({
    this.url,
    this.name,
    this.rank,
    this.balance,
    this.showcaseCardURL,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileView(
                      url: url!,
                      username: name!,
                      showcaseCardURL: showcaseCardURL!,
                      balance: balance!,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, bottom: 5.0, top: 10.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Colors.orange,
              Colors.red,
              Colors.yellow,
            ]),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.calculatorButton,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child: Center(
                              child: CircleAvatar(
                            child: SvgPicture.string(
                              url!,
                              height: 200, // Set your desired height
                              width: 200, // Set your desired width
                            ),
                          ))),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name ?? 'Name',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          '@${name ?? 'Name'}',
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 12.0),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          rank ?? '1234',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyColors {
  static const grey = const Color(0xFFD1D4D9);
  static const darkGrey = const Color(0xFF212121);
  static const white = Colors.white;
  static const orange = const Color(0xFFC86300);
  static const green = const Color(0xFF27AD00);
  static const red = const Color(0xFFD6000C);
  static const yellow = const Color(0xFFFAB700);
  static const black = const Color(0xFF252525);
  static const blue = const Color(0xFF000FA5);
  static const backgroundGrey = const Color(0xFFE1E3E5);
  static const blueGrey = const Color(0xFF444b59);
  static const brown = const Color(0xFFD2691E);

  static const patientPrimary = const Color(0xFF0F7F85);
  static const hospitalPrimary = const Color(0xFF0F7F85);
  static const physicianPrimary = const Color(0xFF0F7F85);
  static const manufacturerPrimary = const Color(0xFF0F7F85);

  static const fdaPrimary = const Color(0xFFC48253);
  static const insurancePrimary = const Color(0xFFCE8789);
  static const messages = const Color(0xFFA09EAF);
  static const baseThemePrimary = const Color(0xFF0F7F85);
  static const devicecolor = const Color(0xFFD5AB5A);
  static const selectedGrey = const Color(0xFFE2E2E2);
  static const formBackground = Colors.white;

  static const selectedMenuItem = const Color(0xFF414D55);
  static const textBoxBackground = Colors.white;
  static const backGroundColor = const Color(0xFF454F62);
  static const containerbBodyColor = const Color(0xFFE5E5E5);
  static const sideBarGradient1 = const Color(0xFFD5D5D5);
  static const sideBarGradient2 = const Color(0xFFFFFFFF);

  static const sideIcon = const Color(0xFF0A1F44);
  static const sideIconSelected = const Color(0xFF16BDC7);
  static const header = const Color(0xFF1F3C51);
  static const backGroundGradient1 = const Color(0xFFE2E2E2);
  static const backGroundGradient2 = const Color(0xFFF0F0F0);
  static const mobileBodyColor = const Color(0xFF1B3C51);
  static const messageMenuBackgroubd = const Color(0xFF262A31);
  static const mMenuColor = const Color(0xFF1D394E);
  static const mColor = const Color(0xFF93AE4A);
  static const menuBorderColor = const Color(0xFF676464);
  static const menuActive = const Color(0xFF0F7F85);
  static const menuDeActive = const Color(0xFF1D394E);

  static const lightPink = const Color(0xffee6cb6);
  static const lightPink1 = const Color(0xffea76c4);
  static const lightPink2 = const Color(0xffe680d2);
  static const lightPink3 = const Color(0xffe08ade);
  static const lightPink4 = const Color(0xffda94e9);
  static const lightPink5 = const Color(0xffcd98f0);
  static const lightPink6 = const Color(0xffbf9df5);
  static const lightPink7 = const Color(0xffb0a1f9);
  static const lightPink8 = const Color(0xff95a1f9);
  static const lightPink9 = const Color(0xff76a1f7);
  static const lightPink10 = const Color(0xff52a0f2);
  static const lightPink11 = const Color(0xff149feb);

  static const lightBlue = const Color(0xffB07EE8);
  static const darkRed = const Color(0xffBC082B);

  static const darkGreen = const Color(0xff1c2025);
  static const lightGreen = const Color(0xff2d2f3a);
  static const lightOrange = const Color(0xfffaa587);

  static const lightChocolate = const Color(0xff525151);
  static const lightChocolate1 = const Color(0xff393939);
  static const lightChocolate2 = const Color(0xff363636);

  static const lightGreen2 = const Color(0xff15667D);
  static const lightGreen3 = const Color(0xff53AFC9);

  static const darkPink = const Color(0xffff00c4);
  static const lightOrange2 = const Color(0xfff18a5c);
  static const lightblue3 = const Color(0xff5cc8f1);
  static const lightbegini3 = const Color(0xff745cf1);
  static const lightpink3 = const Color(0xffc55cf1);

  static const lightGrn3 = const Color(0xff5cf198);
  static const lightyellow3 = const Color(0xfff1d85c);
  static const lightRed3 = const Color(0xfff15c5c);
  static const lightBack3 = const Color(0xfff8f8fb);

  //calculator Colors

  static const calculatorScreen = const Color(0xff222433);
  static const calculatorButton = const Color(0xff2C3144);
  static const calculatorFunctionButton = const Color(0xff35364A);
  static const calculatorYellow = const Color(0xffFEBc06);

  //car booking colors

  static const carButtonColor = const Color(0xff1e75ff);
  static const carLeftTopColor = const Color(0xff32a9fd);
  static const carLeftBottomColor = const Color(0xff1055e1);
  static const carRightTopColor = const Color(0xff23233d);
  static const carRightBottomColor = const Color(0xff08070d);

  //Game Home Screen
  static const gameHomeRight1 = const Color(0xff35abe9);
  static const gameHomeRight2 = const Color(0xff454ce5);

  static const gameHomeLeft1 = const Color(0xff232941);
  static const gameHomeLeft2 = const Color(0xff171925);
}
