import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Login_page(),

    );
  }
}
final _email1 = TextEditingController();
final _password1 = TextEditingController();
final _name = TextEditingController();
final _password2 = TextEditingController();
final phone_number = TextEditingController();
final dob = TextEditingController();
final place = TextEditingController();
final city = TextEditingController();
final state = TextEditingController();
final pin_code = TextEditingController();

final formkey = GlobalKey<FormState>();


class Login_page extends StatefulWidget{
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFE9FAF6),
      body:Center(
        child:
        Form(
          key: formkey,
          child: Column(
            children: [
          Container(
          height: MediaQuery.of(context).size.height*0.35,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image:AssetImage('Water_image1.jpg'),
                fit: BoxFit.cover
            )
          ),
          ),
              SizedBox(height:30,),
              SingleChildScrollView(
                child: Padding(padding:EdgeInsets.symmetric(horizontal:24,vertical:60),
                  child: Column(
                    children: [
                      TextFormField(
                        controller:_email1,
                        style:const TextStyle(color:Color(0xFF004949)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:const Color(0xFFA3BFBF),
                          hintText:'Email',
                          hintStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none
                          )
                        ),
                      ),
                      SizedBox(height:20,),
                      TextFormField(
                        obscureText:true,
                        controller: _password1,
                        style:const TextStyle(color:Color(0xFF004949)),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor:const Color(0xFFA3BFBF),
                            hintText:'Password',
                            hintStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none
                            )
                        ),
                      ),
                      SizedBox(height:13,),
                      Align(
                        alignment:Alignment.centerLeft,
                        child:
                        TextButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                            return Screen1();
                          }));
                        }, child:Text("Forgot Passsword?",style:TextStyle(color: Colors.lightBlueAccent),)),
                      ),
                      SizedBox(height: 13,),
                      SizedBox(
                        width:double.infinity,
                        child: ElevatedButton(onPressed: (){
                          if(_email1.text=="user1" && _password1.text=="Password123"){
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                              return Home_Screen1();
                            }));

                          }
                        },style:ElevatedButton.styleFrom(
                          backgroundColor:Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          )
                        ),child:Text('Log in',style:TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold),)),
                      ),
                      SizedBox(height:13,),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child:
                        TextButton(onPressed: (){

                        }, child:Text("Don't you have an account? Register",style:TextStyle(color: Colors.lightBlueAccent,fontSize:14,decoration: TextDecoration.underline),))
                        ,
                      )

                    ],
                  ),


                ),
              )
            ],
          ),
        )
        ,
      ),
    );
  }
}
class Screen1 extends StatefulWidget{
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context){
    return Scaffold(

      backgroundColor: const Color(0xFFE9FAF6),
      body:
          SafeArea(child:
      Center(
        child:
        Padding(padding: EdgeInsets.all(13),
        child:
          Column(
            children: [
              SizedBox(height:20,),
              Container(
                height: 250,
                width: double.infinity,
              ),
              SizedBox(height:13,),
              Align(
                alignment: Alignment.center,
                child:
               Text("Reset Password",style:TextStyle(fontSize:18,color: Colors.black,fontWeight:FontWeight.bold),)
              ),
              SizedBox(height:20,),
              TextFormField(
                style:const TextStyle(color: Colors.black),
                controller: _email1,
                decoration: InputDecoration(
                    filled: true,
                    fillColor:const Color(0xFFA3BFBF),
                    hintText:'Enter your Email',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    ),


                ),
              ),
              SizedBox(height:30,),
              SizedBox(
                width:double.infinity,
                child: ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:(ctx){
                    return Login_page();
                  }));
                },style:ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),child:Text('Submit',style:TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold),)),
              ),

            ],
          ),),
      )
          )
      ,
    );
  }
}
//
// class Register extends StatefulWidget{
//   const Register({super.key});
//
//   @override
//   State<Register> createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       backgroundColor: const Color(0xFFE9FAF6),
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
//                   height: 30,
//                   width: double.infinity,
//                 ),
//                 SizedBox(height:13,),
//                 Align(
//                     alignment: Alignment.center,
//                     child:
//                     Text("Register",style:TextStyle(fontSize:18,color: Colors.black,fontWeight:FontWeight.bold),)
//                 ),
//                 SizedBox(height:20,),
//                 TextFormField(
//                   controller:_name,
//                   style:const TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor:const Color(0xFFA3BFBF),
//                     hintText:'Enter your name',
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
//                 SizedBox(height:13,),
//                 TextFormField(
//                   controller:_email1,
//
//                   style:const TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//
//                     filled: true,
//                     fillColor:const Color(0xFFA3BFBF),
//                     hintText:'Enter your Email',
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
//                   controller:phone_number,
//                   style:const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor:const Color(0xFFA3BFBF),
//                     hintText:'Enter your phone number',
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
//                 TextFormField(
//                   controller:dob,
//                   style:const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor:const Color(0xFFA3BFBF),
//                     hintText:'Enter your DOB',
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
//                 TextFormField(
//                   controller:place,
//                   style:const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor:const Color(0xFFA3BFBF),
//                     hintText:'Enter your Place',
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
//                 TextFormField(
//                   controller:city,
//                   style:const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor:const Color(0xFFA3BFBF),
//                     hintText:'Enter your City',
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
//                 TextFormField(
//                   controller:state,
//                   style:const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor:const Color(0xFFA3BFBF),
//                     hintText:'Enter your State',
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
//                 TextFormField(
//                   controller:pin_code,
//                   style:const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor:const Color(0xFFA3BFBF),
//                     hintText:'Enter your pin code',
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
//
//                 TextFormField(
//                   controller:_password1,
//                   obscureText: true,
//                   style:const TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor:const Color(0xFFA3BFBF),
//                     hintText:'Enter Password',
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
//                   controller:_password2,
//                   obscureText: true,
//                   style:const TextStyle(color: Colors.white),
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
//
//                 SizedBox(
//                   width:double.infinity,
//                   child: ElevatedButton(onPressed: (){
//                     Navigator.of(context).push(MaterialPageRoute(builder:(ctx){
//                       return Login_page();
//                     }));
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
//
//
//     );
//   }
// }
var n2=0;
final List<Widget> _pages = [
  Screen2(),
  UploadScreen(),
  Report_Screen(),

];
class Home_Screen1 extends StatefulWidget{
  const Home_Screen1({super.key});

  @override
  State<Home_Screen1> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen1> {

  @override
  Widget build(BuildContext context){
    return Scaffold(

      backgroundColor: const Color(0xFFE9FAF6),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Color(0xFFE9FAF6),
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
class Screen2 extends StatelessWidget{
  const Screen2({super.key});
  @override
  Widget build(BuildContext context){
    return 
      Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Notification_Screen();
          }));
        }, icon:Icon(Icons.notifications)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
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
                    return UploadScreen();
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
              Align(
                  alignment:Alignment.topLeft,
                  child: Image.asset("plastic_image1.jpg",height:160)),

              Align(
                  alignment:Alignment.topLeft,
                  child:
                      TextButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                          return Report_Screen();
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
class Report_Screen extends StatelessWidget{
  const Report_Screen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Notification_Screen();
          }));
        }, icon:Icon(Icons.notifications)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
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

class Account_Screen extends StatelessWidget{
  const Account_Screen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return Notification_Screen();
            }));
          }, icon:Icon(Icons.notifications)),
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return Account_Screen();
            }));
          }, icon:Icon(Icons.account_circle))
        ],leading:  IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Home_Screen1();
          }));
        }, icon:Icon(Icons.arrow_back,)),),
      backgroundColor: const Color(0xFFE9FAF6),
      body:
        SingleChildScrollView(
          child: SafeArea(child:
              Padding(padding:EdgeInsets.all(13),
          child:
          Column(
            children: [
              SizedBox(height:30,),
              Card(
                color:Color(0xFF456885),
                child:
                Padding(
                  padding: const EdgeInsets.all(13),
                  child:
                  Icon(Icons.account_circle,color:Colors.white,size:60,),
                ),
              ),


              SizedBox(height:30,),
              Card(
                color:Color(0xFF456885),
                child:
                Padding(
                  padding: const EdgeInsets.all(13),
                  child:

                      Column(
                        children: [
                          SizedBox(height: 13,),
                          Align(
                              alignment:Alignment.topLeft,
                              child: Text("Name",style:TextStyle(color:Colors.white),)),

                          Divider(thickness:0.6,color:Colors.white,),

                          Align(
                              alignment:Alignment.topLeft,
                              child: Text("Email",style:TextStyle(color:Colors.white),)),

                        ],
                      )

                ),
              ),
              SizedBox(
                height:20,
              ),
              Card(
                color:Color(0xFF456885),
                child:Padding(
                  padding: EdgeInsets.all(13),
                  child:Column(
                    children: [
                     Container(
                       width:double.infinity,
                       color:
                       Color(0xFF456885),
          
                       child:
                       Align(
                           alignment:Alignment.topLeft,
                           child: TextButton(onPressed: (){
                             Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                               return profile_screen2();
                             }));

                           }, child:Text("Edit Profile Details",style:TextStyle(color:Colors.white,fontSize:14),)))
                       ,
                     ),
                      Divider(
                        thickness:0.5,
                        color:Colors.white,
                      ),
                      Container(
                        width:double.infinity,
                        color:
                        Color(0xFF456885),
          
                        child:
                        Align(
                            alignment:Alignment.topLeft,
                            child: TextButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                return Password_Screen2();
                              }));
                            }, child:Text("Change Password",style:TextStyle(color:Colors.white,fontSize:14),)))
                        ,
                      ),
                      Divider(
                        thickness:0.5,
                        color:Colors.white,
                      ),
                      Container(
                        width:double.infinity,
                        color:
                        Color(0xFF456885),
          
                        child:
                        Align(
                            alignment:Alignment.topLeft,
                            child: TextButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                return Screen3();
                              }));
                            }, child:Text("Report an issue",style:TextStyle(color:Colors.white,fontSize:14),)))
                        ,
                      ),
          
                    ],
                  ),
                ),
              ),
              SizedBox(
                height:20,
              ),
              Card(
                color:Color(0xFF456885),
                child:Padding(
                  padding: EdgeInsets.all(13),
                  child:Column(
                    children: [
                      Container(
                        width:double.infinity,
                        color:
                        Color(0xFF456885),

                        child:
                        Align(
                            alignment:Alignment.topLeft,
                            child: TextButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                return Notification_Screen();
                              }));
                            }, child:Text("Notifications",style:TextStyle(color:Colors.white,fontSize:14),)))
                        ,
                      ),
                      Divider(thickness:0.5,color:Colors.white,),


                      Container(
                        width:double.infinity,
                        color:
                        Color(0xFF456885),

                        child:
                        Align(
                            alignment:Alignment.topLeft,
                            child: TextButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                return report_screen2();
                              }));
                            }, child:Text("Pending Reports",style:TextStyle(color:Colors.white,fontSize:14),)))
                        ,
                      ),
                      Divider(thickness:0.5,color:Colors.white,),
                      Container(
                        width:double.infinity,
                        color:
                        Color(0xFF456885),

                        child:
                        Align(
                            alignment:Alignment.topLeft,
                            child: TextButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                return Report_Screen();
                              }));
                            }, child:Text("Approved Reports",style:TextStyle(color:Colors.white,fontSize:14),)))
                        ,
                      ),
                      Divider(thickness:0.5,color:Colors.white,),
                      Container(
                        width:double.infinity,
                        color:
                        Color(0xFF456885),

                        child:
                        Align(
                            alignment:Alignment.topLeft,
                            child: TextButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                return Login_page();
                              }));
                            }, child:Text("Log out",style:TextStyle(color:Colors.white,fontSize:14),)))
                        ,
                      ),

                    ],
                  ),
                ),
              ),
          
            ],
          )
          )
          ),
        )
    );
  }
}
class UploadScreen extends StatefulWidget{
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _image;
  final picker = ImagePicker();


  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Notification_Screen();
          }));
        }, icon:Icon(Icons.notifications)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle))
      ],leading:  IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return Home_Screen1();
        }));
      }, icon:Icon(Icons.arrow_back,)),),
      backgroundColor:Color(0xFFE9FAF6) ,
      body:
      SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Align(
                alignment:Alignment.topLeft,
                child: Text("Name",style:TextStyle(fontSize:16,color:Colors.black),)),
            SizedBox(height:13,),
            TextFormField(
              style:const TextStyle(color: Colors.black),
              controller: _name,

              decoration: InputDecoration(

                hintText:'Enter your Name',
                hintStyle: const TextStyle(color: Colors.grey),

                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),


                ),



              ),
            ),

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
                  Text("JPEG/PNG",style:TextStyle(color:Colors.grey,),),
                  SizedBox(height:12,),
                  ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        backgroundColor:Color(0xFFEFF4FA),
                        foregroundColor:Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(12),


                        ),

                      ),
                      onPressed:_pickImage, child:Text("upload"))




                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width:double.infinity,
              child: ElevatedButton(onPressed: (){

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
class Notification_Screen extends StatelessWidget{
  const Notification_Screen({super.key});
  @override
  Widget build(BuildContext context){

    return Scaffold(
        appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return Notification_Screen();
            }));
          }, icon:Icon(Icons.notifications)),
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return Account_Screen();
            }));
          }, icon:Icon(Icons.account_circle))
        ],leading:  IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Home_Screen1();
          }));
        }, icon:Icon(Icons.arrow_back,)),),
      backgroundColor: Color(0xFFE9FAF6)

    );
  }
}
class Password_Screen2 extends StatelessWidget{
  const Password_Screen2({super.key});
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Notification_Screen();
          }));
        }, icon:Icon(Icons.notifications)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle))
      ],leading:  IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return Home_Screen1();
        }));
      }, icon:Icon(Icons.arrow_back,)),),
      backgroundColor: Color(0xFFE9FAF6),
      body:SafeArea(child:
      Center(
        child:
        Padding(padding: EdgeInsets.all(13),
          child:
          Column(
            children: [
              SizedBox(height:20,),
              Container(
                height: 210,
                width: double.infinity,
              ),

              SizedBox(height:20,),
              TextFormField(
                style:const TextStyle(color: Colors.black),
                controller: _password1,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFFA3BFBF),
                  hintText:'Enter Your Current Password',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),



                ),
              ),

              SizedBox(height:30,),
              TextFormField(
                style:const TextStyle(color: Colors.black),
                controller:_password2,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFFA3BFBF),
                  hintText:'Enter your New Password',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),



                ),
              ),
              SizedBox(height:20,),
              TextField(
                style:const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFFA3BFBF),
                  hintText:'Re Enter Password',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),



                ),
              ),
              SizedBox(height:30,),
              SizedBox(
                width:double.infinity,
                child: ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:(ctx){
                    return Login_page();
                  }));
                },style:ElevatedButton.styleFrom(
                    backgroundColor:Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),child:Text('Submit',style:TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold),)),
              ),

            ],
          ),),
      )
      )
        ,
    );
  }
}
class profile_screen2 extends StatefulWidget{
  const profile_screen2({super.key});

  @override
  State<profile_screen2> createState() => _profile_screen2State();
}

class _profile_screen2State extends State<profile_screen2> {
  File? _image;
  final picker = ImagePicker();


  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Notification_Screen();
          }));
        }, icon:Icon(Icons.notifications)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle))
      ],leading:  IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return Home_Screen1();
        }));
      }, icon:Icon(Icons.arrow_back,)),),
      backgroundColor: Color(0xFFE9FAF6),
      body:
      SafeArea(child:
      Column(
        children: [
          SizedBox(height:60,),
          Card(
            color:Color(0xFF456885),
            child:Padding(
              padding: EdgeInsets.all(13),
              child:Column(
                children: [

                  IconButton(onPressed:_pickImage, icon:Icon(Icons.camera_enhance_rounded,size:85,color:Colors.white,)),
                  Divider(
                    thickness:0.5,
                    color:Colors.white,
                  ),
                  Container(
                    width:double.infinity,
                    color:
                    Color(0xFF456885),

                    child:
                    Align(
                        alignment:Alignment.center,
                        child: TextButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                            return Screen4();
                          }));

                        }, child:Text("Change User Name",style:TextStyle(color:Colors.white,fontSize:14),)))
                    ,
                  ),
                  Divider(
                    thickness:0.5,
                    color:Colors.white,
                  ),
                  Container(
                    width:double.infinity,
                    color:
                    Color(0xFF456885),

                    child:
                    Align(
                        alignment:Alignment.center,
                        child: TextButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                            return Screen5();
                          }));
                        }, child:Text("Change Email",style:TextStyle(color:Colors.white,fontSize:14),)))
                    ,
                  ),


                ],
              ),
            ),
          ),
          SizedBox(
            height:20,
          ),
        ],
      )),
    );
  }
}
class report_screen2 extends StatelessWidget{
  const report_screen2({super.key});
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Notification_Screen();
          }));
        }, icon:Icon(Icons.notifications)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle))
      ],leading:  IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return Home_Screen1();
        }));
      }, icon:Icon(Icons.arrow_back,)),),
      backgroundColor:  Color(0xFFE9FAF6),
    );
  }
}
final _location=TextEditingController();

class Screen3 extends StatefulWidget{
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  File? _image;
  final picker = ImagePicker();


  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Notification_Screen();
          }));
        }, icon:Icon(Icons.notifications)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle))
      ],leading:  IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return Home_Screen1();
        }));
      }, icon:Icon(Icons.arrow_back,)),),
      backgroundColor:  Color(0xFFE9FAF6),
      body:SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Align(
                alignment:Alignment.topLeft,
                child: Text("Name",style:TextStyle(fontSize:16,color:Colors.black),)),
            SizedBox(height:13,),
            TextFormField(
              style:const TextStyle(color: Colors.black),
              controller: _name,

              decoration: InputDecoration(

                hintText:'Enter your Name',
                hintStyle: const TextStyle(color: Colors.grey),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),


                ),



              ),
            ),

            SizedBox(height:30,),
            Align(
              alignment:Alignment.topLeft,
              child: Text(" Location"),
            ),
            SizedBox(height:13,),
            TextFormField(
              style:const TextStyle(color: Colors.black),
              controller:_location,

              decoration: InputDecoration(

                hintText:'Enter Place',
                hintStyle: const TextStyle(color: Colors.grey),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),


                ),



              ),
            ),
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
                  Text("JPEG/PNG",style:TextStyle(color:Colors.grey,),),
                  SizedBox(height:12,),
                  ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        backgroundColor:Color(0xFFEFF4FA),
                        foregroundColor:Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(12),


                        ),

                      ),
                      onPressed:_pickImage, child:Text("upload"))




                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width:double.infinity,
              child: ElevatedButton(onPressed: (){

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
      ),
    );
  }
}


class Screen4 extends StatelessWidget{
  const Screen4({super.key});
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Notification_Screen();
          }));
        }, icon:Icon(Icons.notifications)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle))
      ],leading:  IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return Home_Screen1();
        }));
      }, icon:Icon(Icons.arrow_back,)),),
      backgroundColor:  Color(0xFFE9FAF6),
      body:
      SafeArea(child:
      Center(
        child:
        Padding(padding: EdgeInsets.all(13),
          child:
          Column(
            children: [
              SizedBox(height:20,),
              Container(
                height: 210,
                width: double.infinity,
              ),
              SizedBox(height:13,),

              SizedBox(height:20,),
              TextFormField(
                style:const TextStyle(color: Colors.black),
                controller:_name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFFA3BFBF),
                  hintText:'New User name',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),



                ),
              ),

              SizedBox(height:30,),
              TextFormField(
                style:const TextStyle(color: Colors.white),
                controller:_password1,
                obscureText:true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFFA3BFBF),
                  hintText:'Enter Password',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),



                ),
              ),

              SizedBox(height:30,),
              SizedBox(
                width:double.infinity,
                child: ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:(ctx){
                    return Login_page();
                  }));
                },style:ElevatedButton.styleFrom(
                    backgroundColor:Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),child:Text('Submit',style:TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold),)),
              ),

            ],
          ),),
      )
      )
        ,
    );
  }
}

class Screen5 extends StatelessWidget{
  const Screen5({super.key});
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFFE9FAF6),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),actions: [
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Notification_Screen();
          }));
        }, icon:Icon(Icons.notifications)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle))
      ],leading:  IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return Home_Screen1();
        }));
      }, icon:Icon(Icons.arrow_back,)),),
      backgroundColor:  Color(0xFFE9FAF6),
      body:
      SafeArea(child:
      Center(
        child:
        Padding(padding: EdgeInsets.all(13),
          child:
          Column(
            children: [
              SizedBox(height:20,),
              Container(
                height: 210,
                width: double.infinity,
              ),

              SizedBox(height:20,),
              TextFormField(
                style:const TextStyle(color: Colors.black),
                controller:_email1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFFA3BFBF),
                  hintText:'Enter your New Email',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),



                ),
              ),

              SizedBox(height:30,),
              TextFormField(
                style:const TextStyle(color: Colors.black),
                controller:_password1,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFFA3BFBF),
                  hintText:'Enter Password',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),



                ),
              ),

              SizedBox(height:30,),
              SizedBox(
                width:double.infinity,
                child: ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:(ctx){
                    return Account_Screen();
                  }));
                },style:ElevatedButton.styleFrom(
                    backgroundColor:Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),child:Text('Submit',style:TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold),)),
              ),

            ],
          ),),
      )
      )
      ,
    );
  }
}











