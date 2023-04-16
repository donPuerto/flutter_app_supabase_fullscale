// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../services/supabase/supabase_auth_service.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';
import '../../widgets/wave_header.dart';
import '../common/theme_helper.dart';
// import 'forgot_password_page.dart';
import 'signin_page.dart';

class SignUpPage extends StatefulWidget {
  static String routeName = '/register';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _redirecting = false;
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();
  late final _confirmPasswordController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;
  bool _obscureText = true;

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final AuthResponse res = await supabase.auth.signUp(
          email: _emailController.text, password: _passwordController.text);
      final Session? session = res.session;
      final User? user = res.user;
      print('Session $session');
      print('User ${user?.toJson()}');

      if (mounted) {
        print('mounted');
        context.showSnackBar(
          message: 'Register Succesfully',
          backgroundColor: Colors.green,
        );
        print('showSnackBar should show');
        _passwordController.clear();
        _emailController.clear();
        _confirmPasswordController.clear();
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

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    print('initState');
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      print('_redirecting is false');
      final session = data.session;
      if (session != null) {
        print('session');
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  void dispose() {
    print('dispose');
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

// Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = SupabaseAuthService();

    bool isValidEmail(String email) {
      // A regular expression for validating an email address
      final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

      return !emailRegExp.hasMatch(email);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const WaveHeader(height: 150),
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Hi!',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Text(
                            'Create a new Account',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  labelText: 'Email Address',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email address';
                                  }
                                  if (isValidEmail(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Container(
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: _toggle,
                                  ),
                                  filled: true,
                                  labelText: 'Password',
                                ),
                                textInputAction: TextInputAction.done,
                                validator: validatePassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Container(
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  filled: true,
                                  labelText: 'Password Confirmation',
                                ),
                                validator: (value) => validateConfirmPassword(
                                    value, _passwordController.text),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                onPressed: () async {
                                  //_isLoading ? null : _register();
                                  //print('Login Button $_isLoading');
                                  if (_formKey.currentState!.validate()) {
                                    final result = await authService.signUp(
                                        _emailController.text,
                                        _passwordController.text);
                                    final bool success = result.item1;
                                    final String error = result.item2;

                                    if (success) {
                                      // Navigate to success screen
                                      print('Navigate here $success');
                                    } else {
                                      // Show error message
                                      print('Error on signup $error');
                                    }
                                  }
                                  //After successful login we will redirect to profile page. Let's create profile page now
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const ProfilePage()));
                                },
                              ),
                            ),
                            const SizedBox(height: 40.0),
                            Row(
                              children: const [
                                Expanded(
                                  child: Divider(
                                    thickness: 1.5,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('OR'),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 1.5,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: const Color(0xFFEA4335),
                                    // add other button styles,
                                    child: IconButton(
                                      icon: const FaIcon(
                                        FontAwesomeIcons.google,
                                      ),
                                      onPressed: () {
                                        // add your code for the Google button here
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: IconButton(
                                      icon: const Icon(FontAwesomeIcons.github),
                                      onPressed: () {
                                        // add your code for the GitHub button here
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: const Color(0xFF1877F2),
                                    child: IconButton(
                                      icon:
                                          const Icon(FontAwesomeIcons.facebook),
                                      onPressed: () {
                                        // add your code for the Facebook button here
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: "Already have an account? "),
                                    TextSpan(
                                      text: 'Sign in',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          navigatorKey.currentState!
                                              .pushNamed(LoginPage.routeName);
                                        },
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                  ],
                                ),
                              ),
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
