import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashdetection/user_review.dart';
// Ensure this matches your file name


class notification_page extends StatefulWidget {
  const notification_page({super.key, required this.title});
  final String title;

  @override
  State<notification_page> createState() => _notification_pageState();
}

class _notification_pageState extends State<notification_page> with TickerProviderStateMixin {
  List<Map<String, dynamic>> notifications = [];
  bool _isLoading = true;
  String _errorMessage = '';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    // Fetch reviews
    fetchReviews();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> fetchReviews() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';


      if (urls.isEmpty ) {
        setState(() {
          _errorMessage = 'Missing server URL ';
          _isLoading = false;
        });
        return;
      }

      String apiUrl = '$urls/user_view_notifications/';
      var response = await http.post(
        Uri.parse(apiUrl),

        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      if (response.statusCode != 200) {
        setState(() {
          _errorMessage = 'Server error: ${response.statusCode}';
          _isLoading = false;
        });
        return;
      }

      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'Notification': item['notification'].toString(),
            'date': item['date'] ?? 'Unknown date',
          });
        }
        setState(() {
          notifications = tempList;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = jsonData['message'] ?? 'Failed to load reviews';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching reviews: $e';
        _isLoading = false;
      });
      print("Error fetching reviews: $e");
    }
  }

  Widget _buildStarRating(String rating) {
    int ratingValue;
    try {
      ratingValue = int.parse(rating);
      if (ratingValue < 0 || ratingValue > 5) ratingValue = 0;
    } catch (e) {
      ratingValue = 0; // Default to 0 if rating is invalid
    }
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < ratingValue ? Icons.star : Icons.star_border,
          color: Colors.amber.shade700,
          size: 20,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
        shadowColor: Colors.black12,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      )
          : _errorMessage.isNotEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage,
              style: TextStyle(
                color: Colors.red.shade600,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetchReviews,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      )
          : notifications.isEmpty
          ? Center(
        child: Text(
          'No Notification found.',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 16,
          ),
        ),
      )
          : FadeTransition(
        opacity: _fadeAnimation,
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          physics: const BouncingScrollPhysics(),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - _fadeAnimation.value)),
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Notification: ${notification['Notification']}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const SizedBox(height: 8),

                            const SizedBox(height: 4),
                            Text(
                              "Date: ${notification['date']}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}