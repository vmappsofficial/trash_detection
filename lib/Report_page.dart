import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import 'package:trashdetection/Account_page.dart';
import 'package:trashdetection/Notification_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF0277BD), // Deep ocean blue
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.montserratTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0288D1),
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      home: const report_screen(),
    );
  }
}

class report_screen extends StatefulWidget {
  final String title;

  const report_screen({super.key, this.title = 'Report Screen'});

  @override
  State<report_screen> createState() => _report_screenState();
}

class _report_screenState extends State<report_screen> with TickerProviderStateMixin {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> filteredUsers = [];
  String path = "";
  String date1 = "";
  bool isLoading = true;
  late AnimationController _bubbleController;
  late Animation<double> _bubbleAnimation;
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    viewUsers("");

    // Bubble animation for underwater effect
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _bubbleAnimation = CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.easeInOutSine,
    );

    // Wave animation for card entrance
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
    _waveAnimation = CurvedAnimation(
      parent: _waveController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  Future<void> viewUsers(String searchValue) async {
    setState(() {
      isLoading = true;
    });
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String img = sh.getString('img_url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String id = sh.getString('id') ?? '';
      String apiUrl = '$urls/view_detections/';

      String uploadedFile = sh.getString("uploaded_file") ?? '';
      String date = sh.getString("date") ?? '';

      setState(() {
        path = uploadedFile;
        date1 = date;
      });

      var response = await http.post(Uri.parse(apiUrl), body: {'id': id});
      var jsonData = json.decode(response.body);

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
          isLoading = false;
          _waveController.forward(from: 0);
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to load detections. Please try again.',
              style: GoogleFonts.montserrat(color: Colors.white),
            ),
            backgroundColor: const Color(0xFFD32F2F),
          ),
        );
      }
    } catch (e) {
      print("Error fetching users: $e");
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'An error occurred. Please check your connection.',
            style: GoogleFonts.montserrat(color: Colors.white),
          ),
          backgroundColor: const Color(0xFFD32F2F),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
        title: Text(
          "AQUA AI",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const notification_page(title: '',)),
              );
            },
            icon: const Icon(Icons.notifications, color:Colors.black),
            tooltip: 'Notifications',
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const account_page()),
              );
            },
            icon: const Icon(Icons.account_circle, color:Colors.black),
            tooltip: 'Account',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Subtle bubble background animation
          AnimatedBuilder(
            animation: _bubbleAnimation,
            builder: (context, child) {
              return Positioned(
                top: 80 * _bubbleAnimation.value,
                left: 30,
                child: Opacity(
                  opacity: 0.3 - (_bubbleAnimation.value * 0.2),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF4FC3F7),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _bubbleAnimation,
            builder: (context, child) {
              return Positioned(
                top: 200 * _bubbleAnimation.value,
                right: 40,
                child: Opacity(
                  opacity: 0.3 - (_bubbleAnimation.value * 0.2),
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF4FC3F7),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              );
            },
          ),
          isLoading
              ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF0288D1),
            ),
          )
              : RefreshIndicator(
            onRefresh: () => viewUsers(""),
            color: const Color(0xFF0288D1),
            backgroundColor: Colors.white,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: OpenContainer(
                      transitionType: ContainerTransitionType.fade,
                      closedElevation: 4,
                      closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      closedColor: Colors.white,
                      closedBuilder: (context, openContainer) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF0288D1), Color(0xFF4FC3F7)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    path,
                                    height: 300,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      height: 300,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Date: $date1',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      openBuilder: (context, _) => const SizedBox(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Detected Trashes',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF212121),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return AnimatedBuilder(
                        animation: _waveAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, 50 * (1 - _waveAnimation.value)),
                            child: Opacity(
                              opacity: _waveAnimation.value,
                              child: child,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF4FC3F7), Color(0xFF80D8FF)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                title: Text(
                                  'TRASH: ${user['trash']}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewUsers(""),
        backgroundColor: const Color(0xFF0288D1),
        child: const Icon(Icons.refresh, color: Colors.white),
        tooltip: 'Refresh',
      ),
    );
  }
}