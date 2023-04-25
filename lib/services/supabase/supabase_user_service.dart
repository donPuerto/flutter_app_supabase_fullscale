import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_client_service.dart';

class SupabaseUserService {
  //final supabaseClient = Supabase.instance.client;

  Future<User?> getCurrentUser() async {
    final currentUser = supabaseClient.auth.currentUser;
    return currentUser;
  }

  Future<User?> authResponse(AuthResponse res) async {
    final User? user = res.user;
    return user;
  }

  Future<Session?> getCurrentSession() async {
    final currentSession = supabaseClient.auth.currentSession;
    return currentSession;
  }

  Future<bool> isAuthenticated() async {
    final currentUser = supabaseClient.auth.currentUser;
    return currentUser != null;
  }
}
