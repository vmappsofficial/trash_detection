import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashdetection/Account_page.dart';
import 'package:trashdetection/Notification_page.dart';
import 'package:trashdetection/ip_page.dart';
import 'Home_page.dart';

void main() {

runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Upload_page(),

    );
  }
}
class Upload_page extends StatefulWidget {
  const Upload_page({super.key});

  @override
  State<Upload_page> createState() => _Upload_pageState();
}

class _Upload_pageState extends State<Upload_page> {

  File ? _selectedImage;

  // String photo_= '';

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


    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    String id = sh.getString('lid').toString();

    if (url == null) {
      Fluttertoast.showToast(msg: "Server URL not found.");
      return;
    }

    final uri = Uri.parse('$url/upload_image/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = id;




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
      backgroundColor:Color(0xFFE9FAF6) ,
      body:
      SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            SizedBox(height:13,),

            SizedBox(height:30,),
            Align(
                alignment:Alignment.topLeft,
                child: Text("Upload Image",style:TextStyle(fontSize:16,color:Colors.black),)),
            SizedBox(height: 30),
            Container(
              width:double.infinity,
              padding:EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(12),
                  border:Border.all(
                      color:Color(0xFFA3BFBF),
                      style:BorderStyle.solid
                  )
              ),
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                      alignment:Alignment.center,
                      child: Text("Upload Image",style:TextStyle(fontSize:18,color:Colors.black,fontWeight:FontWeight.bold),)),
                  SizedBox(height:4,),
                  _selectedImage != null
                      ? Image.file(_selectedImage!, height: 150)
                      : const Text("No Image Selected"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _chooseImage,
                    child: const Text("Choose Image"),
                  ),

                  Text("JPEG/PNG",style:TextStyle(color:Colors.grey,),),
                  SizedBox(height:12,),
                  // ElevatedButton(
                  //     style:ElevatedButton.styleFrom(
                  //       backgroundColor:Color(0xFFEFF4FA),
                  //       foregroundColor:Colors.black,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius:BorderRadius.circular(12),
                  //
                  //
                  //       ),
                  //
                  //     ),
                  //     onPressed:(){
                  //
                  //     }, child:Text("upload"))




                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width:double.infinity,
              child: ElevatedButton(onPressed: (){
                _sendData();
              },style:ElevatedButton.styleFrom(
                  backgroundColor:Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  )
              ),child:Text('Submit',style:TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold),)),
            ),
            SizedBox(height:13,)



          ],
        ),
      )
      )
      ,


    );
  }
}
