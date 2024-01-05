//import 'dart:html';

import 'package:collectify/screens/card_details.dart';
import 'package:collectify/screens/card_in_auction.dart';
import 'package:collectify/screens/card_in_quickBuy.dart';
import 'package:line_icons/line_icon.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:line_icons/line_icons.dart';
import 'package:collectify/utils/sharedpref_util.dart';
import 'dart:async';

//import 'package:collectify/sharedpref_util.dart';

class Market extends StatefulWidget {
  const Market({Key? key}) : super(key: key);

  @override
  _ListProductsWidgetState createState() => _ListProductsWidgetState();
}

class _ListProductsWidgetState extends State<Market>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static String id = 'market_screen';

  late Future<List<dynamic>> auctionCards;
  late Future<List<dynamic>> fixedPriceCards;
  late Future<Map<String, dynamic>> user;
  late String? token;
  late TabController tabController = TabController(length: 2, vsync: this);
  late Map<String, StreamController<num>> countdownControllers; // Add this line

  @override
  void initState() {
    super.initState();
    fixedPriceCards = getFixedMarket();
    auctionCards = getAuctionMarket();
    user = getUser();
    countdownControllers = {}; // Initialize the map
    tabController = TabController(length: 2, vsync: this);
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
      token = userID;

      String apiUrl =
          'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/getUser';
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'userID': userID,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final Map<String, dynamic> jsonArray = jsonResponse['userData'] ?? {};
        return jsonArray;
      } else {
        print('Error response: ${response.statusCode}');
        throw Exception('Failed to get user data');
      }
    } catch (e) {
      print('Error loading profile: $e');
      throw Exception('Failed to get user data');
    }
  }

  // Define the getUserInfo function
  Future<List<dynamic>> getFixedMarket() async {
    try {
      String apiUrl =
          'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/userFixedMarketCards';
      var response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        // Decode the response body as a Map
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Access the "cardsData" key to get the array of cards
        final List<dynamic> jsonArray = jsonResponse['cardsData'] ?? [];

        // Optional: You might want to convert each item in the list to a strongly typed object
        //final List<Map<String, dynamic>> cardList = jsonArray.map((item) => item as Map<String, dynamic>).toList();
        //print(jsonArray);
        return jsonArray;
      } else {
        // Request failed, handle the error

        throw Exception('Failed to fetch cards.');
      }
    } catch (e, stackTrace) {
      print('Failed to fetch cards fixedd. Error: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to fetch cards fixedd. Error: $e');
    }
  }

// Define the getUserInfo function
  Future<List<dynamic>> getAuctionMarket() async {
    try {
      String apiUrl =
          'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/getAllAuctions';
      var response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        // Decode the response body as a Map
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Access the "cardsData" key to get the array of cards
        final List<dynamic> jsonArray = jsonResponse['cardsData'] ?? [];

        // Optional: You might want to convert each item in the list to a strongly typed object
        //final List<Map<String, dynamic>> cardList = jsonArray.map((item) => item as Map<String, dynamic>).toList();
        //print(jsonArray);
        return jsonArray;
      } else {
        // Request failed, handle the error

        throw Exception('Failed to fetch cards.');
      }
    } catch (e) {
      throw Exception('Failed to fetch cards auctionn.');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    @override
    void dispose() {
      tabController.dispose();
      super.dispose();
    }

    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Market',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Outfit',
                    color: Color(0xFF14181B),
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4),
              child: Row(
                children: [
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22, right: 12),
                      child: Container(
                        height: 40,
                        child: FutureBuilder(
                          future: user,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(''),
                              );
                            } else {
                              var userrr = snapshot.data!;
                              return Row(
                                children: [
                                  Text(
                                    userrr['balance'].toStringAsFixed(2),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF14181B),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  LineIcon.coins(
                                    color: Colors.yellow,
                                    size: 30,
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  )
                ],
              ),
            ),
          ],
          centerTitle: true,
          elevation: 2,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment(0, 0),
                    child: FlutterFlowButtonTabBar(
                      useToggleButtonStyle: false,
                      isScrollable: true,
                      labelStyle:
                          FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                      unselectedLabelStyle: TextStyle(),
                      labelColor: Color(0xFF4B39EF),
                      unselectedLabelColor: Color(0xFF57636C),
                      backgroundColor: Color(0x4C4B39EF),
                      borderColor: Color(0xFF4B39EF),
                      borderWidth: 2,
                      borderRadius: 12,
                      elevation: 0,
                      labelPadding:
                          EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      buttonMargin:
                          EdgeInsetsDirectional.fromSTEB(0, 12, 16, 0),
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      tabs: [
                        Tab(
                          text: 'Auction',
                        ),
                        Tab(
                          text: 'Quick Buy',
                        ),
                      ],
                      controller: tabController,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        FutureBuilder<List<dynamic>>(
                          future: auctionCards,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(''),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 4,
                                          crossAxisSpacing: 4,
                                          childAspectRatio: 0.6),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var card = snapshot.data![index];
                                    // Create a StreamController for each card
                                    if (!countdownControllers
                                        .containsKey(card['documentID'])) {
                                      countdownControllers[card['documentID']] =
                                          StreamController<num>();
                                    }
                                    return AuctionCardWidget(
                                      cardPrice: card['currentBid'].toDouble(),
                                      cardUrl: card['cardURL'],
                                      cardId: card['cardID'],
                                      documentID: card['documentID'],
                                      ownerID: card['userID'],
                                      endingTimeString: card['endingTime'],
                                      token: token,
                                      countdownStreamController:
                                          countdownControllers[
                                              card['documentID'].toString()]!,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                        FutureBuilder<List<dynamic>>(
                            future: fixedPriceCards,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(
                                  child: Text('No data available.'),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 4,
                                            crossAxisSpacing: 4,
                                            childAspectRatio: 0.8),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var card = snapshot.data![index];

                                      return QuickBuyCardWidget(
                                        cardPrice: card['cardPrice'].toDouble(),
                                        cardUrl: card['cardURL'],
                                        cardId: card['cardID'],
                                        documentID: card['documentID'],
                                      );
                                    },
                                  ),
                                );
                              }
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuickBuyCardWidget extends StatelessWidget {
  final String? cardUrl;
  final double? cardPrice;
  final String? cardId;
  final String? documentID;

  QuickBuyCardWidget({
    required this.cardPrice,
    required this.cardUrl,
    required this.cardId, // Pass cardId in the constructor
    required this.documentID,
    super.key,
  });

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuickBuyScreenWidget(
                      documentID: documentID!,
                    ))); // Constructer içine gerekli inputları yaz
      },
      child: Container(
        height: 800,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      '${cardUrl}',
                      width: double.infinity,
                      height: 190,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '\$ ${cardPrice?.toStringAsFixed(2) ?? ''}',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF14181B),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuickBuyScreenWidget(
                                        documentID: documentID!)));
                          },
                          text: 'View',
                          options: FFButtonOptions(
                            width: 120,
                            height: 30,
                            padding:
                                EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                            iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).tertiary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Outfit',
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuctionCardWidget extends StatefulWidget {
  final String? cardUrl;
  final double? cardPrice;
  final String? cardId;
  final String? documentID;
  final String? ownerID;
  final String? token;
  final String? endingTimeString;
  final StreamController<num> countdownStreamController;

  AuctionCardWidget({
    required this.cardPrice,
    required this.cardUrl,
    required this.cardId,
    required this.documentID,
    required this.ownerID,
    required this.token,
    required this.endingTimeString,
    required this.countdownStreamController, // No need to create a new one here
    Key? key,
  }) : super(key: key);

  @override
  State<AuctionCardWidget> createState() => _AuctionCardWidgetState();
}

class _AuctionCardWidgetState extends State<AuctionCardWidget> {
  @override
  void initState() {
    super.initState();
    calculateRemainingTime(
      widget.endingTimeString,
      widget.countdownStreamController,
      widget.documentID,
    );
  }

  @override
  void dispose() {
    widget.countdownStreamController.close();
    super.dispose();
  }

  Widget build(BuildContext context) {
    String twoDigits(num n) {
      return n >= 10 ? "$n" : "0$n";
    }

    return GestureDetector(
      child: Container(
        height: 800,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      '${widget.cardUrl}',
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 4),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Auction ends in: ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Outfit',
                                    fontSize: 20,
                                  ),
                            ),
                            StreamBuilder<num>(
                              stream: widget.countdownStreamController.stream,
                              builder: (context, snapshot) {
                                // Check if the stream is closed or has no listeners
                                if (widget.countdownStreamController.isClosed ||
                                    !widget.countdownStreamController
                                        .hasListener) {
                                  return Container(); // Placeholder widget or empty container
                                }
                                if (snapshot.hasData) {
                                  num secondsRemaining = snapshot.data!;
                                  num hours = secondsRemaining ~/ 3600;
                                  num minutes = (secondsRemaining % 3600) ~/ 60;
                                  num seconds = secondsRemaining % 60;

                                  return Text(
                                    '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}',
                                    style: TextStyle(fontSize: 18),
                                  );
                                } else {
                                  return Container(); // Placeholder widget
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '\$ ${widget.cardPrice!.toStringAsFixed(2)}',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF14181B),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                              Container(child: Builder(
                                builder: ((context) {
                                  if (widget.ownerID != widget.token) {
                                    return FFButtonWidget(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AuctionScreenWidget(
                                                        documentID: widget
                                                            .documentID!)));
                                      },
                                      text: 'Bid',
                                      options: FFButtonOptions(
                                        width: 80,
                                        height: 30,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 20, 0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                        elevation: 3,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                }),
                              ))
                            ])
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> calculateRemainingTime(
    endingTimeString, countdownStreamController, documentID) async {
  try {
    // Check if the stream is already closed
    if (countdownStreamController.isClosed) {
      return;
    }
    if (countdownStreamController.hasListener) {
      return;
    }

    List<String> dateTimeParts = endingTimeString.split('T');
    List<String> dateParts = dateTimeParts[0].split('.');
    List<String> timeParts = dateTimeParts[1].split(':');
    int year = int.parse(dateParts[2]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[0]);
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    int second = int.parse(timeParts[2]);
    DateTime endingTime = DateTime(year, month, day, hour, minute, second);
    Duration remainingTime = endingTime.difference(DateTime.now());

    // Add a listener only if the stream is not closed
    if (!countdownStreamController.hasListener) {
      final Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
        num secondsRemaining = remainingTime.inSeconds;

        // Check if the stream is closed before adding an event
        if (!countdownStreamController.isClosed) {
          // If the countdown is finished, close the stream
          if (secondsRemaining <= 0.0) {
            countdownStreamController.close();
            timer.cancel();
            endAuction(documentID);
          } else {
            // Update the UI with the remaining time
            if (!countdownStreamController.hasListener) {
              countdownStreamController.add(secondsRemaining);
              remainingTime = remainingTime - Duration(seconds: 1);
            }
          }
        } else {
          // Stream is closed, cancel the timer
          timer.cancel();
        }
      });
    }
  } catch (e) {
    // Handle errors
    print('Error eeeeeeeee: $e');
  }
}

Future<void> endAuction(documentID) async {
  try {
    String apiUrl =
        'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/endAuction';
    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'documentID': documentID,
      },
    );

    if (response.statusCode == 200) {
      print('Auction is finished');
    } else {
      print('Error response: ${response.statusCode}');
      throw Exception('Failed to get card data');
    }
  } catch (e) {
    print('Error loading profile: $e');
    throw Exception('Failed to get card data');
  }
}
