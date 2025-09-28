import 'package:flutter/material.dart';
import 'package:trashdetection/Notification_page.dart';
import 'package:trashdetection/login.dart';
import 'package:trashdetection/password_page2.dart';
import 'package:trashdetection/view_profile_page.dart';

import 'Home_page.dart';
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
class account_page extends StatelessWidget {
  const account_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return notification_page();
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
        backgroundColor: const Color(0xFFE9FAF6),
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
                      Icon(Icons.account_circle,color:Colors.white,size:60,),
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
                                child: Text("Name",style:TextStyle(color:Colors.white),)),

                            Divider(thickness:0.6,color:Colors.white,),

                            Align(
                                alignment:Alignment.topLeft,
                                child: Text("Email",style:TextStyle(color:Colors.white),)),

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
                                    return profile_screen2();
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
                                    return Screen3();
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
                                    return notification_page();
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
                                    return report_screen2();
                                  }));
                                }, child:Text("Pending Reports",style:TextStyle(color:Colors.white,fontSize:14),)))
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
