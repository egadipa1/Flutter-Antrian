import 'package:antrian/auth/auth_service.dart';
import 'package:antrian/pages/auth/signup_page.dart';
import 'package:antrian/utils/show_notification.dart';
import 'package:antrian/utils/validator.dart';
import 'package:antrian/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final errorMessage = await authService.login(email, password);
    if (errorMessage && mounted) {
      ShowNotification.top(
        context,
        "Login gagal: $errorMessage",
        success: false,
      );
    } else {
      // Berhasil login
      // Navigasi ke halaman lain atau tampilkan notifikasi sukses
      ShowNotification.top(context, "Login berhasil!", success: true);
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: BackButton(),
            ),
            SafeArea(
              child: Expanded(
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // BAGIAN ATAS: Gambar
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Image.asset(
                                  "assets/images/Auth.png",
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), // BAGIAN BAWAH: Form
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CustomTextFormField(
                                  controller: _emailController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  labelText: "Email",
                                  hintText: "example@gmail.com",
                                  validator: (value) {
                                    return Validators.email(value);
                                  },
                                ),
                                const SizedBox(height: 15),
                                CustomTextFormField(
                                  controller: _passwordController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  labelText: "Password",
                                  validator: (value) {
                                    return Validators.password(value);
                                  },
                                ),
                                const SizedBox(height: 25),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      login();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(
                                      double.infinity,
                                      50,
                                    ),
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      21,
                                      101,
                                      192,
                                    ),
                                  ),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Belum punya akun? ',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: 'Daftar sekarang',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StepperDemoPage(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
