import 'package:flutter/material.dart';

//import 'package:supabase_flutter/supabase_flutter.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundImage: AssetImage('assets/images/DPLogo.png'),
    );
  }
}
