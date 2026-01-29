import 'dart:convert';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view_profile_page.dart'; // adjust import path if needed


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controllers
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final placeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinController = TextEditingController();

  String gender = "Male";
  File? _selectedImage;
  String? _encodedImage;
  String photo = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      final sh = await SharedPreferences.getInstance();
      final url = sh.getString('url') ?? '';
      final lid = sh.getString('lid') ?? '';
      final baseImgUrl = sh.getString('img_url') ?? '';

      final uri = Uri.parse('$url/view_profile/');
      final response = await http.post(uri, body: {'lid': lid});

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'ok') {
          setState(() {
            nameController.text = jsonData['name']?.toString() ?? '';
            dobController.text = jsonData['dob']?.toString() ?? '';
            emailController.text = jsonData['email']?.toString() ?? '';
            phoneController.text = jsonData['phone']?.toString() ?? '';
            placeController.text = jsonData['place']?.toString() ?? '';
            cityController.text = jsonData['city']?.toString() ?? '';
            stateController.text = jsonData['state']?.toString() ?? '';
            pinController.text = jsonData['pin']?.toString() ?? '';
            gender = jsonData['gender']?.toString() ?? 'Male';
            photo = jsonData['photo']?.toString() ?? ''; // filename only
            // full image url for display
            if (photo.isNotEmpty) {
              photo = '$baseImgUrl$photo';
            }
            isLoading = false;
          });
        } else {
          Fluttertoast.showToast(msg: "Profile not found");
        }
      } else {
        Fluttertoast.showToast(msg: "Network error");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> _pickImage() async {
    final status = await Permission.photos.request();
    if (status.isGranted || status.isLimited) {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);

      if (picked != null) {
        final bytes = await picked.readAsBytes();
        setState(() {
          _selectedImage = File(picked.path);
          _encodedImage = base64Encode(bytes);
          photo = _encodedImage ?? ''; // for sending to server
        });
      }
    } else {
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Permission Required"),
            content: const Text("Please allow access to your photos to upload a profile picture."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("OK"),
              ),
              TextButton(
                onPressed: () => openAppSettings(),
                child: const Text("Settings"),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _saveProfile() async {
    if (nameController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Name is required");
      return;
    }

    setState(() => isLoading = true);

    try {
      final sh = await SharedPreferences.getInstance();
      final url = sh.getString('url') ?? '';
      final lid = sh.getString('lid') ?? '';

      final uri = Uri.parse('$url/edit_profile/');

      final body = {
        'lid': lid,
        'name1': nameController.text.trim(),
        'dob1': dobController.text.trim(),
        'gender1': gender,
        'email1': emailController.text.trim(),
        'phone_number1': phoneController.text.trim(),
        'place1': placeController.text.trim(),
        'city1': cityController.text.trim(),
        'state1': stateController.text.trim(),
        'pincode1': pinController.text.trim(),
      };

      // Only send photo if a new one was selected
      if (_encodedImage != null && _encodedImage!.isNotEmpty) {
        body['photo'] = _encodedImage!;
      }

      final response = await http.post(uri, body: body);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'ok') {
          Fluttertoast.showToast(
            msg: "Profile updated successfully",
            backgroundColor: Colors.green,
          );
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ViewProfilePage()),
            );
          }
        } else {
          Fluttertoast.showToast(msg: "Update failed");
        }
      } else {
        Fluttertoast.showToast(msg: "Server error");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: FadeInUp(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),

                    // Profile Picture
                    GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 68,
                            backgroundColor: const Color(0xFF26A69A).withOpacity(0.15),
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: _selectedImage != null
                                  ? FileImage(_selectedImage!)
                                  : (photo.isNotEmpty
                                  ? NetworkImage(photo)
                                  : null) as ImageProvider?,
                              child: _selectedImage == null && photo.isEmpty
                                  ? const Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.grey,
                              )
                                  : null,
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF26A69A),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Form Fields
                    _buildTextField(nameController, "Full Name", Icons.person_outline),
                    _buildTextField(dobController, "Date of Birth (YYYY-MM-DD)", Icons.calendar_today_outlined),
                    const SizedBox(height: 8),

                    // Gender Selection
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _genderOption("Male"),
                              _genderOption("Female"),
                              _genderOption("Other"),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    _buildTextField(emailController, "Email Address", Icons.email_outlined),
                    _buildTextField(phoneController, "Phone Number", Icons.phone_outlined),
                    _buildTextField(placeController, "Place / House Name", Icons.home_outlined),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(cityController, "City", Icons.location_city)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildTextField(stateController, "State", Icons.map_outlined)),
                      ],
                    ),
                    _buildTextField(pinController, "PIN Code", Icons.pin),

                    const SizedBox(height: 40),

                    // Save Button
                    GestureDetector(
                      onTap: isLoading ? null : _saveProfile,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF26A69A), Color(0xFF1A8A7F)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF26A69A).withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: isLoading
                              ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                              : Text(
                            "Save Changes",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      IconData icon,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF26A69A)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF26A69A), width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),
    );
  }

  Widget _genderOption(String value) {
    final selected = gender == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => gender = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF26A69A) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? Colors.transparent : Colors.grey.shade300,
            ),
          ),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: selected ? Colors.white : Colors.grey[800],
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    phoneController.dispose();
    placeController.dispose();
    cityController.dispose();
    stateController.dispose();
    pinController.dispose();
    super.dispose();
  }
}