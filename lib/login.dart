import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trashdetection/Home_page.dart';
import 'package:trashdetection/password_page1.dart';
import 'package:trashdetection/user_register.dart';
final String userid = '';
void main(){
  runApp(loginpage());
}
final email2 = TextEditingController();
final password = TextEditingController();

class loginpage extends StatelessWidget {
  const loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: login_page(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {

  final formkey=GlobalKey<FormState>();
  TextEditingController email2 = new TextEditingController();
  TextEditingController password = new TextEditingController();

  void _send_data() async {
    String uname = email2.text;
    String upassword =password.text ;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    final urls = Uri.parse('$url/user_login_post/');
    try {
      final response = await http.post(urls, body: {
        'Username': uname,
        'Password': upassword,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String lid = jsonDecode(response.body)['lid'].toString();
          sh.setString('lid', lid);
          Fluttertoast.showToast(msg:lid);

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => BankingDashboard()),
          // );
          Fluttertoast.showToast(msg: "Loggin success");
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Home_Screen();
          }));
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(

      body:
      SingleChildScrollView(
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:AssetImage('Water_image1.jpg'),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                SizedBox(height:30,),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal:24,vertical:60),
                  child: Column(
                    children: [
        
                      TextFormField(
                        style:const TextStyle(color:Color(0xFF004949)),
                        controller:email2,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor:const Color(0xFFA3BFBF),
                            hintText:'Email',
                            hintStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none
                            )
                        ),
                      ),
                      SizedBox(height:20,),
        
                      TextFormField(
                        controller: password,
                        obscureText:true,
                        style:const TextStyle(color:Color(0xFF004949)),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor:const Color(0xFFA3BFBF),
                            hintText:'Password',
                            hintStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none
                            )
                        ),
                      ),
                      SizedBox(height:13,),
        
                      Align(
                        alignment:Alignment.centerLeft,
                        child:
                        TextButton(
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){

                                return password_reset_page();
                              }));
                            },
                            child:Text("Forgot Passsword?",style:TextStyle(color: Colors.lightBlueAccent),)),
                      ),
                      SizedBox(height: 13,),
                      SizedBox(
                        width:double.infinity,
                        child: ElevatedButton(onPressed: () async {
                          _send_data();
                          // setState(() {
                          //   if(email2.text=="user1" && password.text=="Password123"){
                          //     // Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                          //     //   return Home_Screen();
                          //     // }));
                          //
                          //   }
                          // });
        
        
                        },style:ElevatedButton.styleFrom(
                            backgroundColor:Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                        ),child:Text('Log in',style:TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold),)),
                      ),
                      SizedBox(height:13,),
        
                      Align(
                        alignment: Alignment.bottomCenter,
                        child:
                        TextButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                            return Register();
                          }));
                        },
                            child:Text("Don't you have an account? Register",style:TextStyle(color: Colors.lightBlueAccent,fontSize:14,decoration: TextDecoration.underline),))
                        ,
                      )
        
                    ],
                  ),
        
        
                )
              ],
            ),
          )
          ,
        ),
      ),
    );
  }
}
