import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashdetection/Account_page.dart';
import 'package:trashdetection/Notification_page.dart';



import 'Report_page.dart';
import 'Upload_page.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:report_page() ,
    );
  }
}
class report_page extends StatefulWidget {
  const report_page({super.key});

  @override
  State<report_page> createState() => _report_pageState();
}

class _report_pageState extends State<report_page> {
  _report_pageState()
  {
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
      String apiUrl = '$urls/view_upload_file/';

      var response = await http.post(Uri.parse(apiUrl), body: {

        'lid':lid
      });
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'],
            'uploaded_file': img+item['uploaded_file'],
            'date': item['date'],

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
      body: ListView.builder(
        // shrinkWrap: true,
        // physics: BouncingScrollPhysics(),
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
                  Text("date: ${user['date']}"),
                  // Text("file: ${user['uploaded_file']}"),
                  Image.network(user['uploaded_file']),
                  SizedBox(height: 13,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,

                      )
                      ,onPressed: () async {


                    SharedPreferences sh= await SharedPreferences.getInstance();
                    sh.setString("id", user['id'].toString());
                    sh.setString("uploaded_file", user['uploaded_file'].toString());
                    sh.setString("date", user['date'].toString());

                    Navigator.of(context).push(MaterialPageRoute(builder:(ctx){
                      return report_screen(title: '${user['id']}',);
                    }));


                  }, child: Text("View report",style: TextStyle(color: Colors.white,fontSize: 11),))


                ],
              ),
            ),
          );
        },
      ),

    );
  }
}
