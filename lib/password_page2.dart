// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:trashdetection/Account_page.dart';
//
// import 'Home_Screen2.dart';
// import 'Home_page.dart';
// import 'Notification_page.dart';
// import 'login.dart';
// void main() {
//   runApp(const MyApp());
// }
// final current_password = TextEditingController();
// final new_password = TextEditingController();
// final confirm_password = TextEditingController();
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home:change_password(),
//
//     );
//   }
// }
// class change_password extends StatefulWidget {
//   const change_password({super.key});
//
//   @override
//   State<change_password> createState() => _change_passwordState();
// }
//
// class _change_passwordState extends State<change_password> {
//
//   TextEditingController current_password=new TextEditingController();
//   TextEditingController new_password = new TextEditingController();
//   TextEditingController confirm_password = new TextEditingController();
//
//   void _send_data() async {
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//     final urls = Uri.parse('$url/user_change_password/');
//     try {
//       final response = await http.post(urls, body: {
//         'current_password':current_password.text,
//         'new_password':new_password.text,
//         'confirm_password':confirm_password.text,
//         'lid':lid,
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           String lid = jsonDecode(response.body)['lid'].toString();
//           sh.setString('lid', lid);
//           Fluttertoast.showToast(msg:lid);
//
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(builder: (context) => BankingDashboard()),
//           // );
//           Fluttertoast.showToast(msg: "Loggin success");
//           Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
//             return Home_Screen();
//           }));
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
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//       appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
//         IconButton(onPressed: (){
//           Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
//             return notification_page();
//           }));
//         }, icon:Icon(Icons.notifications)),
//         IconButton(onPressed: (){
//           Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
//             return account_page();
//           }));
//         }, icon:Icon(Icons.account_circle))
//       ],leading:  IconButton(onPressed: (){
//         Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
//           return Home_page2();
//         }));
//       }, icon:Icon(Icons.arrow_back,)),),
//       backgroundColor: Color(0xFFE9FAF6),
//       body:
//       SingleChildScrollView(
//         child: SafeArea(child:
//         Center(
//           child:
//           Padding(padding: EdgeInsets.all(13),
//             child:
//             Column(
//               children: [
//                 SizedBox(height:20,),
//                 Container(
//                   height: 210,
//                   width: double.infinity,
//                 ),
//
//                 SizedBox(height:20,),
//                 TextFormField(
//                   style:const TextStyle(color: Colors.black),
//                   controller: current_password,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor:const Color(0xFFA3BFBF),
//                     hintText:'Enter Your Current Password',
//                     hintStyle: const TextStyle(color: Colors.black),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none
//                     ),
//
//
//
//                   ),
//                 ),
//
//                 SizedBox(height:30,),
//                 TextFormField(
//                   style:const TextStyle(color: Colors.black),
//                   controller:new_password,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor:const Color(0xFFA3BFBF),
//                     hintText:'Enter your New Password',
//                     hintStyle: const TextStyle(color: Colors.black),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none
//                     ),
//
//
//
//                   ),
//                 ),
//                 SizedBox(height:20,),
//                 TextFormField(
//                   controller: confirm_password,
//                   style:const TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor:const Color(0xFFA3BFBF),
//                     hintText:'Re Enter Password',
//                     hintStyle: const TextStyle(color: Colors.black),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none
//                     ),
//
//
//
//                   ),
//                 ),
//                 SizedBox(height:30,),
//                 SizedBox(
//                   width:double.infinity,
//                   child: ElevatedButton(onPressed: (){
//                    _send_data();
//                   },style:ElevatedButton.styleFrom(
//                       backgroundColor:Colors.blue,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30)
//                       )
//                   ),child:Text('Submit',style:TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold),)),
//                 ),
//
//               ],
//             ),),
//         )
//         ),
//       )
//       ,
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Home_Screen2.dart';
import 'Notification_page.dart';
import 'Account_page.dart';
import 'Home_page.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> _sendData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = prefs.getString('url') ?? '';
    String lid = prefs.getString('lid') ?? '';
    final uri = Uri.parse('$url/user_change_password/');

    try {
      final response = await http.post(uri, body: {
        'current_password': currentPasswordController.text.trim(),
        'new_password': newPasswordController.text.trim(),
        'confirm_password': confirmPasswordController.text.trim(),
        'lid': lid,
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        String status = jsonResponse['status'];

        if (status == 'ok') {
          Fluttertoast.showToast(msg: "Password changed successfully");
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => Home_Screen()));
        } else if (status == 'incorrect_current_password') {
          Fluttertoast.showToast(msg: "Incorrect current password");
        } else if (status == 'password_mismatch') {
          Fluttertoast.showToast(msg: "New passwords do not match");
        } else if (status == 'user_not_found') {
          Fluttertoast.showToast(msg: "User not found");
        } else {
          Fluttertoast.showToast(msg: "Something went wrong");
        }
      } else {
        Fluttertoast.showToast(msg: "Network error");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9FAF6),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'AQUA AI',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const notification_page()))),
          IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const account_page()))),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Home_page2())),
        ),
      ),
      backgroundColor: const Color(0xFFE9FAF6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: currentPasswordController,
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: _buildInputDecoration("Enter Your Current Password"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: newPasswordController,
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: _buildInputDecoration("Enter Your New Password"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: _buildInputDecoration("Re-enter New Password"),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sendData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFA3BFBF),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
