import 'dart:io';

import 'package:ecole_kolea_app/Constant.dart';
import 'package:ecole_kolea_app/Pages/ConnectedHomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:intl/date_symbol_data_local.dart';


class APIs {
  static const API_URL = Constant.URL;
  static List<int> extractIds(List<dynamic> data) {
    return data.map<int>((item) => item['id'] as int).toList();
  }

  // login
  static Future<void> signIn(BuildContext context, UserNameController, PasswordController) async {
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
        //add user to SharedPreferences
        final SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("id", user["id"].toString());
        preferences.setString("token", user["token"].toString());
        preferences.setString("type", user["type"].toString());

        if (preferences.getString("id") != null &&
            preferences.getString("type") != null &&
            preferences.getString("token") != null) {
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

  //upload file in chat
  static Future uploadMyFile(BuildContext context, File? file)async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      var request = http.MultipartRequest('POST', Uri.parse('$API_URL/api/IMG/uploadFile'));
      request.headers['Authorization'] = 'Bearer ${preferences.getString("token").toString()}';

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

  //create new chat room
  static Future<Map<String, dynamic>> CreateNewRoom(BuildContext context, FiliereController, SectionController, GroupeController, enseignantID) async {
    try{
      if(FiliereController.isEmpty ||
          SectionController.isEmpty ||
          GroupeController.isEmpty){
        Navigator.of(context).pop();
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.info(
            message: "Tous les champs doivent être remplis",
          ),
        );
        return {};
      }
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      final data = {
        'Filiere': FiliereController,
        'Section': SectionController,
        'Groupe': GroupeController,
        'enseignantID': preferences.getString("id").toString()
      };

      final response = await http.post(
        Uri.parse('${API_URL}/api/messagerie/create'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        // Successful POST request
        var responseData = json.decode(response.body);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        return responseData;
      } else {
        // Handle the error in case of an unsuccessful request
        var responseMessage = json.decode(response.body)['message'];
        Navigator.of(context).pop();
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: responseMessage,
          ),
        );
        return {};
      }
    }catch(e){
      print('Error during creating new room: $e');
      Navigator.of(context).pop();
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Vérifier votre internet!!",
        ),
      );
    }
    return {};
  }

  //get filiere section groupe by id enseignant
  static Future<Map<String, dynamic>> GetF_S_G_ByIDEnseignant(BuildContext context) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      String IDEnseignant = preferences.getString("id").toString();

      final response = await http.get(
        Uri.parse('${API_URL}/api/filiere/All/byEnseignant/${IDEnseignant}'),
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        print('Error receiving Filieres/Sections/Groupes data: ${response.body}');
      }
    } catch (error) {
      print('Error fetching Filieres/Sections/Groupes data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty list in case of an error
    return {};
  }
  //get all students
  static Future<List<dynamic>> GetAllStudents(BuildContext context) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      var StudentsData = <dynamic>[];

      final response = await http.get(
        Uri.parse('${API_URL}/api/etudiant'),
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        StudentsData = data;
        return StudentsData.toList();
      } else {
        print('Error receiving all students data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving all students data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty list in case of an error
    return [];
  }
  //get all users
  static Future<List<dynamic>> GetAllUsers(BuildContext context) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      var UsersData = <dynamic>[];

      final response = await http.get(
        Uri.parse('${API_URL}/api/user/All'),
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        UsersData = data;
        return UsersData.toList();
      } else {
        print('Error receiving users data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving users data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty list in case of an error
    return [];
  }
  //get all students by groupe ids
  static Future<List<dynamic>> GetStudentsByGroup(BuildContext context, List<dynamic> groupes) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      var StudentsData = <dynamic>[];
      List<int> ids = extractIds(groupes);
      final response = await http.get(
        Uri.parse('${API_URL}/api/etudiant/All/ByGroupes/${ids}'),
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        StudentsData = data;
        return StudentsData.toList();
      } else {
        print('Error receiving students data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving students data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty list in case of an error
    return [];
  }
  //get all Teachers by groupe id
  static Future<List<dynamic>> GetTeachersByGroup(BuildContext context, String groupe) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      var TeachersData = <dynamic>[];

      final response = await http.get(
        Uri.parse('${API_URL}/api/enseignant/All/ByGroupeID/${groupe}'),
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        TeachersData = data;
        return TeachersData.toList();
      } else {
        print('Error receiving teachers data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving teachers data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty list in case of an error
    return [];
  }
  //get all classes messagerie by id Enseignant
  static Future<List<dynamic>> GetClasseChatByIDEnseignant(BuildContext context) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      String ID = preferences.getString("id").toString();
      String Type = preferences.getString("type").toString();

      var ClassesData = <dynamic>[];
      final response = await http.get(
        Uri.parse('${API_URL}/api/messagerie/All/Classe/ByIDEnseignant/${ID}/${Type}'),
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ClassesData = data;
        return ClassesData.toList();
      } else {
        print('Error receiving classes chat data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving classes chat data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty list in case of an error
    return [];
  }

  //get specific user by id
  static Future<Map<String, dynamic>> GetUserByID(BuildContext context) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      Map<String, dynamic> userData = {};

      final response = await http.get(
        Uri.parse('${API_URL}/api/user/${preferences.getString("id").toString()}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        userData = data;
        return userData;
      } else {
        print('Error receiving user data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving user data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty map in case of an error
    return {};
  }
  //get specific enseignant by id
  static Future<Map<String, dynamic>> GetenseignantByID(BuildContext context) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      Map<String, dynamic> enseignantData = {};

      final response = await http.get(
        Uri.parse('${API_URL}/api/enseignant/${preferences.getString("id").toString()}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        enseignantData = data;
        return enseignantData;
      } else {
        print('Error receiving enseignant data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving enseignant data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty map in case of an error
    return {};
  }
  //get specific student by id
  static Future<Map<String, dynamic>> GetStudentByID(BuildContext context) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      Map<String, dynamic> studentData = {};

      final response = await http.get(
        Uri.parse('${API_URL}/api/etudiant/${preferences.getString("id").toString()}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        studentData = data;
        return studentData;
      } else {
        print('Error receiving student data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving student data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty map in case of an error
    return {};
  }

  //get all the bibliotheques
  static Future<List<dynamic>> GetAllBibliotheques(BuildContext context) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      List<dynamic> bibliothequesData = [];

      final response = await http.get(
        Uri.parse('${API_URL}/api/bibliotheque/All'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        bibliothequesData = data;
        return bibliothequesData;
      } else {
        print('Error receiving bibliotheque data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving bibliotheque data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty map in case of an error
    return [];
  }
  //get all the categories of a bibliotheque
  static Future<List<dynamic>> GetAllCategoriesByIDBibliotheques(BuildContext context, String id) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      List<dynamic> categoriesData = [];

      final response = await http.get(
        Uri.parse('${API_URL}/api/categorie/All/${id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        categoriesData = data;
        return categoriesData;
      } else {
        print('Error receiving categorie data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving categorie data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty map in case of an error
    return [];
  }
  //get all documents of a categorie
  static Future<List<dynamic>> GetAllDocumentsByIDCategorie(BuildContext context, String id) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      List<dynamic> documentsData = [];

      final response = await http.get(
        Uri.parse('${API_URL}/api/document/All/${id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        documentsData = data;
        return documentsData;
      } else {
        print('Error receiving document data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving document data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty map in case of an error
    return [];
  }

  //get all annonces by student
  static Future<List<dynamic>> GetAllAnnoncesForStudent(BuildContext context) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      List<dynamic> annoncesData = [];

      final response = await http.get(
        Uri.parse('${API_URL}/api/annonce/All/Student/${preferences.getString("id").toString()}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        annoncesData = data;
        return annoncesData;
      } else {
        print('Error receiving student annonce data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving student annonce data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty map in case of an error
    return [];
  }
  //get all annonces by groupe
  static Future<List<dynamic>> GetAllAnnoncesForGroupe(BuildContext context) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      List<dynamic> annoncesData = [];

      final response = await http.get(
        Uri.parse('${API_URL}/api/annonce/All/Groupe/${preferences.getString("id").toString()}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        annoncesData = data;
        return annoncesData;
      } else {
        print('Error receiving groupe annonces data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving groupe annonces data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty map in case of an error
    return [];
  }
  //get all annonces by section
  static Future<List<dynamic>> GetAllAnnoncesForSection(BuildContext context) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      List<dynamic> annoncesData = [];

      final response = await http.get(
        Uri.parse('${API_URL}/api/annonce/All/Section/${preferences.getString("id").toString()}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        annoncesData = data;
        return annoncesData;
      } else {
        print('Error receiving section annonces data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving section annonces data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty map in case of an error
    return [];
  }
  //get all annonces by filiere
  static Future<List<dynamic>> GetAllAnnoncesForFiliere(BuildContext context) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      List<dynamic> annoncesData = [];

      final response = await http.get(
        Uri.parse('${API_URL}/api/annonce/All/Filiere/${preferences.getString("id").toString()}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        annoncesData = data;
        return annoncesData;
      } else {
        print('Error receiving filiere annonces data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving filiere annonces data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty map in case of an error
    return [];
  }

  //Evaluation
  //get all affichage by Etusiant
  static Future<List<dynamic>> GetAllAffichageByIDEtudiant(BuildContext context) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      List<dynamic> affichagesData = [];

      final response = await http.get(
        Uri.parse('${API_URL}/api/evaluation/affichage/${preferences.getString("id").toString()}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        affichagesData = data;
        return affichagesData;
      } else {
        print('Error receiving affichages data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving affichages data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty map in case of an error
    return [];
  }
  //get all NoteModule by Affichage
  static Future<List<dynamic>> GetAllNoteModuleByIDAffichage(BuildContext context, String id) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      List<dynamic> notemoduleData = [];

      final response = await http.get(
        Uri.parse('${API_URL}/api/evaluation/notemodule/${id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        notemoduleData = data;
        return notemoduleData;
      } else {
        print('Error receiving note module data: ${response.body}');
      }
    } catch (error) {
      print('Error receiving note module data: $error');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty map in case of an error
    return [];
  }

  //Presence
  static Future<String> GetCreneau(BuildContext context, String time, String groupe) async {
    try {
      if(time.isEmpty ||
          groupe.isEmpty){
        Navigator.of(context).pop();
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.info(
            message: "Tous les champs doivent être remplis",
          ),
        );
        return '';
      }

      final SharedPreferences preferences = await SharedPreferences.getInstance();

      await initializeDateFormatting('fr_FR', null);
      String dayName = DateFormat('EEEE', 'fr_FR').format(DateTime.now());

      final response = await http.get(
        Uri.parse('${API_URL}/api/creneau/${dayName}/${groupe}/${preferences.getString("id").toString()}/${time}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("token").toString()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        return data.toString();
      } else {
        Navigator.of(context).pop();
        final data = json.decode(response.body);
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: data['message'].toString(),
          ),
        );
      }
    } catch (error) {
      print('Error receiving creneau data: $error');
      Navigator.of(context).pop();
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'vérifier votre internet',
        ),
      );
    }
    // Return an empty map in case of an error
    return '';
  }

}