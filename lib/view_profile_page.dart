import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
void main(){
  
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:ViewProfilePage() ,
    );
  }
}
class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key});

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  _ViewProfilePageState(){
    _send_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: BackButton( ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('View Profile'),

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[


            CircleAvatar(radius: 50,
            backgroundImage: NetworkImage(photo_),),
            Column(
              children: [
                // Image(image: NetworkImage(photo_), height: 200, width: 200,),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("name:$name_"),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(dob_),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(gender_),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(email_),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(phone_),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(place_),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(state_),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(pin_),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(district_),
                ),

              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) => MyEditPage(title: "Edit Profile"),));
              },
              child: Text("Edit Profile"),
            ),

          ],
        ),
      ),

    );
  }


  String name_ = "";
  String dob_ = "";
  String gender_ = "";
  String email_ = "";
  String phone_ = "";
  String place_ = "";
  String state_="";
  String pin_ = "";
  String district_ = "";
  String photo_ = "";
  String city_ ="";

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img = sh.getString('img_url').toString();

    final urls = Uri.parse('$url/view_profile/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'];
          String dob = jsonDecode(response.body)['dob'];
          String gender = jsonDecode(response.body)['gender'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['phone'];
          String place = jsonDecode(response.body)['place'];

          String state = jsonDecode(response.body)['state'];
          String pin = jsonDecode(response.body)['pin'];
          String district = jsonDecode(response.body)['district'];
          String photo = img + jsonDecode(response.body)['photo'];

          setState(() {
            name_ = name;
            dob_ = dob;
            gender_ = gender;
            email_ = email;
            phone_ = phone;
            place_ = place;
            state_ = state;
            pin_ = pin;
            district_ = district;
            photo_ = photo;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

}