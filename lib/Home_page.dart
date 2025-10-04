import 'package:flutter/material.dart';
import 'package:trashdetection/Home_Screen2.dart';
import 'package:trashdetection/Upload_page.dart';
import 'package:trashdetection/reportoriginal.dart';

import 'Report_page.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:Home_Screen() ,
    );
  }
}
var n2=0;
final List<Widget> _pages = [
  Home_page2(),
  Upload_page(),
  report_page(),

];
class Home_Screen extends StatefulWidget{
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  @override
  Widget build(BuildContext context){
    return Scaffold(

      backgroundColor:Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor:Colors.white,
          selectedItemColor:Colors.lightBlueAccent,
          currentIndex: n2,
          onTap: (n1){
            setState(() {
              n2= n1;
            });

          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home,),label: "Home",),
            BottomNavigationBarItem(icon: Icon(Icons.add,),label: "Upload file"),
            BottomNavigationBarItem(icon: Icon(Icons.file_open_outlined),label: "Reports"),

          ]),
      body:_pages[n2],
    );
  }
}