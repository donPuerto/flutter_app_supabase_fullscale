// ignore_for_file: unused_field, avoid_print, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../models/user_profile_model.dart';
import '../../services/supabase/user_service.dart';
import '../../api/profile_api.dart';
import '../../widgets/avatar_widget.dart';
import '../../widgets/custom_snackbar_widget.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String? _id;
  String? _avatarUrl;
  String? _firstName;
  String? _lastName;
  String? _username;
  String? _jobTitle;
  String? _userStatus;
  String? _website;

  UserProfileModel? _userProfile;

  // declare controllers
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _avatarUrlController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _userStatusController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  late bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserService userService = UserService();

      final String? currentUserId = await userService.getCurrentUserId();
      final userProfileModel = await getProfileById(currentUserId as String);

      // ignore: unnecessary_null_comparison
      if (userProfileModel != null) {
        if (mounted) {
          setState(() {
            _idController.text = userProfileModel.id;
            _avatarUrlController.text = userProfileModel.avatarUrl ?? '';
            _firstNameController.text = userProfileModel.firstName ?? '';
            _lastNameController.text = userProfileModel.lastName ?? '';
            _usernameController.text = userProfileModel.username ?? '';
            _jobTitleController.text = userProfileModel.jobTitle ?? '';
            _userStatusController.text = userProfileModel.userStatus ?? '';
            _websiteController.text = userProfileModel.website ?? '';
          });
        }
      }
    } catch (e) {
      print('Error loading user profile: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _avatarUrlController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _jobTitleController.dispose();
    _userStatusController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/dashboard',
              );
            },
          ),
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _loadUserProfile();
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipPath(
                            clipper: CustomShape(),
                            child: Stack(
                              children: [
                                Container(
                                  height: SizeConfig.defaultSize * 15, //150
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: const [
                                        Colors.red,
                                        Colors.blue
                                      ], // Specify the desired colors
                                      begin: Alignment
                                          .topLeft, // Define the starting point of the gradient
                                      end: Alignment
                                          .bottomRight, // Define the ending point of the gradient
                                      // You can also specify additional options such as stops and tileMode
                                    ),
                                  ),
                                  child: Positioned.fill(
                                    top: SizeConfig.defaultSize *
                                        7.5, // Adjust the position as needed
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: AvatarWidget(
                                        avatarCircleRadius: 120.0,
                                        avatarSquareSize: 180,
                                        imageUrl:
                                            'https://img.freepik.com/premium-psd/3d-avatar-orange-shirt-woman-with-hat-character-png-transparent_206410-291.jpg',
                                        avatarType: AvatarType.SQUARE,
                                        backgroundColor: Colors.amber,
                                        borderElevation: 10,
                                        borderColor: Colors.grey,
                                        borderThickness: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AvatarWidget(
                            avatarCircleRadius: 120.0,
                            avatarSquareSize: 180,
                            imageUrl:
                                'https://img.freepik.com/premium-psd/3d-avatar-orange-shirt-woman-with-hat-character-png-transparent_206410-291.jpg',
                            avatarType: AvatarType.SQUARE,
                            backgroundColor: Colors.amber,
                            borderElevation: 10,
                            borderColor: Colors.grey,
                            borderThickness: 10,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _idController,
                            decoration: const InputDecoration(
                              labelText: 'User ID',
                            ),
                            onSaved: (value) {
                              _id = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _avatarUrlController,
                            decoration: const InputDecoration(
                              labelText: 'Avatar URL',
                            ),
                            onSaved: (value) {
                              _avatarUrl = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                            ),
                            onSaved: (value) {
                              _firstName = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                            ),
                            onSaved: (value) {
                              _lastName = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                            ),
                            onSaved: (value) {
                              _username = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _jobTitleController,
                            decoration: const InputDecoration(
                              labelText: 'Job Title',
                            ),
                            onSaved: (value) {
                              _jobTitle = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _userStatusController,
                            decoration: const InputDecoration(
                              labelText: 'User Status',
                            ),
                            onSaved: (value) {
                              _userStatus = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _websiteController,
                            decoration: const InputDecoration(
                              labelText: 'Website',
                            ),
                            onSaved: (value) {
                              _website = value;
                            },
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                setState(() {
                                  _isLoading = true;
                                });

                                if (_idController.text.isEmpty) {
                                  throw 'User ID cannot be blank';
                                }

                                await updateProfile(
                                  userId: _idController.text,
                                  avatarUrl: _avatarUrlController.text,
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  username: _usernameController.text,
                                  jobTitle: _jobTitleController.text,
                                  userStatus: _userStatusController.text,
                                  website: _websiteController.text,
                                );

                                setState(() {
                                  _isLoading = false;
                                });
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackbarWidget(
                                    message: error.toString(),
                                    type: SnackBarType.Error,
                                  ),
                                );
                              }
                            },
                            child: const Text('Update Profile'),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
