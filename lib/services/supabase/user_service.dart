import 'package:supabase_flutter/supabase_flutter.dart';
import 'client_service.dart';

class UserService {
  //final supabaseClient = Supabase.instance.client;

  Future<User?> getCurrentUser() async {
    final currentUser = client.auth.currentUser;
    return currentUser;
  }

  Future<User?> authResponse(AuthResponse res) async {
    final User? user = res.user;
    return user;
  }

  Future<Session?> getCurrentSession() async {
    final currentSession = client.auth.currentSession;
    return currentSession;
  }

  Future<bool> isAuthenticated() async {
    final currentUser = client.auth.currentUser;
    return currentUser != null;
  }

  Future<bool> isLoggedIn() async {
    return client.auth.currentSession != null;
  }

  Future<String?> getCurrentUserId() async {
    final user = await getCurrentUser();
    final currentUserId = user?.id;
    return currentUserId;
  }
}
