import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:Ip_Screen(),
    );
  }
}

class Ip_Screen extends StatefulWidget{
  const Ip_Screen({super.key});

  @override
  State<Ip_Screen> createState() => _Ip_ScreenState();
}

class _Ip_ScreenState extends State<Ip_Screen> {
  TextEditingController ip =TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:SafeArea(child:
      Center(
        child:
        Padding(padding: EdgeInsets.all(12),
        child: Column(
            children: [
              SizedBox(height:60,),
              TextFormField(
                style:const TextStyle(color:Color(0xFF004949)),
                controller:ip,
                decoration: InputDecoration(
                    filled: true,
                    fillColor:const Color(0xFFA3BFBF),
                    hintText:'Enter ip',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    )
                ),
              ),
              SizedBox(height:13,),
              SizedBox(
                width:double.infinity,
                child: ElevatedButton(onPressed: () async {
                  _send_data();
                  // String ipval= ip.text.toString();
                  //
                  //
                  // SharedPreferences sh= await SharedPreferences.getInstance();
                  // sh.setString("ip", ipval);
                  // sh.commit();
                  //
                  //
                  //
                  // Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                  //   return login_page();
                  // }));

                },style:ElevatedButton.styleFrom(
                    backgroundColor:Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),child:Text('Click Here',style:TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold),)),
              ),
            ],
        ),

        ),
      )
      ),
    );
  }

  void _send_data() async{
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString('url', 'http://${ip.text}:8000/myapp');
    sh.setString('img_url', 'http://${ip.text}:8000');
    Navigator.push(context, MaterialPageRoute(
      // builder: (context) => MyLoginPage(title: "Login"),));
      builder: (context) =>login_page(),));

  }
}