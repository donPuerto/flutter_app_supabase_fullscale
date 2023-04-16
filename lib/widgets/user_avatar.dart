import 'package:flutter/material.dart';

import '../utils/constants.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarUrl = user?.avatarUrl;
    return CircleAvatar(
      backgroundImage: avatarUrl != null
          ? const AssetImage('assets/images/DPLogo.png')
          : const AssetImage('assets/images/default_avatar.png'),
    );
  }
}
