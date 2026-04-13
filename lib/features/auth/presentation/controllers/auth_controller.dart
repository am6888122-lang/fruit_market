import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  var isLoading = false.obs;
  var verificationId = ''.obs;
  var phoneNumber = ''.obs;
  
  final phoneController = TextEditingController();
  final otpControllers = List.generate(6, (index) => TextEditingController());

  @override
  void onClose() {
    phoneController.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  // Format phone number to E.164 format
  String _formatPhoneNumber(String phone) {
    String cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
    
    // If starts with +, return as is
    if (cleaned.startsWith('+')) {
      return cleaned;
    }
    
    // If starts with 00, replace with +
    if (cleaned.startsWith('00')) {
      return '+${cleaned.substring(2)}';
    }
    
    // If starts with 0, assume Egypt and add +20
    if (cleaned.startsWith('0')) {
      return '+20${cleaned.substring(1)}';
    }
    
    // If no prefix, assume Egypt
    return '+20$cleaned';
  }

  // Send OTP via Firebase
  Future<void> sendOTP() async {
    if (phoneController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter phone number",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    String formattedPhone = _formatPhoneNumber(phoneController.text.trim());
    phoneNumber.value = formattedPhone;
    isLoading.value = true;

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        timeout: const Duration(seconds: 60),
        
        // Auto-verification (Android only)
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await _auth.signInWithCredential(credential);
            isLoading.value = false;
            
            Get.snackbar(
              "Success",
              "Phone verified automatically",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color(0xFF6FAE3D),
              colorText: Colors.white,
            );
            
            Get.offAllNamed('/home');
          } catch (e) {
            isLoading.value = false;
            Get.snackbar(
              "Error",
              "Auto-verification failed: ${e.toString()}",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        },
        
        // Verification failed
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          String message = 'Verification failed';
          
          switch (e.code) {
            case 'invalid-phone-number':
              message = 'Invalid phone number format';
              break;
            case 'too-many-requests':
              message = 'Too many requests. Please try again later';
              break;
            case 'quota-exceeded':
              message = 'SMS quota exceeded. Please try again later';
              break;
            default:
              message = e.message ?? 'Verification failed';
          }
          
          Get.snackbar(
            "Error",
            message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
          );
        },
        
        // Code sent successfully
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          isLoading.value = false;
          
          Get.snackbar(
            "OTP Sent",
            "Verification code sent to $formattedPhone",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF6FAE3D),
            colorText: Colors.white,
          );
          
          // Navigate to OTP screen
          Get.toNamed('/otp');
        },
        
        // Code auto-retrieval timeout
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Failed to send OTP: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Verify OTP
  Future<void> verifyOTP() async {
    String otp = otpControllers.map((c) => c.text).join();
    
    if (otp.length != 6) {
      Get.snackbar(
        "Error",
        "Please enter complete 6-digit code",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (verificationId.value.isEmpty) {
      Get.snackbar(
        "Error",
        "Verification ID not found. Please resend OTP",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      isLoading.value = false;

      if (userCredential.user != null) {
        Get.snackbar(
          "Success",
          "Login successful",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF6FAE3D),
          colorText: Colors.white,
        );
        
        // Check if new user
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          Get.offAllNamed('/user-info');
        } else {
          Get.offAllNamed('/home');
        }
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      
      String message = 'Invalid verification code';
      
      switch (e.code) {
        case 'invalid-verification-code':
          message = 'Invalid verification code. Please try again';
          break;
        case 'session-expired':
          message = 'Code expired. Please request a new one';
          break;
        case 'invalid-verification-id':
          message = 'Invalid verification ID. Please resend OTP';
          break;
        default:
          message = e.message ?? 'Verification failed';
      }
      
      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Verification failed: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Resend OTP
  Future<void> resendOTP() async {
    // Clear OTP fields
    for (var controller in otpControllers) {
      controller.clear();
    }
    
    // Go back and resend
    Get.back();
    await sendOTP();
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      phoneController.clear();
      for (var controller in otpControllers) {
        controller.clear();
      }
      Get.offAllNamed('/login');
      
      Get.snackbar(
        "Logged Out",
        "You have been logged out successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to logout: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Get current user
  User? get currentUser => _auth.currentUser;
  
  // Check if logged in
  bool get isLoggedIn => _auth.currentUser != null;
  
  // Get user phone number
  String? get userPhoneNumber => _auth.currentUser?.phoneNumber;
}
