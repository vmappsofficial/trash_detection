import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class view_issue extends StatefulWidget {
  const view_issue({super.key, required this.title});
  final String title;

  @override
  State<view_issue> createState() => _view_issueState();
}

class _view_issueState extends State<view_issue> with TickerProviderStateMixin {
  List<Map<String, dynamic>> reviews = [];
  bool _isLoading = true;
  String _errorMessage = '';

  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();

    // Wave-like staggered animation for underwater feel
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _waveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeOutCubic),
    );

    _waveController.forward();
    fetchReviews();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  Future<void> fetchReviews() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String baseUrl = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String imgUrl = sh.getString('img_url') ?? '';

      if (baseUrl.isEmpty || lid.isEmpty || imgUrl.isEmpty) {
        setState(() {
          _errorMessage = 'Configuration missing. Please log in again.';
          _isLoading = false;
        });
        return;
      }

      String apiUrl = '$baseUrl/user_view_issue/';
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {'lid': lid},
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
            'date': item['date'] ?? 'Unknown Date',
            'photo': '$imgUrl${item['photo']}'.trim(),
            'description': item['description'] ?? 'No description',
            'action': item['action'] ?? 'Pending',
          });
        }

        setState(() {
          reviews = tempList;
          _isLoading = false;
          // Restart animation on refresh
          _waveController.reset();
          _waveController.forward();
        });
      } else {
        setState(() {
          _errorMessage = jsonData['message'] ?? 'No issues found.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error. Please check your connection.';
        _isLoading = false;
      });
      debugPrint("Fetch error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A3D62), // Deep ocean blue
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? _buildLoadingState()
          : _errorMessage.isNotEmpty
          ? _buildErrorState()
          : reviews.isEmpty
          ? _buildEmptyState()
          : _buildIssueList(),
    );
  }

  // Loading with subtle underwater bubble effect
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _FloatingBubble(),
          const SizedBox(height: 24),
          Text(
            'Exploring the depths...',
            style: TextStyle(
              color: const Color(0xFF0A3D62),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.waves, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              _errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: fetchReviews,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A3D62),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cleaning_services, size: 80, color: Colors.teal.shade300),
          const SizedBox(height: 16),
          Text(
            'No trash issues reported yet.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'The ocean is clean!',
            style: TextStyle(color: Colors.teal.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        final delay = index * 0.1;

        return AnimatedBuilder(
          animation: _waveAnimation,
          builder: (context, child) {
            final animationValue = (_waveAnimation.value - delay).clamp(0.0, 1.0);
            final floatOffset = (1 - animationValue) * 60;

            return Transform.translate(
              offset: Offset(0, floatOffset),
              child: Opacity(
                opacity: animationValue,
                child: _buildIssueCard(review),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildIssueCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Header
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: const Color(0xFF0A3D62)),
                  const SizedBox(width: 6),
                  Text(
                    review['date'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0A3D62),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Image with shimmer fallback
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  review['photo'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 200,
                      color: Colors.grey.shade200,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                          strokeWidth: 2,
                          color: const Color(0xFF0A3D62),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Description
              _buildInfoRow(Icons.description, 'Description', review['description']),
              const SizedBox(height: 8),

              // Action Status
              _buildInfoRow(
                Icons.handyman,
                'Action Taken',
                review['action'],
                valueColor: review['action'].toLowerCase().contains('cleaned')
                    ? Colors.teal.shade700
                    : Colors.orange.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value,
      {Color? valueColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF0A3D62)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  color: valueColor ?? Colors.grey.shade800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Subtle floating bubble animation for loading
class _FloatingBubble extends StatefulWidget {
  @override
  State<_FloatingBubble> createState() => _FloatingBubbleState();
}

class _FloatingBubbleState extends State<_FloatingBubble>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -20, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0A3D62).withOpacity(0.15),
            ),
            child: Center(
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0A3D62),
                ),
                child: const Icon(Icons.waves, color: Colors.white, size: 18),
              ),
            ),
          ),
        );
      },
    );
  }
}