import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Data/models/user_model.dart';
import 'package:tarim_ai/Screens/UserScreen/user_screen.dart';
import 'package:tarim_ai/Services/firestore_service.dart';
import 'package:tarim_ai/Services/snackbar_service.dart';
import 'package:tarim_ai/Services/stream_service.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  String? email;
  String _message = '';

  @override
  void initState() {
    super.initState();
    streamService
        .getCurrentUser()
        .listen((DocumentSnapshot<UserModel> snapshot) {
      if (snapshot.exists) {
        UserModel user = snapshot.data()!;
        setState(() {
          email = user.email ?? '';
        });
      } else {
        //print('Belge mevcut değil');
      }
    });
  }

  void _handleChangePassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      String currentPassword = _currentPasswordController.text;
      String newPassword = _newPasswordController.text;

      String result = await fireStoreService.changePassword(
          currentPassword, newPassword, email!);
      setState(() {
        _message = result;
      });
      snackbarService.showWarningSnackBar(_message);
      //Get.to(() => const UserScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              TextFormField(
                controller: _currentPasswordController,
                decoration:
                    const InputDecoration(labelText: 'Current Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _newPasswordController,
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmNewPasswordController,
                decoration:
                    const InputDecoration(labelText: 'Confirm New Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleChangePassword,
                child: const Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
