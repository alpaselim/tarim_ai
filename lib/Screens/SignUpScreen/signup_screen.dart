import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarim_ai/Data/app_constant_env.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Data/functions.dart';
import 'package:tarim_ai/Data/models/user_model.dart';
import 'package:tarim_ai/Services/auth_service.dart';
import 'package:tarim_ai/Services/firestore_service.dart';
import 'package:tarim_ai/Services/snackbar_service.dart';
import 'package:tarim_ai/Utils/CustomWidgets/custom_scaffold.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  // Password'ün görünürlüğünü kontrol eden değer
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
            titleTextField("Sign Up", kBlackColor, 36, FontWeight.bold),
            const SizedBox(height: 20),
            fullNameTextField(),
            const SizedBox(height: 20),
            emailTextField(),
            const SizedBox(height: 20),
            passwordTextField(),
            const SizedBox(height: 20),
            signUpButton(),
            loginButton(),
          ],
        ),
      ),
    );
  }

  // TextFormField alanlarının üstünde bulunan başlıkları oluşturmayı sağlar.
  Text titleTextField(
      String text, Color myColor, double fontSize, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: myColor,
      ),
    );
  }

  // Fullname'in alındığı TextFormField alanını oluşturur.
  TextFormField fullNameTextField() {
    return TextFormField(
      controller: fullnameController,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 2) {
          return "";
        } else {
          return null;
        }
      },
      style: const TextStyle(color: kBlackColor),
      decoration: const InputDecoration(
        hintText: "Full name",
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
        errorStyle: const TextStyle(height: 0),
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

  // Kullanıcı hesabının oluşturululmasını sağlayan TextButton'ı oluşturur.

  Center signUpButton() {
    return Center(
      child: TextButton(
        onPressed: () async {
          if (!formkey.currentState!.validate()) {
            snackbarService
                .showWarningSnackBar("Lütfen geçerli bilgileri girin.");
          } else {
            User? user = await authService.signUp(
                emailController.text, passwordController.text);

            if (user != null) {
              UserModel users = UserModel(
                name: fullnameController.text,
                email: emailController.text,
                password: passwordController.text,
                phoneNumber: '',
                uid: user.uid,
                profilePicture: '',
              );
              await fireStoreService.addNewUser(users);
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(
                // ignore: use_build_context_synchronously
                context,
                homeScreenPath,
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
            child: Text("SIGN UP",
                style: TextStyle(fontSize: 16, color: kWhiteColor)),
          ),
        ),
      ),
    );
  }

  // Kullanıcı eğer hesaba sahipse login ekranına yönlendiren TextButton alanını oluşturur.
  Center loginButton() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already have an account?",
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
            onPressed: () => Navigator.pushNamed(context, loginScreenPath),
            child: const Text(
              "Login",
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
