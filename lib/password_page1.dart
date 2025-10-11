// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'Home_page.dart';
// import 'login.dart';
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home:password_reset_page(),
//
//     );
//   }
// }
// class password_reset_page extends StatefulWidget {
//   const password_reset_page({super.key});
//
//   @override
//   State<password_reset_page> createState() => _password_reset_pageState();
// }
//
// class _password_reset_pageState extends State<password_reset_page> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE9FAF6),
//       body:
//       SafeArea(child:
//       Center(
//         child:
//         Padding(padding: EdgeInsets.all(13),
//           child:
//           Column(
//             children: [
//               SizedBox(height:20,),
//               Container(
//                 height: 250,
//                 width: double.infinity,
//               ),
//               SizedBox(height:13,),
//               Align(
//                   alignment: Alignment.center,
//                   child:
//                   Text("Reset Password",style:TextStyle(fontSize:18,color: Colors.black,fontWeight:FontWeight.bold),)
//               ),
//               SizedBox(height:20,),
//               TextFormField(
//                 style:const TextStyle(color: Colors.black),
//                 controller: email2,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor:const Color(0xFFA3BFBF),
//                   hintText:'Enter your Email',
//                   hintStyle: const TextStyle(color: Colors.black),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none
//                   ),
//
//
//                 ),
//               ),
//               SizedBox(height:30,),
//               SizedBox(
//                 width:double.infinity,
//                 child: ElevatedButton(onPressed: (){
//                   Navigator.of(context).push(MaterialPageRoute(builder:(ctx){
//                     return loginpage();
//                   }));
//                   _send_data();
//                 },style:ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30)
//                     )
//                 ),child:Text('Submit',style:TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold),)),
//               ),
//
//             ],
//           ),),
//       )
//       )
//       ,
//     );
//   }
//
//
//
//   void _send_data() async {
//     String email = email2.text;
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     final urls = Uri.parse('$url/user_forgot_password/');
//     try {
//       final response = await http.post(urls, body: {
//         'email': email,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           // String lid = jsonDecode(response.body)['lid'].toString();
//           // sh.setString('lid', lid);
//           // Fluttertoast.showToast(msg:lid);
//
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => login_page()),
//           );
//           Fluttertoast.showToast(msg: "Password Reset email send success");
//           // Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
//           //   return Home_Screen();
//           // }));
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//
//
// }
