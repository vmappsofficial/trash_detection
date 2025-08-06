import 'package:flutter/material.dart';

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
class Login_page extends StatefulWidget{
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFF0C0C0C),
      body:Center(
        child:
        Column(
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
                    TextField(
                      controller:_email1,
                      style:const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:const Color(0xFF1E1E1E),
                        hintText:'Email',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none
                        )
                      ),
                    ),
                    SizedBox(height:20,),
                    TextField(
                      controller: _password1,
                      style:const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor:const Color(0xFF1E1E1E),
                          hintText:'Password',
                          hintStyle: const TextStyle(color: Colors.grey),
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
                            return Home_Screen();
                          }));

                        }
                      },style:ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF29B6F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),child:Text('Log in',style:TextStyle(color: Colors.black,fontSize:18,fontWeight:FontWeight.bold),)),
                    ),
                    SizedBox(height:13,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child:
                      TextButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                          return Register();
                        }));
                      }, child:Text("Don't you have an account? Register",style:TextStyle(color: Colors.lightBlueAccent,fontSize:14,decoration: TextDecoration.underline),))
                      ,
                    )

                  ],
                ),


              ),
            )
          ],
        )
        ,
      ),
    );
  }
}
class Screen1 extends StatelessWidget{
  const Screen1({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(

      backgroundColor: const Color(0xFF0C0C0C),
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
               Text("Reset Password",style:TextStyle(fontSize:18,color: Colors.white,fontWeight:FontWeight.bold),)
              ),
              SizedBox(height:20,),
              TextField(
                style:const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor:const Color(0xFF1E1E1E),
                    hintText:'Enter your Email',
                    hintStyle: const TextStyle(color: Colors.grey),
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
                    backgroundColor: const Color(0xFF29B6F6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),child:Text('Submit',style:TextStyle(color: Colors.black,fontSize:18,fontWeight:FontWeight.bold),)),
              ),

            ],
          ),),
      )
          )
      ,
    );
  }
}
class Register extends StatelessWidget{
  const Register({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFF0C0C0C),
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
              Align(
                  alignment: Alignment.center,
                  child:
                  Text("Register",style:TextStyle(fontSize:18,color: Colors.white,fontWeight:FontWeight.bold),)
              ),
              SizedBox(height:20,),
              TextField(
                style:const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFF1E1E1E),
                  hintText:'Enter your Email',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),



                ),
              ),

              SizedBox(height:30,),
              TextField(
                style:const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFF1E1E1E),
                  hintText:'Enter Password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),



                ),
              ),
              SizedBox(height:20,),
              TextField(
                style:const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:const Color(0xFF1E1E1E),
                  hintText:'Re Enter Password',
                  hintStyle: const TextStyle(color: Colors.grey),
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
                    backgroundColor: const Color(0xFF29B6F6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),child:Text('Submit',style:TextStyle(color: Colors.black,fontSize:18,fontWeight:FontWeight.bold),)),
              ),

            ],
          ),),
      )
      )
      ,


    );
  }
}
var n2=0;
final List<Widget> _pages = [
  Screen2(),
  UploadScreen(),
  Report_Screen(),

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

      backgroundColor: const Color(0xFF0C0C0C),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Color(0xFF0C0C0C),

          unselectedItemColor: Colors.white,
          selectedItemColor:Colors.lightBlueAccent,
          currentIndex: n2,
          onTap: (n1){
            setState(() {
              n2= n1;
            });

          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home,color:Colors.white,),label: "Home",),
            BottomNavigationBarItem(icon: Icon(Icons.add,color:Colors.white),label: "Upload file"),
            BottomNavigationBarItem(icon: Icon(Icons.file_open_outlined,color:Colors.white),label: "Reports"),

          ]),
      body:_pages[n2],
    );
  }
}
class Screen2 extends StatelessWidget{
  const Screen2({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFF0C0C0C),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),actions: [
        IconButton(onPressed: (){}, icon:Icon(Icons.notifications,color:Colors.white,)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle,color:Colors.white,))
      ],leading:  IconButton(onPressed: (){

      }, icon:Icon(Icons.search,color:Colors.white,)),),
      backgroundColor: const Color(0xFF0C0C0C),
      body:
      SafeArea(child:
      Column(
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
                Text("Detect Trash Save",style:TextStyle(color:Colors.white,fontSize:18,fontWeight:FontWeight.bold),),
                Text("Oceans",style:TextStyle(color:Colors.white,fontSize:18,fontWeight:FontWeight.bold),),
                SizedBox(height:13,),
                Text("Upload or capture underwater images ",style:TextStyle(color:Colors.white),),
                Text(" to identify pollutions",style:TextStyle(color:Colors.white),)
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
                backgroundColor: const Color(0xFF29B6F6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                )
            ),child:Text('Upload Image',style:TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold),)),
          ),
          
          
        ],
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
      appBar:AppBar(backgroundColor: Color(0xFF0C0C0C),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),actions: [
        IconButton(onPressed: (){}, icon:Icon(Icons.notifications,color:Colors.white,)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle,color:Colors.white,))
      ],leading:  IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return Home_Screen();
        }));
      }, icon:Icon(Icons.arrow_back,color:Colors.white,)),),
      backgroundColor: const Color(0xFF0C0C0C),);
  }
}
class Account_Screen extends StatelessWidget{
  const Account_Screen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar:AppBar(backgroundColor: Color(0xFF0C0C0C),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),actions: [
          IconButton(onPressed: (){}, icon:Icon(Icons.notifications,color:Colors.white,)),
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return Account_Screen();
            }));
          }, icon:Icon(Icons.account_circle,color:Colors.white,))
        ],leading:  IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Home_Screen();
          }));
        }, icon:Icon(Icons.arrow_back,color:Colors.white,)),),
      backgroundColor: const Color(0xFF0C0C0C),
      body:
        SingleChildScrollView(
          child: SafeArea(child:
              Padding(padding:EdgeInsets.all(13),
          child:
          Column(
            children: [
              SizedBox(height:30,),
              Card(
                color:Color(0xFF343535),
                child:
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: Row(
                    children: [
                      Icon(Icons.account_circle,color:Colors.white,size:60,),
                      SizedBox(width:13,),
                      Column(
                        children: [
                          Text("Name",style:TextStyle(color:Colors.white),),
                          SizedBox(height:13,),
                          Text("Email",style:TextStyle(color:Colors.white),),
          
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height:20,
              ),
              Card(
                color:Color(0xFF343535),
                child:Padding(
                  padding: EdgeInsets.all(13),
                  child:Column(
                    children: [
                     Container(
                       width:double.infinity,
                       color:
                       Color(0xFF343535),
          
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
                        Color(0xFF343535),
          
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
                        Color(0xFF343535),
          
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
                color:Color(0xFF343535),
                child:Padding(
                  padding: EdgeInsets.all(13),
                  child:Column(
                    children: [
                      Container(
                        width:double.infinity,
                        color:
                        Color(0xFF343535),

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
                        Color(0xFF343535),

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
                        Color(0xFF343535),

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
class UploadScreen extends StatelessWidget{
  const UploadScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFF0C0C0C),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),actions: [
        IconButton(onPressed: (){}, icon:Icon(Icons.notifications,color:Colors.white,)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle,color:Colors.white,))
      ],leading:  IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return Home_Screen();
        }));
      }, icon:Icon(Icons.arrow_back,color:Colors.white,)),),
      backgroundColor:Color(0xFF0C0C0C) ,
    );
  }
}
class Notification_Screen extends StatelessWidget{
  const Notification_Screen({super.key});
  @override
  Widget build(BuildContext context){

    return Scaffold(
        appBar:AppBar(backgroundColor: Color(0xFF0C0C0C),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),actions: [
          IconButton(onPressed: (){}, icon:Icon(Icons.notifications,color:Colors.white,)),
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return Account_Screen();
            }));
          }, icon:Icon(Icons.account_circle,color:Colors.white,))
        ],leading:  IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Home_Screen();
          }));
        }, icon:Icon(Icons.arrow_back,color:Colors.white,)),),
      backgroundColor: Color(0xFF0C0C0C)

    );
  }
}
class Password_Screen2 extends StatelessWidget{
  const Password_Screen2({super.key});
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFF0C0C0C),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),actions: [
        IconButton(onPressed: (){}, icon:Icon(Icons.notifications,color:Colors.white,)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle,color:Colors.white,))
      ],leading:  IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return Home_Screen();
        }));
      }, icon:Icon(Icons.arrow_back,color:Colors.white,)),),
    );
  }
}
class profile_screen2 extends StatelessWidget{
  const profile_screen2({super.key});
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFF0C0C0C),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),actions: [
        IconButton(onPressed: (){}, icon:Icon(Icons.notifications,color:Colors.white,)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle,color:Colors.white,))
      ],leading:  IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return Home_Screen();
        }));
      }, icon:Icon(Icons.arrow_back,color:Colors.white,)),),
      backgroundColor: Color(0xFF0C0C0C),
    );
  }
}
class report_screen2 extends StatelessWidget{
  const report_screen2({super.key});
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFF0C0C0C),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),actions: [
        IconButton(onPressed: (){}, icon:Icon(Icons.notifications,color:Colors.white,)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle,color:Colors.white,))
      ],leading:  IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return Home_Screen();
        }));
      }, icon:Icon(Icons.arrow_back,color:Colors.white,)),),
      backgroundColor:  Color(0xFF0C0C0C),
    );
  }
}

class Screen3 extends StatelessWidget{
  const Screen3({super.key});
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFF0C0C0C),elevation: 0,centerTitle: true,title: Text('AQUA AI',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),actions: [
        IconButton(onPressed: (){}, icon:Icon(Icons.notifications,color:Colors.white,)),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return Account_Screen();
          }));
        }, icon:Icon(Icons.account_circle,color:Colors.white,))
      ],leading:  IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return Home_Screen();
        }));
      }, icon:Icon(Icons.arrow_back,color:Colors.white,)),),
      backgroundColor:  Color(0xFF0C0C0C),
    );
  }
}


