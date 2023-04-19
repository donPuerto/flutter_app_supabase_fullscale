// Supabase
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClient = Supabase.instance.client;
// Supabase User
final User? user = supabaseClient.auth.currentUser;

// Supabase User id
final userId = supabaseClient.auth.currentUser?.id;
// Supabase User Email
final userEmail = supabaseClient.auth.currentUser?.email;
