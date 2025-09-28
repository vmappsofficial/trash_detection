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
      SafeArea(child:
      SingleChildScrollView(
        child:
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                width:double.infinity,
                height:300,
                decoration:
                BoxDecoration(
                    image:DecorationImage(image:
                    AssetImage('Sea_image3.jpg'),
                    )
                ),
              ),
              Align(
                alignment:Alignment.center,
                child:
                Column(
                  children: [
                    Text("Detect Trash Save",style:TextStyle(color:Colors.black,fontSize:18,fontWeight:FontWeight.bold,),),
                    Text("Oceans",style:TextStyle(color:Colors.black,fontSize:18,fontWeight:FontWeight.bold),),
                    SizedBox(height:13,),
                    Text("Upload or capture underwater images ",style:TextStyle(color:Colors.black),),
                    Text(" to identify pollutions",style:TextStyle(color:Colors.black),)
                  ],
                ),
              ),
              SizedBox(height:13,),
              SizedBox(
                width:double.infinity,
                child: ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:(ctx){
                    return Upload_page();
                  }));
                },style:ElevatedButton.styleFrom(
                    backgroundColor:Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),child:Text('Upload Image',style:TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold),)),
              ),
              SizedBox(height:30,),
              Align(
                alignment:Alignment.topLeft,
                child:
                Text('Recent Scans',style:TextStyle(fontSize:18,color:Colors.black,fontWeight:FontWeight.bold),)
                ,
              ),
              SizedBox(height:13,),

              Container(
                height: 250,
                child: Expanded(child:

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
                            Text("date: ${user['date']}"),
                            // Text("file: ${user['uploaded_file']}"),
                            Image.network(user['uploaded_file'])
                            
                          ],
                        ),
                      ),
                    );
                  },
                ),




                ),
              ),
              // Align(
              //     alignment:Alignment.topLeft,
              //     child: Image.asset("plastic_image1.jpg",height:160)),

              Align(
                alignment:Alignment.topLeft,
                child:
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                    return report_screen();
                  }));
                }, child:Text("View Report")),
              )


            ],
          ),
        ),
      )
      ),
    );
  }
}
