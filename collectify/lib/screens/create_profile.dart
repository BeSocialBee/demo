import 'dart:math';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:collectify/utils/sharedpref_util.dart';
import 'package:fluttermoji/fluttermoji.dart';


class CreateProfile extends StatefulWidget {
  CreateProfile({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {

  final TextEditingController usernameController = TextEditingController();
  String userName = "";



  // Define the signIn function
  Future<void> signUpcomplete() async {
    try {

      var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
      print("username : "+userName);

      String apiUrl = 'https://nliqxp1fz0.execute-api.us-east-1.amazonaws.com/loginstage/signUpcomplete';
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'userName': userName,
          'userID': userID,
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        print('Success');
        Navigator.pushReplacementNamed(context, "/MainPage");
      } else {
        // Request failed, handle the error
        print('Error response: ${response.statusCode}');
      }
    } catch (e) {
      // Handle sign-in errors, such as invalid credentials
      print('Error signing in: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              FlutterFlowTheme.of(context).tertiary,
              FlutterFlowTheme.of(context).tertiary
            ],
            stops: [0, 1],
            begin: AlignmentDirectional(0.87, -1),
            end: AlignmentDirectional(-0.87, 1),
          ),
          shape: BoxShape.rectangle,
        ),
        alignment: AlignmentDirectional(0, -1),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 10),
                child: Container(
                  width: 220,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                        child: Icon(
                          Icons.flourescent_rounded,
                          color: FlutterFlowTheme.of(context).info,
                          size: 44,
                        ),
                      ),
                      Text(
                        'Collectify',
                        style:
                            FlutterFlowTheme.of(context).displaySmall.override(
                                  fontFamily: 'Outfit',
                                  color: FlutterFlowTheme.of(context).info,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: 570,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Align(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Create your avatar",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          FluttermojiCircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 100,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Spacer(flex: 2),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 35,
                                  child: ElevatedButton.icon(
                                    icon: Icon(Icons.edit),
                                    label: Text("Customize"),
                                    onPressed: () => Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => NewPage())),
                                  ),
                                ),
                              ),
                              Spacer(flex: 2),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                              child: Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: usernameController,
                                  focusNode: FocusNode(),
                                  autofocus: true,
                                  autofillHints: [AutofillHints.password],
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    labelStyle:
                                        FlutterFlowTheme.of(context).labelLarge,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyLarge,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primary,
                                  validator:(value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a value'; // Return an error message if the value is empty
                                    }
                                  },
                                  onSaved: (newValue) {

                                  },  
                                  onChanged: (value){
                                    userName = usernameController.text;
                                  } 
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                              child: FFButtonWidget(
                                onPressed: () async {

                                  await signUpcomplete();
                                  
                                },
                                text: 'Save Changes',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 44,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: Colors.white,
                                      ),
                                  elevation: 3,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
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
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;

  

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: FluttermojiCircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                width: min(600, _width * 0.85),
                child: Row(
                  children: [
                    Text(
                      "Customize:",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Spacer(),
                    FluttermojiSaveWidget(),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                child: FluttermojiCustomizer(
                  scaffoldWidth: min(600, _width * 0.85),
                  autosave: false,
                  theme: FluttermojiThemeData(
                      boxDecoration: BoxDecoration(boxShadow: [BoxShadow()])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
