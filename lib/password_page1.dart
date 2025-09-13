import 'package:flutter/material.dart';

import 'login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:password_reset_page(),

    );
  }
}
class password_reset_page extends StatefulWidget {
  const password_reset_page({super.key});

  @override
  State<password_reset_page> createState() => _password_reset_pageState();
}

class _password_reset_pageState extends State<password_reset_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9FAF6),
      body:
      SafeArea(child:
      Center(
        child:
        Padding(padding: EdgeInsets.all(13),
          child:
          Column(
            children: [
              SizedBox(height:20,),
              Container(
                height: 250,
                width: double.infinity,
              ),
              SizedBox(height:13,),
              Align(
                  alignment: Alignment.center,
                  child:
                  Text("Reset Password",style:TextStyle(fontSize:18,color: Colors.black,fontWeight:FontWeight.bold),)
              ),
              SizedBox(height:20,),
              TextFormField(
                style:const TextStyle(color: Colors.black),
                controller: email2,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFFA3BFBF),
                  hintText:'Enter your Email',
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
                    return loginpage();
                  }));
                },style:ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
