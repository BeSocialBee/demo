import 'dart:convert';
import 'package:collectify/main.dart';
import 'package:collectify/screens/daily_spin_screen.dart';
import 'package:collectify/screens/card_in_quickBuy.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:fluttermoji/fluttermoji.dart';
import 'package:collectify/utils/sharedpref_util.dart';

class VisitorHome extends StatefulWidget {
  const VisitorHome({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<VisitorHome> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<List<dynamic>> newListings;
  late Future<List<dynamic>> mostVieweds;

  @override
  void initState() {
    super.initState();
    newListings = getNewListings();
    mostVieweds = getMostVieweds();
  }

  Future<List<dynamic>> getNewListings() async {
    try {
      String apiUrl =
          'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/newListings';
      var response = await http.get(
        Uri.parse(apiUrl),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            jsonDecode(response.body); // Decode the response body as a Map
        final List<dynamic> jsonArray = jsonResponse['cardsData'] ??
            []; // Access the "cardsData" key to get the array of cards
        return jsonArray;
      } else {
        throw Exception(
            'Failed to fetch cards.'); // Request failed, handle the error
      }
    } catch (e, stackTrace) {
      print('Failed to fetch cards newwwss. Error: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to fetch cards newwwsslyy. Error: $e');
    }
  }

  Future<List<dynamic>> getMostVieweds() async {
    try {
      String apiUrl =
          'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/mostVieweds';
      var response = await http.get(
        Uri.parse(apiUrl),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            jsonDecode(response.body); // Decode the response body as a Map
        final List<dynamic> jsonArray = jsonResponse['cardsData'] ??
            []; // Access the "cardsData" key to get the array of cards
        return jsonArray;
      } else {
        throw Exception(
            'Failed to fetch cards.'); // Request failed, handle the error
      }
    } catch (e, stackTrace) {
      print('Failed to fetch cards newwwss. Error: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to fetch cards newwwsslyy. Error: $e');
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

    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StickyHeader(
                  overlapHeaders: false,
                  header: Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Color(0x9AFFFFFF)],
                        stops: [0, 1],
                        begin: AlignmentDirectional(0, -1),
                        end: AlignmentDirectional(0, 1),
                      ),
                    ),
                    child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 6, 16, 6),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  // Navigate to the initial screen (replace "/Login" with your actual login/signup route)

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()),
                                      (route) => false);
                                  //Navigator.pushReplacementNamed(context, "/Signup");
                                },
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: Image.asset("images/logo3.png")),
                                /* child: FluttermojiCircleAvatar(
                                backgroundColor: Colors.grey[200],
                                radius: 25,
                              ), */
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Welcome, Visitor",
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF15161E),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            /*  Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 20,
                              buttonSize: 40,
                              icon: Icon(
                                Icons.notifications_none,
                                color: Color(0xFF15161E),
                                size: 24,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ), */
                          ],
                        )),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Text(
                          'New Listings',
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF606A85),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      FutureBuilder(
                          future: newListings,
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
                              // print(snapshot.data!.length);
                              return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                                child: Container(
                                  width: double.infinity,
                                  height: 270,
                                  decoration: BoxDecoration(),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var card = snapshot.data![index];
                                      return NewListingCard(
                                          cardName: card['cardTitle'],
                                          cardPrice:
                                              card['cardPrice'].toDouble(),
                                          documentID: card['documentID'],
                                          cardUrl: card['cardURL']);
                                    },
                                  ),
                                ),
                              );
                            }
                          }),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 16, 0, 12),
                              child: Text(
                                'Most Viewed',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF606A85),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            FutureBuilder(
                                future: mostVieweds,
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 44),
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var card = snapshot.data![index];
                                          return MostViewedCard(
                                              cardName: card['cardTitle'],
                                              cardPrice:
                                                  card['cardPrice'].toDouble(),
                                              cardUrl: card['cardURL'],
                                              viewTimes: card['viewTimes']);
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
        ),
      ),
    );
  }
}

class MostViewedCard extends StatelessWidget {
  final String cardName;
  final String cardUrl;
  final double cardPrice;
  final int viewTimes;
  //final String cardRarity;

  MostViewedCard(
      {super.key,
      //required this.cardRarity,
      required this.cardName,
      required this.cardPrice,
      required this.cardUrl,
      required this.viewTimes});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             QuickBuyScreenWidget(documentID: ,))); // Constructer içine gerekli inputları yaz
      },
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(40, 5, 40, 5),
        child: Container(
          width: 220,
          height: 340,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          '$cardUrl',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(1, -1),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 8, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 5,
                                sigmaY: 2,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Color(0x9AFFFFFF),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Color(0xFFE5E7EB),
                                        width: 2,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 0),
                                      child: Text(
                                        '$viewTimes  times viewed',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF15161E),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //    mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Padding(
                //       padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                //       child: Text(
                //         '$cardName',
                //         style: FlutterFlowTheme.of(context).titleLarge.override(
                //               fontFamily: 'Outfit',
                //               color: Color(0xFF15161E),
                //               fontSize: 22,
                //               fontWeight: FontWeight.w500,
                //             ),
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 8),
                //       child: Text(
                //         '\$ $cardPrice',
                //         style: FlutterFlowTheme.of(context).titleLarge.override(
                //               fontFamily: 'Outfit',
                //               color: Color(0xFF15161E),
                //               fontSize: 22,
                //               fontWeight: FontWeight.w500,
                //             ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewListingCard extends StatelessWidget {
  final String cardName;
  final String cardUrl;
  final double cardPrice;
  final String documentID;

  NewListingCard(
      {super.key,
      required this.documentID,
      required this.cardName,
      required this.cardPrice,
      required this.cardUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuickBuyScreenWidget(
                      documentID: documentID,
                    ))); // Constructer içine gerekli inputları yaz
      },
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(6, 12, 6, 12),
        child: Container(
          width: 220,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xFFE5E7EB),
              width: 2,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          '$cardUrl',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(1, -1),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 8, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 5,
                                sigmaY: 2,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 0, 0),
                                    // child: Container(
                                    //   width: 36,
                                    //   height: 36,
                                    //   decoration: BoxDecoration(
                                    //     color: Color(0x9AFFFFFF),
                                    //     borderRadius: BorderRadius.circular(12),
                                    //     border: Border.all(
                                    //       color: Color(0xFFE5E7EB),
                                    //       width: 2,
                                    //     ),
                                    //   ),
                                    //   alignment: AlignmentDirectional(0, 0),
                                    //   child: Padding(
                                    //     padding: EdgeInsets.all(2),
                                    //     child: Icon(
                                    //       Icons.favorite_border,
                                    //       color: Color(0xFF15161E),
                                    //       size: 20,
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              '$cardName',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF15161E),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 8),
                            child: RichText(
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\$ $cardPrice',
                                    style: TextStyle(
                                      color: Color(0xFF6F61EF),
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF606A85),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  )
                                ],
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF606A85),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: FFButtonWidget(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuickBuyScreenWidget(
                                        documentID: documentID,
                                      )));
                        },
                        text: 'Buy',
                        options: FFButtonOptions(
                          width: 80,
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).tertiary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
