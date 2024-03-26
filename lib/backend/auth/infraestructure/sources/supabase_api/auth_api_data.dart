import 'package:group_project/backend/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthApiInterface {
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  // Future<String> loginWithGoogle();
}

class AuthApiImpl implements AuthApiInterface {
  // this can be either supabase or firebase or another service
  SupabaseClient supabase; // dependency injection

  AuthApiImpl({required this.supabase});

  @override
  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await supabase.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name.trim(),
        },
      );

      if (response.user == null) {
        throw ServerException('signUpWithEmailAndPassword: user is null');
      }

      return response.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
