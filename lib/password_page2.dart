import 'package:flutter/material.dart';
import 'package:trashdetection/Account_page.dart';

import 'Home_Screen2.dart';
import 'Notification_page.dart';
import 'login.dart';
void main() {
  runApp(const MyApp());
}
final current_password = TextEditingController();
final new_password = TextEditingController();
final new_password2 = TextEditingController();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:change_password(),

    );
  }
}
class change_password extends StatefulWidget {
  const change_password({super.key});

  @override
  State<change_password> createState() => _change_passwordState();
}

class _change_passwordState extends State<change_password> {
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
          return Home_page2();
        }));
      }, icon:Icon(Icons.arrow_back,)),),
      backgroundColor: Color(0xFFE9FAF6),
      body:SafeArea(child:
      Center(
        child:
        Padding(padding: EdgeInsets.all(13),
          child:
          Column(
            children: [
              SizedBox(height:20,),
              Container(
                height: 210,
                width: double.infinity,
              ),

              SizedBox(height:20,),
              TextFormField(
                style:const TextStyle(color: Colors.black),
                controller: current_password,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFFA3BFBF),
                  hintText:'Enter Your Current Password',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),



                ),
              ),

              SizedBox(height:30,),
              TextFormField(
                style:const TextStyle(color: Colors.black),
                controller:new_password,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFFA3BFBF),
                  hintText:'Enter your New Password',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),



                ),
              ),
              SizedBox(height:20,),
              TextFormField(
                controller: new_password2,
                style:const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFFA3BFBF),
                  hintText:'Re Enter Password',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),



                ),
              ),
              SizedBox(height:30,),
              SizedBox(
                width:double.infinity,
                child: ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:(ctx){
                    return login_page();
                  }));
                },style:ElevatedButton.styleFrom(
                    backgroundColor:Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),child:Text('Submit',style:TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold),)),
              ),

            ],
          ),),
      )
      )
      ,
    );
  }
}
