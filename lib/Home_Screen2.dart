import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import 'Account_page.dart';
import 'Notification_page.dart';
import 'Report_page.dart';
import 'Upload_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF0D47A1),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const Home_page2(),
    );
  }
}

class Home_page2 extends StatefulWidget {
  const Home_page2({super.key});

  @override
  State<Home_page2> createState() => _Home_page2State();
}

class _Home_page2State extends State<Home_page2> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> filteredUsers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    viewUsers("");
  }

  Future<void> viewUsers(String searchValue) async {
    setState(() => isLoading = true);
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String img = sh.getString('img_url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String apiUrl = '$urls/view_upload_file/';

      var response = await http.post(Uri.parse(apiUrl), body: {'lid': lid});
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'],
            'uploaded_file': img + item['uploaded_file'],
            'date': item['date'],
          });
        }
        setState(() {
          users = tempList;
          filteredUsers = tempList;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching users: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Wave effect at the top
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 180,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header Section
                  FadeInDown(
                    duration: const Duration(milliseconds: 800),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "OCEAN TRASH DETECTION",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Protect our oceans with AI-powered scans",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx) => const account_page()),
                              );
                            },
                            icon: const Icon(Icons.account_circle, color: Colors.white, size: 28),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Upload Button
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ScaleTransitionButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => const Upload_page()),
                          );
                        },
                        child: Text(
                          "Detect New Trash",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Intro Text
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Column(
                      children: [
                        Text(
                          "Detect Trash, Save Oceans",
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF212121),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Upload underwater images to identify pollution",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF757575),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Recent Scans
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Recent Scans",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF212121),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // ListView with Shimmer Loading
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: isLoading
                        ? Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.grey[100]!,
                      child: Column(
                        children: List.generate(
                          3,
                              (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return FadeInUp(
                          duration: Duration(milliseconds: 500 + (index * 100)),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: const Color(0xFF26A69A).withOpacity(0.2), width: 1), // Subtle teal border
                            ),
                            color: const Color(0xFFF5F5F5), // Off-white background
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFFF5F5F5), // Off-white
                                    const Color(0xFFE0F7FA).withOpacity(0.5), // Light cyan for underwater effect
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12), // Increased padding
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(13),
                                  child: Image.network(
                                    user['uploaded_file'],
                                    width: 100, // Increased image size
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "Trash Detection Report",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16, // Slightly larger font for title
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF212121),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8), // Added spacing
                                    Row(
                                      children: [
                                        Text(
                                          "Date: ",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF212121),
                                          ),
                                        ),
                                        Text(
                                          user['date'].toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: const Color(0xFF757575),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    TextButton(
                                      onPressed: () async {
                                        SharedPreferences sh = await SharedPreferences.getInstance();
                                        sh.setString("id", user['id'].toString());
                                        sh.setString("uploaded_file", user['uploaded_file'].toString());
                                        sh.setString("date", user['date'].toString());
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => report_screen(title: '${user['id']}'),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "View Report",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF26A69A),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Bubble Animation
          const BubbleAnimation(),
        ],
      ),
    );
  }
}

// Wave Clipper for Header
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 20);
    var secondControlPoint = Offset(3 * size.width / 4, size.height - 50);
    var secondEndPoint = Offset(size.width, size.height - 30);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

// Animated Button with Scale Transition
class ScaleTransitionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const ScaleTransitionButton({super.key, required this.onPressed, required this.child});

  @override
  _ScaleTransitionButtonState createState() => _ScaleTransitionButtonState();
}

class _ScaleTransitionButtonState extends State<ScaleTransitionButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF26A69A),
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

// Bubble Animation Widget
class BubbleAnimation extends StatefulWidget {
  const BubbleAnimation({super.key});

  @override
  _BubbleAnimationState createState() => _BubbleAnimationState();
}

class _BubbleAnimationState extends State<BubbleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(4, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Positioned(
              left: (index * 60 + 30).toDouble(),
              bottom: (_controller.value * 700 + index * 120) % 700,
              child: Container(
                width: 8 + index * 4,
                height: 8 + index * 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF26A69A).withOpacity(0.2),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}