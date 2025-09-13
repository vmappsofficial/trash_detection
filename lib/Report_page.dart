import 'package:flutter/material.dart';
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
class report_screen extends StatelessWidget {
  const report_screen({super.key});

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
      body: SafeArea(child:
      Container(
          color: Color(0xFF456885),
          height:150,
          width:double.infinity,

          child:
          Padding(
            padding: const EdgeInsets.all(12),
            child:Column(
              children: [
                SizedBox(height:13,),
                SingleChildScrollView(
                  scrollDirection:Axis.horizontal,
                  child: Row(
                    children: [
                      Image.asset("plastic_image1.jpg",width:150,),
                      SizedBox(width:13,),
                      Column(
                        children: [
                          Text("2 Items Founded",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:18),),
                          SizedBox(height:13,),
                          Row(
                            children: [
                              Text("Plastic cover",style:TextStyle(color:Colors.white),),
                              SizedBox(width:13,),
                              Container(
                                color:Colors.lightBlueAccent,
                                width:60,
                                height:9,
                              ),
                              SizedBox(width:5,),
                              Text("90",style:TextStyle(color:Colors.white),),
                            ],
                          ),
                          SizedBox(height:5,),
                          Row(
                            children: [
                              Text("Plastic bottle",style:TextStyle(color:Colors.white),),
                              SizedBox(width:13,),
                              Container(
                                color:Colors.lightBlueAccent,
                                width:60,
                                height:9,
                              ),
                              SizedBox(width:5,),
                              Text("34",style:TextStyle(color:Colors.white),),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
      ),

    );
  }
}
