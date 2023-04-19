// ignore_for_file: avoid_print, unused_field, use_build_context_synchronously, unused_element

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../services/supabase/supabase_auth_service.dart';

import '../../services/supabase/supabase_client_service.dart';
import '../../utils/box_decorations.dart';
import '../../utils/custom_password_textfield.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/wave_header.dart';
import 'sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  static String routeName = '/sign_up';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _redirecting = false;
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();
  late final _confirmPasswordController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    print('initState');
    _authStateSubscription =
        supabaseClient.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      print('_redirecting is false');
      final session = data.session;
      if (session != null) {
        print('session');
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/sign_in');
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
  void _togglePassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleConfirmPassword() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = SupabaseAuthService();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const WaveHeader(),
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
                                decoration: kRoundedBoxDecoration,
                                child: CustomTextField(
                                  key: const Key('email'),
                                  controller: _emailController,
                                  labelText: 'Email Address',
                                  hintText: 'Enter your email',
                                  validator: (value) => emailError(value),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Container(
                                decoration: kRoundedBoxDecoration,
                                child: CustomPasswordTextField(
                                  key: const Key('password'),
                                  controller: _passwordController,
                                  labelText: 'Password',
                                  hintText: 'Enter your password',
                                  obscureText: _obscureTextPassword,
                                  validator: validatePassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Container(
                                decoration: kRoundedBoxDecoration,
                                //obscureText: _obscureTextConfirmPassword,
                                child: CustomPasswordTextField(
                                  key: const Key('confirmPassword'),
                                  controller: _confirmPasswordController,
                                  labelText: 'Confirm Password',
                                  hintText: 'Enter your password again',
                                  obscureText: _obscureTextConfirmPassword,
                                  validator: (value) => validateConfirmPassword(
                                      value, _passwordController.text),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                decoration: kRoundedBoxDecoration,
                                child: Builder(builder: (BuildContext context) {
                                  return ElevatedButton(
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
                                      print('onPressed');
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      if (_formKey.currentState!.validate()) {
                                        String signUpResult =
                                            await authService.signUp(
                                                _emailController.text,
                                                _passwordController.text);

                                        if (signUpResult ==
                                            // ignore: duplicate_ignore
                                            'Sign-up successful') {
                                          // Navigate to the next screen after successful sign-up
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const SignInPage(),
                                            ),
                                          );
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        } else {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          // Show error message
                                          const CustomSnackbar(
                                            message: 'Something happened',
                                            type: SnackBarType.Error,
                                          );
                                        }
                                      }
                                    },
                                  );
                                }),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                        icon:
                                            const Icon(FontAwesomeIcons.github),
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
                                        icon: const Icon(
                                            FontAwesomeIcons.facebook),
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
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
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
                                                .pushNamed(
                                                    SignInPage.routeName);
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
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
