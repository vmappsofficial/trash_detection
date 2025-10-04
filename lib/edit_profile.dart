

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart ';

import 'package:permission_handler/permission_handler.dart';
import 'package:trashdetection/main.dart';
import 'package:trashdetection/view_profile_page.dart';


void main() {
  runApp(const MyEdit());
}

class MyEdit extends StatelessWidget {
  const MyEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyEditPage(title: 'Edit Profile'),
    );
  }
}

class MyEditPage extends StatefulWidget {
  const MyEditPage({super.key, required this.title});

  final String title;

  @override
  State<MyEditPage> createState() => _MyEditPageState();
}

class _MyEditPageState extends State<MyEditPage> {

  _MyEditPageState()
  {
    _get_data();
  }

  String gender = "Male"; TextEditingController nameController= new TextEditingController();
  TextEditingController dobController= new TextEditingController();
  TextEditingController emailController= new TextEditingController();
  TextEditingController phoneController= new TextEditingController();
  TextEditingController placeController= new TextEditingController();
  TextEditingController pinController= new TextEditingController();
  TextEditingController stateController= new TextEditingController();
  TextEditingController cityController = new TextEditingController();


  void _get_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img = sh.getString('img_url').toString();


    final urls = Uri.parse('$url/view_profile/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid

      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String name = jsonDecode(response.body)['name'].toString();
          String dob = jsonDecode(response.body)['dob'].toString();
          String gender = jsonDecode(response.body)['gender'].toString();
          String email = jsonDecode(response.body)['email'].toString();
          String phone = jsonDecode(response.body)['phone'].toString();
          String place = jsonDecode(response.body)['place'].toString();
          String city = jsonDecode(response.body)['city'].toString();
          String state = jsonDecode(response.body)['state'].toString();
          String pin = jsonDecode(response.body)['pin'].toString();
          String photo = img + jsonDecode(response.body)['photo'].toString();


          nameController.text=name;
          dobController.text=dob;
          emailController.text=email;
          phoneController.text=phone;
          placeController.text=place;
          stateController.text=state;
          pinController.text=pin;
          cityController.text = city;

        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {




    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('Edit Profile',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black,fontSize: 19),),leading: BackButton()),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              if (_selectedImage != null) ...{
                InkWell(
                  child:
                  Image.file(_selectedImage!, height: 400,),
                  radius: 399,
                  onTap: _checkPermissionAndChooseImage,
                  // borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              } else ...{
                // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                InkWell(
                  onTap: _checkPermissionAndChooseImage,
                  child:Column(
                    children: [
                      Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
                      Text('Select Image',style: TextStyle(color: Colors.cyan))
                    ],
                  ),
                ),
              },

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Name")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: dobController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("DoB")),
                ),
              ),
              RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";}); },title: Text("Male"),),
              RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";}); },title: Text("Female"),),
              RadioListTile(value: "Other", groupValue: gender, onChanged: (value) { setState(() {gender="Other";}); },title: Text("Other"),),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Email")),
                ),
              ),   Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Phone")),
                ),
              ),   Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: placeController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Place")),
                ),
              ),   Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: stateController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("State")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: pinController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Pin")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: cityController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("City")),
                ),
              ),


              ElevatedButton(
                onPressed: () {
                  _send_data();

                },
                child: Text("Confirm Edit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _send_data() async{

    String uname=nameController.text;
    String dob=dobController.text;
    String email=emailController.text;
    String phone=phoneController.text;
    String place=placeController.text;
    String city = cityController.text;
    String pin=pinController.text;
    String state=stateController.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/edit_profile/');
    try {

      final response = await http.post(urls, body: {
        "photo":photo,
        'name1':uname,
        'city1':city,
        'dob1':dob,
        'state1':state,
        'gender1':gender,
        'email1':email,
        'phone_number1':phone,
        'place1':place,
        'pincode1':pin,
        'lid':lid,

      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          Fluttertoast.showToast(msg: 'Updated Successfully');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ViewProfilePage(),));
        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  File? _selectedImage;
  String? _encodedImage;
  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String photo = '';

}
