import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashdetection/Notification_page.dart';
import 'package:trashdetection/issue_report.dart';
import 'package:trashdetection/login.dart';
import 'package:trashdetection/password_page2.dart';
import 'package:trashdetection/user_review.dart';
import 'package:trashdetection/user_view_review.dart';
import 'package:trashdetection/view_profile_page.dart';

import 'Home_page.dart';
import 'edit_profile.dart';
import 'main.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:account_page() ,
    );
  }
}
class account_page extends StatefulWidget {
  const account_page({super.key});

  @override
  State<account_page> createState() => _account_pageState();
}

class _account_pageState extends State<account_page> {
  _account_pageState(){
    _send_data();
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
          String email = jsonDecode(response.body)['email'].toString();
          String photo = img + jsonDecode(response.body)['photo'].toString();

          setState(() {
            name_ = name;
            email_ = email;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(backgroundColor:Colors.white,elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return notification_page(title: '',);
            }));
          }, icon:Icon(Icons.notifications)),
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return account_page();
            }));
          }, icon:Icon(Icons.account_circle))
        ],leading:  IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Home_Screen();
          }));
        }, icon:Icon(Icons.arrow_back,)),),
        backgroundColor:Colors.white,
        body:
        SingleChildScrollView(
          child: SafeArea(child:
          Padding(padding:EdgeInsets.all(13),
              child:
              Column(
                children: [
                  SizedBox(height:30,),
                  Card(
                    color:Color(0xFF456885),
                    child:
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child:
                      CircleAvatar(radius: 50,
                        backgroundImage: NetworkImage(photo_),),
                    ),
                  ),


                  SizedBox(height:30,),
                  Card(
                    color:Color(0xFF456885),
                    child:
                    Padding(
                        padding: const EdgeInsets.all(13),
                        child:

                        Column(
                          children: [
                            SizedBox(height: 13,),
                            Align(
                                alignment:Alignment.topLeft,
                                child: Text("$name_",style:TextStyle(color:Colors.white),)),

                            Divider(thickness:0.6,color:Colors.white,),

                            Align(
                                alignment:Alignment.topLeft,
                                child: Text("$email_",style:TextStyle(color:Colors.white),)),

                          ],
                        )

                    ),
                  ),
                  SizedBox(
                    height:20,
                  ),
                  Card(
                    color:Color(0xFF456885),
                    child:Padding(
                      padding: EdgeInsets.all(13),
                      child:Column(
                        children: [
                          Container(
                            width:double.infinity,
                            color:
                            Color(0xFF456885),

                            child:
                            Align(
                                alignment:Alignment.topLeft,
                                child: TextButton(onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                    return MyEdit();
                                  }));

                                }, child:Text("Edit Profile Details",style:TextStyle(color:Colors.white,fontSize:14),)))
                            ,
                          ),
                          Divider(
                            thickness:0.5,
                            color:Colors.white,
                          ),
                          Container(
                            width:double.infinity,
                            color:
                            Color(0xFF456885),

                            child:
                            Align(
                                alignment:Alignment.topLeft,
                                child: TextButton(onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                    return ViewProfilePage();
                                  }));

                                }, child:Text("View profile details",style:TextStyle(color:Colors.white,fontSize:14),)))
                            ,
                          ),
                          Divider(
                            thickness:0.5,
                            color:Colors.white,
                          ),
                          Container(
                            width:double.infinity,
                            color:
                            Color(0xFF456885),

                            child:
                            Align(
                                alignment:Alignment.topLeft,
                                child: TextButton(onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                    return ChangePassword();
                                  }));
                                }, child:Text("Change Password",style:TextStyle(color:Colors.white,fontSize:14),)))
                            ,
                          ),
                          Divider(
                            thickness:0.5,
                            color:Colors.white,
                          ),
                          Container(
                            width:double.infinity,
                            color:
                            Color(0xFF456885),

                            child:
                            Align(
                                alignment:Alignment.topLeft,
                                child: TextButton(onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                    return issue_report_page();
                                  }));
                                }, child:Text("Report an issue",style:TextStyle(color:Colors.white,fontSize:14),)))
                            ,
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height:20,
                  ),
                  Card(
                    color:Color(0xFF456885),
                    child:Padding(
                      padding: EdgeInsets.all(13),
                      child:Column(
                        children: [
                          Container(
                            width:double.infinity,
                            color:
                            Color(0xFF456885),

                            child:
                            Align(
                                alignment:Alignment.topLeft,
                                child: TextButton(onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                    return notification_page(title: '',);
                                  }));
                                }, child:Text("Notifications",style:TextStyle(color:Colors.white,fontSize:14),)))
                            ,
                          ),
                          Divider(thickness:0.5,color:Colors.white,),


                          Container(
                            width:double.infinity,
                            color:
                            Color(0xFF456885),

                            child:
                            Align(
                                alignment:Alignment.topLeft,
                                child: TextButton(onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                    return user_view_review(title: '');
                                  }));
                                }, child:Text("Review",style:TextStyle(color:Colors.white,fontSize:14),)))
                            ,
                          ),
                          Divider(thickness:0.5,color:Colors.white,),
                          Container(
                            width:double.infinity,
                            color:
                            Color(0xFF456885),

                            child:
                            Align(
                                alignment:Alignment.topLeft,
                                child: TextButton(onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                    return Report_Screen();
                                  }));
                                }, child:Text("Approved Reports",style:TextStyle(color:Colors.white,fontSize:14),)))
                            ,
                          ),
                          Divider(thickness:0.5,color:Colors.white,),
                          Container(
                            width:double.infinity,
                            color:
                            Color(0xFF456885),

                            child:
                            Align(
                                alignment:Alignment.topLeft,
                                child: TextButton(onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                    return login_page();
                                  }));
                                }, child:Text("Log out",style:TextStyle(color:Colors.white,fontSize:14),)))
                            ,
                          ),

                        ],
                      ),
                    ),
                  ),

                ],
              )
          )
          ),
        )
    );
  }
}
