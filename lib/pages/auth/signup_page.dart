import 'package:flutter/material.dart';
import 'package:antrian/auth/auth_service.dart';
import 'package:antrian/utils/show_notification.dart';
import 'package:antrian/utils/validator.dart';
import 'package:antrian/widgets/custom_text_field.dart';

class StepperDemoPage extends StatefulWidget {
  const StepperDemoPage({super.key});

  @override
  State<StepperDemoPage> createState() => _StepperDemoPageState();
}

class _StepperDemoPageState extends State<StepperDemoPage> {
  final authService = AuthService();

  final _pageController = PageController();
  int _currentStep = 0;

  // Controllers
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _phoneCodeController = TextEditingController();

  // Form keys
  final _formKeys = [
    GlobalKey<FormState>(), // step 0
    GlobalKey<FormState>(), // step 1
    GlobalKey<FormState>(), // step 2
    GlobalKey<FormState>(), // step 3
  ];

  void _nextStep() {
    if (_formKeys[_currentStep].currentState!.validate()) {
      if (_currentStep < 3) {
        setState(() {
          _currentStep++;
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _submitSignup();
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submitSignup() async {
    // contoh proses signup
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final phone = _phoneController.text;

    final errorMessage = await authService.signup(username, email, password, phone);

    if (errorMessage != null && mounted) {
      ShowNotification.top(context, "Signup gagal: $errorMessage", success: false);
    } else {
      ShowNotification.top(context, "Signup berhasil!", success: true);
      Navigator.pop(context);
    }
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 0: // Username
        return Form(
          key: _formKeys[0],
          child: Column(
            children: [
              CustomTextFormField(
                controller: _usernameController,
                labelText: "Username",
                hintText: "Masukkan username",
                validator: (value) => Validators.required(value),
              ),
            ],
          ),
        );

      case 1: // Email & Password
        return Form(
          key: _formKeys[1],
          child: Column(
            children: [
              CustomTextFormField(
                controller: _emailController,
                labelText: "Email",
                hintText: "example@gmail.com",
                validator: (value) => Validators.email(value),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: _passwordController,
                labelText: "Password",
                validator: (value) => Validators.password(value),
                obscureText: true,
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: _confirmPasswordController,
                labelText: "Konfirmasi Password",
                validator: (value) => Validators.confirmPassword(value, _passwordController.text),
                obscureText: true,
              ),
            ],
          ),
        );

      case 2: // Verifikasi Email
        return Form(
          key: _formKeys[2],
          child: Column(
            children: [
              Text("Kode verifikasi sudah dikirim ke email kamu."),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: _emailCodeController,
                labelText: "Kode Verifikasi Email",
                validator: (value) => Validators.required(value),
              ),
            ],
          ),
        );

      case 3: // Phone + verifikasi
        return Form(
          key: _formKeys[3],
          child: Column(
            children: [
              CustomTextFormField(
                controller: _phoneController,
                labelText: "Nomor Telepon",
                hintText: "08xxxxxxxxxx",
                validator: (value) => Validators.phone(value),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: _phoneCodeController,
                labelText: "Kode Verifikasi Telepon",
                validator: (value) => Validators.required(value),
              ),
            ],
          ),
        );

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _currentStep > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _previousStep,
              )
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: _buildStepContent(index),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  _currentStep == 3 ? "Daftar" : "Lanjut",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
