// ignore_for_file: avoid_print, unused_field, use_build_context_synchronously, unused_element

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../services/supabase/supabase_auth_service.dart';

import '../../services/supabase/supabase_client_service.dart';
import '../../utils/box_decorations.dart';
import '../../widgets/custom_password_textfield_widget.dart';

import '../../utils/types.dart';
import '../../utils/validators.dart';

import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_textfield.dart';

import '../../widgets/divider_with_text_widget.dart';
import '../../widgets/sized_box_widget.dart';
import '../../widgets/social_media_button.dart';

import '../../widgets/terms_and_privacy_widget.dart';
import '../../widgets/wave_header.dart';
import '../privacy_policy_page.dart';
import '../terms_of_service_page.dart';
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
  late bool _isLoading = false;
  bool _redirecting = false;
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();
  late final _confirmPasswordController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  late bool _isChecked = false;

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

  void _onTermsPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TermsOfServicePage()),
    );
  }

  void _onPrivacyPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
    );
  }

  void _onCheckedChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
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
                const WaveHeader(
                  height: 150,
                ),
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
                        const SizedBoxWidget(height: 12),
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
                              const SizedBoxWidget(height: 15),
                              Container(
                                decoration: kRoundedBoxDecoration,
                                child: CustomPasswordTextFieldWidget(
                                  key: const Key('password'),
                                  controller: _passwordController,
                                  labelText: 'Password',
                                  hintText: 'Enter your password',
                                  obscureText: _obscureTextPassword,
                                  validator: validatePassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  togglePasswordVisibility: _togglePassword,
                                ),
                              ),
                              const SizedBoxWidget(height: 15),
                              Container(
                                decoration: kRoundedBoxDecoration,
                                //obscureText: _obscureTextConfirmPassword,
                                child: CustomPasswordTextFieldWidget(
                                  key: const Key('confirmPassword'),
                                  controller: _confirmPasswordController,
                                  labelText: 'Confirm Password',
                                  hintText: 'Enter your password again',
                                  obscureText: _obscureTextConfirmPassword,
                                  validator: (value) => validateConfirmPassword(
                                      value, _passwordController.text),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  togglePasswordVisibility:
                                      _toggleConfirmPassword,
                                ),
                              ),
                              const SizedBoxWidget(height: 10),
                              TermsAndPrivacyWidget(
                                isChecked: _isChecked,
                                onCheckedChanged: _onCheckedChanged,
                                onTermsPressed: _onTermsPressed,
                                onPrivacyPressed: _onPrivacyPressed,
                              ),
                              const SizedBoxWidget(height: 18),
                              Container(
                                decoration: kRoundedBoxDecoration,
                                child: Builder(builder: (BuildContext context) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Sign Up',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onPressed: () async {
                                          print('onPressed');

                                          if (!_isChecked) {
                                            // Show an error message if the user has not checked the terms and policy checkbox
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              CustomSnackbar(
                                                message:
                                                    'Please accept the Terms of Service and Privacy Policy',
                                                type: SnackBarType.Information,
                                              ),
                                            );
                                            return;
                                          }

                                          setState(() {
                                            _isLoading = true;
                                          });

                                          if (_formKey.currentState!
                                              .validate()) {
                                            String signUpResult =
                                                await authService.signUp(
                                                    _emailController.text,
                                                    _passwordController.text);

                                            if (signUpResult ==
                                                // ignore: duplicate_ignore
                                                'Sign-up successful') {
                                              // Navigate to the next screen after successful sign-up
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          const SignInPage(),
                                                ),
                                              );
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                CustomSnackbar(
                                                  message:
                                                      'Oops! Something went wrong',
                                                  type: SnackBarType.Error,
                                                ),
                                              );
                                            }
                                          }
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }),
                                  );
                                }),
                              ),
                              const SizedBoxWidget(height: 30),
                              const DividerWithTextWidget(text: 'OR'),
                              const SizedBoxWidget(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: SocialMediaButton(
                                      buttonType:
                                          SocialLoginButtonType.googleLogin,
                                      onPressed: () {},
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: SocialMediaButton(
                                      buttonType:
                                          SocialLoginButtonType.facebookLogin,
                                      onPressed: () {},
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: SocialMediaButton(
                                      buttonType:
                                          SocialLoginButtonType.twitterLogin,
                                      onPressed: () {},
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: SocialMediaButton(
                                      buttonType:
                                          SocialLoginButtonType.githubLogin,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBoxWidget(height: 30),
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
                                        text: 'Sign In',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SignInPage()));
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
