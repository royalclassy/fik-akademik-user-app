import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordValid = false;

  void _validatePassword(String password) {
    setState(() {
      _isPasswordValid = password.length >= 6;
    });
  }

  void _resetPassword() async {
    String newPassword = _passwordController.text;
    if (_isPasswordValid) {
      try {
        // User? user = FirebaseAuth.instance.currentUser;
        // await user!.updatePassword(newPassword);
        await api_data.updatePassword(newPassword);
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password updated successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password does not meet requirements')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _passwordController,
              obscureText: true,
              onChanged: _validatePassword,
              decoration: const InputDecoration(
                labelText: 'New Password',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _isPasswordValid,
                  onChanged: (bool? value) {},
                ),
                const Text('Password must be at least 6 characters'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(const Color(0xFF3D5A80)),
            ),
              child: const Text('Done'),
            )],
        ),
      ),
    );
  }
}