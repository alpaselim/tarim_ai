import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarim_ai/Data/app_constant_env.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Data/functions.dart';
import 'package:tarim_ai/Services/auth_service.dart';
import 'package:tarim_ai/Services/snackbar_service.dart';
import 'package:tarim_ai/Utils/CustomWidgets/custom_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextFormField alanlarindan gelen değerler
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formkey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 150,
            ),
            titleTextField(),
            const SizedBox(height: 20),
            emailTextField(),
            const SizedBox(height: 20),
            passwordTextField(),
            const SizedBox(height: 20),
            forgotPasswordButton(),
            signInButton(),
            signUpButton(),
          ],
        ),
      ),
    );
  }

  // TextFormField alanlarının üstünde bulunan başlıkları oluşturmayı sağlar.
  Text titleTextField() {
    return const Text(
      "Login",
      style: TextStyle(
        fontSize: 36.41,
        fontWeight: FontWeight.bold,
        color: kBlackColor,
      ),
    );
  }

  // Email'in alındığı TextFormField alanını oluşturur.
  TextFormField emailTextField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
      validator: (value) {
        if (value == null || value.isEmpty || functions.validateEmail(value)) {
          return "";
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(
        hintText: "Your e-mail or phone",
      ),
    );
  }

  // Password'ün alındığı TextFormField alanını oluşturur.
  TextFormField passwordTextField() {
    return TextFormField(
      controller: passwordController,
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 6) {
          return "";
        } else {
          return null;
        }
      },
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: kIconColor,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }

  // Bu fonksiyon unutulan şifreleri yenilenmesini sağlayan sayfaya yönlendirir.
  Center forgotPasswordButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: const Text(
          "Forgot password?",
          style: TextStyle(
            color: kSplashBackgroundColor,
            shadows: [
              Shadow(
                color: kShadowColor,
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

// Kullanıcının giriş yapmasını sağlayan TextButton'ı oluşturur.
  Center signInButton() {
    return Center(
      child: TextButton(
        onPressed: () async {
          if (!formkey.currentState!.validate()) {
            snackbarService
                .showWarningSnackBar("Lütfen geçerli bilgileri girin.");
          } else {
            User? user = await authService.signIn(
              emailController.text,
              passwordController.text,
            );
            if (user != null) {
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(
                context,
                homeScreenPath,
              );
            } else {
              snackbarService.showWarningSnackBar(
                "Yanlış e-posta veya şifre.",
              );
            }
          }
        },
        child: Container(
          height: 60,
          width: 248,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.5),
            color: kSplashBackgroundColor,
          ),
          child: const Center(
            child: Text("LOGIN",
                style: TextStyle(fontSize: 16, color: kWhiteColor)),
          ),
        ),
      ),
    );
  }

  // Kullanıcı eğer hesaba sahip değilse signUp ekranına yönlendiren TextButton alanını oluşturur.
  Center signUpButton() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Don't have an account?",
            style: TextStyle(
              color: kButtonGreyColor,
              fontSize: 14,
              shadows: [
                Shadow(
                  color: kShadowColor,
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, signUpScreenPath),
            child: const Text(
              "Sign Up",
              style: TextStyle(
                color: kSplashBackgroundColor,
                fontSize: 14,
                shadows: [
                  Shadow(
                    color: kShadowColor,
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
