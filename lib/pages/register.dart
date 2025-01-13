import 'package:bitwal_app/pages/login.dart';
import 'package:bitwal_app/widgets/my_button.dart';
import 'package:bitwal_app/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitwal_app/services/auth_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void signUp() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await context.read<AuthService>().signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
        usernameController.text.trim(),
      );
      
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      resizeToAvoidBottomInset: false,

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),

              const Image(
                image: AssetImage('lib/images/LogoText.png'),
                width: 160,
                height: 160,
              ),
              const SizedBox(height: 80),

              const Text(
                'WELCOME !',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 10
                )
              ),
              const SizedBox(height: 40),

              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 40),
              
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 40),
              
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    child: const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Color(0x80FFFFFF),
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              MyButton(
                onTap: isLoading ? () {} : signUp,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0xFFD9D9D9)
                  )
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xFF393E46),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
              ),
            ],
          )
        )
      )
    );
  }
}