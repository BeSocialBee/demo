import 'package:collectify/flutter_flow/flutter_flow_icon_button.dart';
import 'package:collectify/screens/collection_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:collectify/utils/sharedpref_util.dart';

class QuickBuyScreenWidget extends StatefulWidget {
  final String documentID;
  // String cardUrl;
  // String cardName;
  QuickBuyScreenWidget({
    Key? key,
    required this.documentID,
    // required this.cardUrl,
    // required this.cardName,
  }) : super(key: key);

  @override
  _QuickBuyScreenWidgetState createState() => _QuickBuyScreenWidgetState();
}

class _QuickBuyScreenWidgetState extends State<QuickBuyScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static late String documentID;
  late Future<Map<String, dynamic>> fixedCard;

  @override
  void initState() {
    super.initState();
    documentID = widget.documentID;
    updateViewCard(documentID);
    fixedCard = getFixedCardbyID(documentID);
  }

  @override
  void dispose() {
    super.dispose();
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
      backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
      appBar: AppBar(
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF14181B),
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF61ADFE),
        automaticallyImplyLeading: false,
        title: Text(
          'Buy',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: FutureBuilder(
          future: fixedCard,
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
              var card = snapshot.data!;

              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 30,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 532,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).tertiary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Container(
                            width: 100,
                            height: 502,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tertiary,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).tertiary,
                                width: 12,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '${card['cardTitle']}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        fontSize: 36,
                                      ),
                                ),
                                FlipCard(
                                  fill: Fill.fillBack,
                                  direction: FlipDirection.HORIZONTAL,
                                  speed: 400,
                                  front: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            '${card['cardURL']}',
                                            width: double.infinity,
                                            height: 330,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.08, -1.14),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(25),
                                              bottomRight: Radius.circular(25),
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                            ),
                                          ),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Text(
                                              '${card['cardQuantity']}',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        fontSize: 24,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  back: Container(
                                    width: 330,
                                    height: 330,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 0, 0),
                                          child: Text(
                                            'Description: ${card['cardDescription']}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 6, 0),
                                        child: _getRarityIcon(
                                            card['cardRarity'], context),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            6, 0, 0, 0),
                                        child: Text(
                                          '${card['cardRarity']}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Outfit',
                                                fontSize: 24,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CollectionScreen(
                                                      collectionName: card[
                                                          'cardCollectionName'])));
                                    },
                                    child: ListTile(
                                      title: Text(
                                        '${card['cardCollectionName']}',
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              fontFamily: 'Outfit',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBtnText,
                                            ),
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        size: 20,
                                      ),
                                      tileColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      dense: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 78,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).tertiary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(30, 0, 10, 0),
                              child: Text(
                                '${card['cardPrice']}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      fontSize: 32,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: FaIcon(
                                FontAwesomeIcons.coins,
                                color: Color(0xFFEDDA2B),
                                size: 32,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.white,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            width: double.infinity,
                                            height: 200,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 20, 20, 0),
                                                  child: Text(
                                                    'Are you sure you want to buy this card?',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          fontSize: 24,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 15, 0, 0),
                                                  child: Builder(
                                                      builder: (context) {
                                                    return FFButtonWidget(
                                                      onPressed: () async {
                                                        Navigator.pop(context);

                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            if (card[
                                                                    'cardPrice'] <=
                                                                card[
                                                                    'balance']) {
                                                              buyCard(
                                                                  documentID);
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Success'),
                                                                content: Text(
                                                                    'You succesfully bought this card'),
                                                                actions: <Widget>[
                                                                  ElevatedButton(
                                                                    child: Text(
                                                                        'Ok'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            } else {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Failed'),
                                                                content: Text(
                                                                    'Insufficient balance'),
                                                                actions: <Widget>[
                                                                  ElevatedButton(
                                                                    child: Text(
                                                                        'Ok'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            }
                                                          },
                                                        );
                                                      },
                                                      text: 'Confirm',
                                                      options: FFButtonOptions(
                                                        height: 40,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(24, 0,
                                                                    24, 0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                        elevation: 3,
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                text: 'Buy',
                                options: FFButtonOptions(
                                  width: 120,
                                  height: 50,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      14, 0, 14, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: Colors.black,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w300,
                                      ),
                                  elevation: 3,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    ));
  }
}

Future<Map<String, dynamic>> getFixedCardbyID(documentID) async {
  try {
    var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
    String apiUrl =
        'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/getFixedCardbyID';
    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'documentID': documentID,
        'userID': userID,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final Map<String, dynamic> jsonArray = jsonResponse['cardData'] ?? {};
      return jsonArray;
    } else {
      print('Error response: ${response.statusCode}');
      throw Exception('Failed to get card data');
    }
  } catch (e) {
    print('Error loading profile: $e');
    throw Exception('Failed to get card data');
  }
}

Future<void> buyCard(documentID) async {
  try {
    var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
    print(userID);

    print("------------------");
    print(documentID);

    String apiUrl =
        'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/userHandleBuy';
    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'documentID': documentID,
        'userID': userID,
      },
    );

    // Check th*e response status
    if (response.statusCode == 200) {
      print('Success response: ${response.statusCode}');
    } else {
      // Request failed, handle the error
      print('Error response: ${response.statusCode}');
    }
  } catch (e) {
    // Handle sign-in errors, such as invalid credentials
    print('Error signing in: $e');
  }
}

// When card is viewed by user, this card view will increase to use in home page
Future<void> updateViewCard(documentID) async {
  try {
    print(documentID);
    print("burdaaa");

    String apiUrl =
        'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/cardViewed';
    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'documentID': documentID,
      },
    );

    if (response.statusCode == 200) {
      print('Succesfully viewed');
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

Widget _getRarityIcon(String cardRarity, BuildContext context) {
  Color starColor = FlutterFlowTheme.of(context).primaryBtnText;
  double starSize = 24.0;

  print("rarity: " + cardRarity);

  switch (cardRarity) {
    case 'common':
      return Row(
        children: List.generate(
          1,
          (index) => Icon(
            Icons.star,
            color: starColor,
            size: starSize,
          ),
        ),
      );
    case 'uncommon':
      return Row(
        children: List.generate(
          2,
          (index) => Icon(
            Icons.star,
            color: starColor,
            size: starSize,
          ),
        ),
      );
    case 'rare':
      return Row(
        children: List.generate(
          3,
          (index) => Icon(
            Icons.star,
            color: starColor,
            size: starSize,
          ),
        ),
      );
    case 'legendary':
      return Row(
        children: List.generate(
          4,
          (index) => Icon(
            Icons.star,
            color: starColor,
            size: starSize,
          ),
        ),
      );
    default:
      return Container(); // Return an empty container for unknown rarity
  }
}
