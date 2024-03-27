import 'package:google_sign_in/google_sign_in.dart';
import 'package:group_project/backend/auth/infraestructure/models/user_model.dart';
import 'package:group_project/backend/core/error/exceptions.dart';
import 'package:group_project/config/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthApiDataSource {
  Future<String> signUpWithPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginWithPassword({
    required String email,
    required String password,
  });

  Future<String> loginWithGoogle();

  Future<void> signOut();

  UserModel getCurrentUser();
}

class AuthSupabaseApi implements AuthApiDataSource {
  // this can be either supabase or firebase or another service
  SupabaseClient supabase; // dependency injection

  AuthSupabaseApi({required this.supabase});

  @override
  Future<String> loginWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException('loginWithPassword: user is null');
      }

      return response.user!.id;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signUpWithPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await supabase.auth.signUp(
        password: password,
        email: email,
        data: {
          'full_name': name.trim(),
        },
        emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/',
      );

      if (response.user == null) {
        throw ServerException('signUpWithEmailAndPassword: user is null');
      }

      return response.user!.id;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> loginWithGoogle() async {
    const webClientId =
        '195808061633-osujc5ir0a5ttclqfh1kurt8tv2hvfc2.apps.googleusercontent.com';
    const iosClientId =
        '195808061633-pdcjvm5aljn2evs61r1cjluadne88t9t.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );

    try {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      final AuthResponse response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user == null) {
        throw Error();
      }
      return response.user!.id;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('loginWithGoogle: user is null');
    }
  }

  @override
  Future<void> signOut() async {
    return supabase.auth.signOut();
  }

  @override
  UserModel getCurrentUser() {
    final user = supabase.auth.currentUser!;
    final Map<String, dynamic> json = {};

    json['id'] = user.id;
    json['name'] = user.userMetadata!['full_name'];
    json['email'] = user.email;
    json['avatar_url'] = user.userMetadata!['avatar_url'];

    return UserModel.fromJson(json);
  }
}
