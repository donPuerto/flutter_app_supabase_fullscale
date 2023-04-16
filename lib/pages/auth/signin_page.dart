// ignore_for_file: unused_local_variable, avoid_print

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_supabase_fullscale/widgets/wave_header.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../utils/constants.dart';
import '../common/theme_helper.dart';

import 'forgot_password_page.dart';
import 'sign_up_page.dart';
//import 'package:sizer/sizer.dart';

class SigninPage extends StatefulWidget {
  static String routeName = '/signin';
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _redirecting = false;
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signIn() async {
    print('Signin');
    setState(() {
      _isLoading = true;
    });

    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
          email: _emailController.text, password: _passwordController.text);

      if (mounted) {
        context.showSnackBar(message: 'Check your email for login link!');
        _passwordController.clear();
        _emailController.clear();
      }
    } on AuthException catch (error) {
      context.showSnackBar(
        message: error.message,
        snackBarType: SnackBarType.error,
        duration: const Duration(seconds: 3),
      );
    } catch (error) {
      context.showSnackBar(
        message: 'Unexpected error occurred',
        snackBarType: SnackBarType.error,
        duration: const Duration(seconds: 3),
      );
    }

    // final isValid =
    //     _form.currentState == null ? false : _form.currentState!.validate();

    setState(() {
      _isLoading = true;
    });
  }

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/profile');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const WaveHeader(height: 250),
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Signin into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                        key: _form,
                        child: Column(
                          children: [
                            Container(
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextFormField(
                                controller: _emailController,
                                decoration: ThemeHelper().textInputDecoration(
                                    'Email Address',
                                    'Enter your Email Address'),
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Container(
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration(
                                    'Password', 'Enter your password'),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordPage()),
                                  );
                                },
                                child: const Text(
                                  "Forgot your password?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    'Sign In'.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                onPressed: () {
                                  _isLoading ? null : _signIn();
                                  print('Login Button $_isLoading');

                                  //After successful login we will redirect to profile page. Let's create profile page now
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const ProfilePage()));
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(TextSpan(children: [
                                const TextSpan(text: "Don't have an account? "),
                                TextSpan(
                                  text: 'Create',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpPage()));
                                    },
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ])),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
