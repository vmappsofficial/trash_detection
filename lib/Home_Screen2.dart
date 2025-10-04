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
      home:Home_page2() ,
    );
  }
}
class Home_page2 extends StatefulWidget {
  const Home_page2({super.key});

  @override
  State<Home_page2> createState() => _Home_page2State();
}

class _Home_page2State extends State<Home_page2> {
  _Home_page2State()
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
      // appBar:AppBar(backgroundColor: Color(0xFF3C3C6C),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),actions: [
      //   IconButton(onPressed: (){
      //     Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
      //       return notification_page();
      //     }));
      //   }, icon:Icon(Icons.notifications,color: Colors.white,)),

      // ],),
      backgroundColor:Colors.white,
      body:
      SafeArea(child:
      SingleChildScrollView(
        child:
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF3C3C6C),
                  Color(0xFF7070A5),

                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child:
                    IconButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                        return account_page();
                      }));
                    }, icon:Icon(Icons.account_circle,color: Colors.white,))

                    ,
                  ),
                  Transform.translate(
                    offset: Offset(31,0),
                    child: Column(
                      children: [
                        Text("OCEAN TRASH DETECTION & CONSERVATION",style: TextStyle(fontSize:19,fontWeight: FontWeight.bold,color: Colors.white),),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Upload an image to detect underwater trash",style: TextStyle(fontSize:13,color: Colors.white),)),
                      ],
                    ),
                  )

                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0,-19),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white
                  ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder:(ctx){
                      return Upload_page();
                    }));

                  }, child:Text("Detect New Trash")),
            ),

            Align(
              alignment:Alignment.center,
              child:
              Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  children: [
                    Text("Detect Trash Save",style:TextStyle(color:Colors.black,fontSize:18,fontWeight:FontWeight.bold,),),
                    Text("Oceans",style:TextStyle(color:Colors.black,fontSize:18,fontWeight:FontWeight.bold),),
                    SizedBox(height:13,),
                    Text("Upload or capture underwater images ",style:TextStyle(color:Colors.black),),
                    Text(" to identify pollutions",style:TextStyle(color:Colors.black),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(13),
              child: Align(alignment: Alignment.topLeft,
              child: Text("Recent Scans",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(padding: EdgeInsets.all(13),
              child:
              ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: filteredUsers.length,
                  itemBuilder: (context,index){
                    final user = filteredUsers[index];
                    return Card(
                      child:
                      Padding(
                        padding: const EdgeInsets.all(13),
                        child: ListTile(
                          leading: Image.network(user['uploaded_file'],),
                          title:Text("Trash detection reports",style: TextStyle(fontSize:13),),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Date : ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),

                                  Text(user['date'].toString(),style: TextStyle(fontSize: 13),),

                                ],
                              ),
                              TextButton(onPressed: () async{
                                SharedPreferences sh= await SharedPreferences.getInstance();
                                sh.setString("id", user['id'].toString());
                                sh.setString("uploaded_file", user['uploaded_file'].toString());
                                sh.setString("date", user['date'].toString());
                                Navigator.of(context).push(MaterialPageRoute(builder:(ctx){
                                  return report_screen(title: '${user['id']}',);
                                }));
                              }, child:Text("View reports",style: TextStyle(color: Colors.lightBlue),))

                            ],
                          ),

                        ),
                      ),
                    );

                  })
              ,
            ),




          ],
        ),
      )
      ),
    );
  }
}
