import 'dart:io';

import 'package:ecole_kolea_app/Auth/AuthContext.dart';
import 'package:ecole_kolea_app/Auth/UseAuthContext.dart';
import 'package:ecole_kolea_app/Constant.dart';
import 'package:ecole_kolea_app/Pages/ConnectedHomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
class APIs {
  static const API_URL = Constant.URL;
  // login
  static Future<void> signIn(BuildContext context,
      UserNameController,
      PasswordController) async {
    try{
      if(UserNameController.text.isEmpty ||
          PasswordController.text.isEmpty ){
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.info(
            message: "Tous les champs doivent être remplis",
          ),
        );
        return;
      }
      final data = {
        'UserName': UserNameController.text,
        'Password': PasswordController.text,
      };

      final response = await http.post(
        Uri.parse('${API_URL}/api/auth/signin'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful POST request
        var responseData = json.decode(response.body);
        //save responseData to local storage
        Map<String, dynamic> user = responseData;
        final AuthContext authContext = useAuthContext(context);
        authContext.login(user);
        // redirect to vente page
        final AuthContext auth = context.read<AuthContext>();
        final Map<String, dynamic>? userData = auth.state.user;
        if (userData != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ConnectedHomePage()),
          );
        }
      } else {
        // Handle the error in case of an unsuccessful request
        var responseMessage = json.decode(response.body)['message'];
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: responseMessage,
          ),
        );
      }
    }catch(e){
      print('Error during signin: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Vérifier votre internet!!",
        ),
      );
    }
  }
  static Future uploadMyFile(BuildContext context, File? file)async {
    try {
      final AuthContext authContext = context.read<AuthContext>();
      final Map<String, dynamic>? userData = authContext.state.user;
      String token = userData?['token'].toString() ?? "";

      var request = http.MultipartRequest('POST', Uri.parse('$API_URL/api/user/uploadFile'));
      request.headers['Authorization'] = 'Bearer $token';

      // Append fields to the request
      if (file != null) {
        if (file.existsSync()) {
          request.files.add(await http.MultipartFile.fromPath('file', file.path));
        } else {
          throw Exception('file does not exist: ${file.path}');
        }
      }
      // Send the request
      var response = await request.send();
      var httpresponse = await http.Response.fromStream(response);
      final data = json.decode(httpresponse.body);
      if (response.statusCode == 200) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: 'image uploaded successfully',
          ),
        );

        return data['path'].toString();
      } else {
        // Handle the error in case of an unsuccessful request
        var responseBody = await response.stream.bytesToString();
        var responseMessage = json.decode(responseBody)['message'];
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: responseMessage,
          ),
        );
      }
      return '';
    } catch (e) {
      print('Error during uploading: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
  }
  static Future CreateNewRoom(BuildContext context,
      FiliereController,
      SectionController,
      GroupeController,
      enseignantID) async {
    try{
      /*if(FiliereController.text.isEmpty ||
          SectionController.text.isEmpty ||
          GroupeController.text.isEmpty ||
          enseignantID.isEmpty){
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.info(
            message: "Tous les champs doivent être remplis",
          ),
        );
        return [];
      }*/
      final AuthContext authContext = context.read<AuthContext>();
      final Map<String, dynamic>? userData = authContext.state.user;
      final data = {
        'Filiere': '1',
        'Section': '1',
        'Groupe': '1',
        'enseignantID': '1'
      };

      final response = await http.post(
        Uri.parse('${API_URL}/api/messagerie/create'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userData?['token'].toString() ?? ''}',
        },
      );

      if (response.statusCode == 200) {
        // Successful POST request
        var responseData = json.decode(response.body);
        return responseData;
      } else {
        // Handle the error in case of an unsuccessful request
        var responseMessage = json.decode(response.body)['message'];
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: responseMessage,
          ),
        );
        return [];
      }
    }catch(e){
      print('Error during creating new room: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Vérifier votre internet!!",
        ),
      );
    }
  }
}