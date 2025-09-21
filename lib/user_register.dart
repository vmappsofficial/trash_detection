import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashdetection/ip_page.dart';

void main(){
  runApp(user_register());
}
class user_register extends StatelessWidget {
  const user_register({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:Register()

    );
  }
}
class Register extends StatefulWidget{
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _email1 = TextEditingController();
  final _password1 = TextEditingController();
  final _name = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _phone_number = TextEditingController();
  final _dob = TextEditingController();
  final _place = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _pin_code = TextEditingController();
  final formkey = GlobalKey<FormState>();
  String gender_ = "Male";
  File ? _selectedImage;

  String photo_= '';

  Future<void> _chooseImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
    else {
      Fluttertoast.showToast(msg: "No image selected");
    }
  }
  Future<void> _sendData() async {
    String uname = _name.text.trim();
    String uemail = _email1.text.trim();
    String uphone = _phone_number.text.trim();
    String dob = _dob.text.trim();
    String place = _place.text.trim();
    String pin_code = _pin_code.text.trim();
    String gender = gender_;
    String city = _city.text.trim();
    String state = _state.text.trim();
    String password = _password1.text;
    String confirm_password = _confirmPassword.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');

    if (url == null) {
      Fluttertoast.showToast(msg: "Server URL not found.");
      return;
    }

    final uri = Uri.parse('$url/user_signup_post/');
    var request = http.MultipartRequest('POST', uri);

    // Required fields - make sure names match Django keys
    request.fields['name1'] = uname;
    request.fields['email1'] = uemail;
    request.fields['phone_number1'] = uphone;
    request.fields['dob1'] = dob;
    request.fields['place1'] = place;
    request.fields['pincode1'] = pin_code;
    request.fields['gender1'] = gender;
    request.fields['city1'] = city;
    request.fields['state1'] = state;
    request.fields['password1'] = password;
    request.fields['_confirmPassword'] = confirm_password;

    // Attach photo only if user selected one
    if (_selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath('photo', _selectedImage!.path));
    }

    try {
      var streamedResponse = await request.send();
      var respStr = await streamedResponse.stream.bytesToString();

      // Debug output (remove in production)
      print('Status code: ${streamedResponse.statusCode}');
      print('Raw response: $respStr');

      // Try to decode JSON safely
      Map<String, dynamic>? data;
      try {
        data = jsonDecode(respStr) as Map<String, dynamic>?;
      } catch (e) {
        // Server returned non-JSON (likely an error page). Show raw message for debugging.
        Fluttertoast.showToast(msg: "Invalid server response. See console.");
        print('JSON decode failed: $e');
        return;
      }

      if (streamedResponse.statusCode == 200 && data != null && data['status'] == 'ok') {
        Fluttertoast.showToast(msg: "Submitted successfully.");
      } else {
        String serverMsg = data != null && data['message'] != null ? data['message'] : 'Submission failed';
        Fluttertoast.showToast(msg: serverMsg);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Request error: $e");
    }
  }


  Future<void> _sendData1() async {
    String uname = _name.text;
    String uemail = _email1.text;
    String uphone = _phone_number.text;
    String dob = _dob.text;
    String place = _place.text;
    String pin_code = _pin_code.text;
    String gender = gender_;
    String city = _city.text;
    String state = _state.text;
    String password = _password1.text;
    String confirm_password = _confirmPassword.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');

    if (url == null) {
      Fluttertoast.showToast(msg: "Server URL not found.");
      return;
    }

    final uri = Uri.parse('$url/user_signup_post/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['name1'] = uname;
    // request.fields['email1'] = uemail;
    // request.fields['phone_number1'] = uphone;
    // request.fields['dob1'] = dob;
    // request.fields['place1'] = place;
    // request.fields['pin_code1'] = pin_code;
    // request.fields['gender1'] = gender;
    // request.fields['city1'] = city;
    // request.fields['state1'] = state;
    // request.fields['password1'] = password;
    // request.fields['_confirmPassword'] = confirm_password;


    if (_selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath('photo', _selectedImage!.path));
    }

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      if (response.statusCode == 200 && data['status'] == 'ok') {
        Fluttertoast.showToast(msg: "Submitted successfully.");
      } else {
        Fluttertoast.showToast(msg: "Submission failed.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9FAF6),
      body:
      SingleChildScrollView(
        child: SafeArea(child:
        Center(
          child:
          Padding(
            padding: EdgeInsets.all(13),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  height: 30,
                  width: double.infinity,
                ),
                SizedBox(height: 13,),
                Align(
                    alignment: Alignment.center,
                    child:
                    Text("Register", style: TextStyle(fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),)
                ),
                SizedBox(height: 20,),

                const Icon(
                    Icons.person_add, size: 80, color: Colors.deepPurple),
                const SizedBox(height: 20),

                _selectedImage != null
                    ? Image.file(_selectedImage!, height: 150)
                    : const Text("No Image Selected"),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _chooseImage,
                  child: const Text("Choose Image"),
                ),



                TextFormField(
                  controller: _name,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA3BFBF),
                    hintText: 'Enter your name',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 13,),

                TextFormField(
                  controller: _email1,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA3BFBF),
                    hintText: 'Enter your Email',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),

                SizedBox(height: 30,),

                TextFormField(
                  controller: _phone_number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA3BFBF),
                    hintText: 'Enter your phone number',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                TextFormField(
                  controller: _dob,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA3BFBF),
                    hintText: 'Enter your DOB',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                Row(

                  children: [
                    Text("Gender:"),
                    Radio(
                        value: 'Male', groupValue: gender_, onChanged: (value) {
                      setState(() {
                        gender_=value!;
                      });
                    }),
                    Text("Male"),
                    Radio(value: 'Female',
                        groupValue: gender_,
                        onChanged: (value) {
                          setState(() {
                            gender_=value!;
                          });
                        }),
                    Text("Female"),
                    Radio(
                        value: 'Other', groupValue: gender_, onChanged: (value) {
                      setState(() {
                        gender_=value!;
                      });
                    }),
                    Text("Other"),

                  ],
                ),

                TextFormField(
                  controller: _place,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA3BFBF),
                    hintText: 'Enter your Place',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                TextFormField(
                  controller: _city,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA3BFBF),
                    hintText: 'Enter your City',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                TextFormField(
                  controller: _state,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA3BFBF),
                    hintText: 'Enter your State',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                TextFormField(
                  controller: _pin_code,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA3BFBF),
                    hintText: 'Enter your pin code',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                TextFormField(
                  controller: _password1,
                  obscureText: true,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA3BFBF),
                    hintText: 'Enter Password',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    ),


                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _confirmPassword,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA3BFBF),
                    hintText: 'Re Enter Password',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    ),


                  ),
                ),
                SizedBox(height: 30,),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {
                    _sendData();

                  }, style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  ), child: Text('Submit', style: TextStyle(color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),),onLongPress:(){







                    // Navigator.of(context).push(MaterialPageRoute(builder:(ctx){
                    //   return Ip_Screen();
                    // }));
                  },),
                ),

              ],
            ),),
        )
        ),
      ),
    );
  }

}
