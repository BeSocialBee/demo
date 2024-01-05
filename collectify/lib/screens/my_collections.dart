import 'package:collectify/screens/card_details.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:line_icons/line_icon.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:collectify/utils/sharedpref_util.dart';

class MyCollection extends StatefulWidget {
  @override
  State<MyCollection> createState() => _MyCollectionState();
}

class _MyCollectionState extends State<MyCollection> {
  late Future<List<dynamic>> userCards;

  late Future<Map<String, dynamic>> user;

  @override
  void initState() {
    super.initState();
    userCards = getUserCards();
    user = getUser();
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();

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
  Future<List<dynamic>> getUserCards() async {
    try {
      var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
      String apiUrl =
          'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/userCollections';
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
        final List<dynamic> jsonArray = jsonResponse['cardsData'] ?? [];
        return jsonArray;
      } else {
        // Request failed, handle the error
        print('Error response: ${response.statusCode}');
        throw Exception('Failed to fetch cards fixedd.');
      }
    } catch (e) {
      // Handle errors, such as invalid credentials
      print('Errorloading profile: $e');
      throw Exception('Failed to fetch cards fixedd. Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'My Cards',
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
        body: FutureBuilder<List<dynamic>>(
          future: userCards,
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
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 0.8),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var card = snapshot.data![index];
                    return CardWidget(
                      cardPrice: card['cardPrice'].toDouble(),
                      cardUrl: card['cardURL'],
                      cardId: card['uniquecardId'],
                      cardTitle: card['cardTitle'],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  final String? cardUrl;
  final double? cardPrice;
  final String? cardId;
  final String? cardTitle;

  CardWidget({
    required this.cardPrice,
    required this.cardUrl,
    required this.cardTitle,
    required this.cardId, // Pass cardId in the constructor
    super.key,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var result = Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CardDetails(
                      cardId: widget.cardId!,
                    ))); // Constructer içine gerekli inputları yaz

        if (result == true) {
          // Reload the page or perform some action
          setState(() {
            print(""); // Perform the reload or other action
          });
        }
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
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        '${widget.cardUrl}',
                        width: double.infinity,
                        height: 270,
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
                                      '${widget.cardTitle}',
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
                  ]),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FFButtonWidget(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CardDetails(
                                          cardId: widget.cardId!,
                                        )));
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
