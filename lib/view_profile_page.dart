import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashdetection/edit_profile.dart';
import 'package:trashdetection/main.dart';

import 'Account_page.dart';
import 'Home_page.dart';
import 'Notification_page.dart';
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
      backgroundColor: Colors.white,
      appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('View profile',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black,fontSize: 19),),leading: BackButton()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 90,
              color: Color(0xFFE9FAF6),
            ),
            Transform.translate(
              offset: Offset(0,-54),
              child: Align(
                alignment: Alignment.center,
                child: CircleAvatar(radius: 70,
                backgroundImage: NetworkImage(photo_),),
              ),
            ),

            Transform.translate(
              offset: Offset(0,-30),
              child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text("$name_",style: TextStyle(fontSize:19,fontWeight: FontWeight.bold),),
                      Text("$email_",style: TextStyle(fontSize:16,),),
                      Padding(
                        padding: const EdgeInsets.all(27),
                        child: Transform.translate(
                          offset: Offset(0,-13),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:Colors.lightBlue,
                                  foregroundColor: Colors.white,

                                ),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => EditProfilePage(),));
                                }, child:Text("Edit profile")),
                          ),
                        ),
                      )
                    ],
                  )),
            ),

            Align(
              alignment: Alignment.center,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Phone Number : ",style: TextStyle(fontSize:16),),
                          Text("$phone_",style: TextStyle(fontSize:16,color: Colors.grey),)
                        ],
                      ),
                      SizedBox(height: 13,),
                      Row(
                        children: [
                          Text("Gender : ",style: TextStyle(fontSize:16),),
                          Text("$gender_",style: TextStyle(fontSize:16,color: Colors.grey),)
                        ],
                      ),
                      SizedBox(height: 13,),
                      Row(
                        children: [
                          Text("DOB : ",style: TextStyle(fontSize:16),),
                          Text("$dob_",style: TextStyle(fontSize:16,color: Colors.grey),)
                        ],
                      ),
                      SizedBox(height: 13,),
                      Row(
                        children: [
                          Text("State : ",style: TextStyle(fontSize:16),),
                          Text("$state_",style: TextStyle(fontSize:16,color: Colors.grey),)
                        ],
                      )

                    ],
                  ),
                )
                ,
              ),
            ),
            SizedBox(height: 13,),
            Align(
              alignment: Alignment.center,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Place : ",style: TextStyle(fontSize:16),),
                          Text("$place_",style: TextStyle(fontSize:16,color: Colors.grey),)
                        ],
                      ),
                      SizedBox(height: 13,),
                      Row(
                        children: [
                          Text("Pincode : ",style: TextStyle(fontSize:16),),
                          Text("$pin_",style: TextStyle(fontSize:16,color: Colors.grey),)
                        ],
                      ),
                      SizedBox(height: 13,),
                      Row(
                        children: [
                          Text("City : ",style: TextStyle(fontSize:16),),
                          Text("$city_",style: TextStyle(fontSize:16,color: Colors.grey),)
                        ],
                      ),

                    ],
                  ),
                )
                ,
              ),
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
          String name = jsonDecode(response.body)['name'].toString();
          String dob = jsonDecode(response.body)['dob'].toString();
          String gender = jsonDecode(response.body)['gender'].toString();
          String email = jsonDecode(response.body)['email'].toString();
          String phone = jsonDecode(response.body)['phone'].toString();
          String place = jsonDecode(response.body)['place'].toString();
          String city = jsonDecode(response.body)['city'].toString();

          String state = jsonDecode(response.body)['state'].toString();
          String pin = jsonDecode(response.body)['pin'].toString();
          String photo = img + jsonDecode(response.body)['photo'].toString();

          setState(() {
            name_ = name;
            dob_ = dob;
            gender_ = gender;
            email_ = email;
            phone_ = phone;
            place_ = place;
            state_ = state;
            city_=city;
            pin_ = pin;
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