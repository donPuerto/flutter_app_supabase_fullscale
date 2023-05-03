// ignore_for_file: avoid_print

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_profile_model.dart';
import '../services/supabase/client_service.dart';

Future<void> updateProfile({
  required String userId,
  String? avatarUrl,
  String? firstName,
  String? lastName,
  String? username,
  String? jobTitle,
  String? userStatus,
  String? website,
}) async {
  final updates = {
    'id': userId,
    'avatar_url': avatarUrl,
    'first_name': firstName,
    'last_name': lastName,
    'username': username,
    'job_title': jobTitle,
    'user_status': userStatus,
    'website': website,
    'updated_at': DateTime.now().toIso8601String(),
  };

  try {
    final SupabaseClient supabase = Supabase.instance.client;
    final res = await supabase.from('profiles').upsert(updates);
    final data = res.data;
    print('--------------------------');
    print('data $data');
    print('--------------------------');

    //snackbar
  } catch (error) {
    // context.showErrorSnackBar(message: error.toString());
    print('Error while upserting data to profiles table: $error');
  }

  // if (response.error != null) {
  //   throw response.error!;
  // }

  // return UserProfileModel.fromJson(response.data![0] as Map<String, dynamic>);
}

Future<UserProfileModel> getProfileById(String userId) async {
  final response =
      await client.from('profiles').select().eq('id', userId).single();

  final userProfileMap = response as Map<String, dynamic>?;

  if (userProfileMap == null) {
    throw Exception('User profile not found for user ID: $userId');
  }

  return UserProfileModel.fromJson(userProfileMap);
}
