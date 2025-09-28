import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashdetection/Account_page.dart';
import 'package:trashdetection/Notification_page.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:report_screen(),
    );
  }
}
class report_screen extends StatefulWidget {
  // const report_screen({super.key});

  final String title;



  const report_screen({super.key,this.title = 'Report Screen'});



  @override
  State<report_screen> createState() => _report_screenState();
}

class _report_screenState extends State<report_screen> {

  _report_screenState(){
    viewUsers("");
  }


  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> filteredUsers = [];
  List<String> nameSuggestions = [];
  Future<void> viewUsers(String searchValue) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String img = sh.getString('img_url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String id = sh.getString('id') ?? '';
      String apiUrl = '$urls/view_detections/';

      String uploaded_file= sh.getString("uploaded_file").toString();
      String date= sh.getString("date").toString();

      setState(() {

        path=uploaded_file;
        Date1 = date;
      });

      var response = await http.post(Uri.parse(apiUrl), body: {

        'id':id
      });
      var jsonData = json.decode(response.body);

      print(id);


      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'],
            'trash': item['trash'],

          });
        }
        setState(() {
          users = tempList;
          filteredUsers = tempList;
          //     .where((user) =>
          //     user['name']
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchValue.toLowerCase()))
          //     .toList();
          // nameSuggestions = users.map((e) => e['name'].toString()).toSet().toList();

        });
      }
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  String path="";
  String Date1="";
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

      }, icon:Icon(Icons.search,)),),
      backgroundColor: const Color(0xFFE9FAF6),
      body:

      Column(
        children: [
          Text(Date1),
      Expanded(
        child: Container(
          height: 200,
          width: 400,
          decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),
              image: DecorationImage(image:
              NetworkImage(path),
                  fit: BoxFit.cover
              )
          ),
        ),
      ),

          Text("Detected trashes",style: TextStyle(fontSize:18),),
          SizedBox(height:13,),

          Expanded(child:



          ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              final user = filteredUsers[index];
              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 5,
                child: ListTile(
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("trash: ${user['trash']}"),
                      // Text("file: ${user['uploaded_file']}"),

                      SizedBox(height: 13,),



                    ],
                  ),
                ),
              );
            },
          ),




          ),
        ],
      ),

    );
  }
}
