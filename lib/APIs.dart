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
        Uri.parse('${API_URL}/api/user/signin'),
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
      print(e);
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Vérifier votre internet!!",
        ),
      );
    }
  }
}