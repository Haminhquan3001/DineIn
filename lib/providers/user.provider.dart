import 'package:flutter/material.dart';
import 'package:group_project/backend/auth/domain/repositories/auth_repository.dart';
import 'package:group_project/backend/core/entities/user/user.dart';
import 'package:group_project/config/constants.dart';
import 'package:group_project/ui/utils/local_storage_singleton.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

class UserProvider with ChangeNotifier {
  UserProvider(this._authRepository);

  final AuthRepository _authRepository;

  User _user = User(
      id: sp.Supabase.instance.client.auth.currentUser?.id ?? '',
      name: sp.Supabase.instance.client.auth.currentUser
              ?.userMetadata?['full_name'] ??
          '',
      email: sp.Supabase.instance.client.auth.currentUser?.email ?? '',
      avatarUrl: sp.Supabase.instance.client.auth.currentUser
              ?.userMetadata?['avatar_url'] ??
          '');
  bool _isLoading = false;

  User get getUser => _user;
  bool get isLoading => _isLoading;

  set setUser(User user) {
    _user = user;
    notifyListeners();
  }

  bool isLoggedIn() {
    return _user.id != '';
  }

  Future<ApiResponse<User>> useLoginWithPassword(
    String email,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();

    final result = await _authRepository.loginWithPassword(email, password);

    _isLoading = false;
    notifyListeners();

    return result.fold(
      (error) => ApiResponse(error: error.message),
      (user) {
        setUser = _user.copyWithObject(user);
        notifyListeners();
        return ApiResponse(data: getUser);
      },
    );
  }

  Future<ApiResponse<String>> useSignUpWithPassword(
    String name,
    String email,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();

    final result =
        await _authRepository.signUpWithPassword(name, email, password);

    _isLoading = false;
    notifyListeners();

    return result.fold(
      (error) => ApiResponse(error: error.message),
      (message) => ApiResponse(data: message),
    );
  }

  Future<ApiResponse<User>> useLoginWithGoogle() async {
    final result = await _authRepository.loginWithGoogle();
    // this user only have the fields:

    return result.fold(
      (error) => ApiResponse(error: error.message),
      (user) {
        setUser = _user.copyWithObject(user);
        notifyListeners();
        return ApiResponse<User>(data: getUser);
      },
    );
  }

  Future<void> useSignOut() async {
    _isLoading = true;

    await _authRepository.signOut();

    _isLoading = false;
    _user = User(id: '', name: '', email: '', avatarUrl: '');

    await KwunLocalStorage.setString("favorites", "[]");
    await KwunLocalStorage.setBool("is_owner", false);
    notifyListeners();
  }

  Future<ApiResponse<String>> useSendContactForm({
    required String senderName,
    required String senderEmail,
    required String senderMessage,
  }) async {
    final result = await _authRepository.sendContactForm(
      senderName: senderName,
      senderEmail: senderEmail,
      senderMessage: senderMessage,
    );

    return result.fold(
      (error) => ApiResponse(error: error.message),
      (message) => ApiResponse(data: message),
    );
  }

  Future<ApiResponse<String>> useUpdateProfile({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) async {
    final result = await _authRepository.updateAccount(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );

    return result.fold(
      (error) => ApiResponse(error: error.message),
      (user) {
        setUser = _user.copyWithObject(user);
        notifyListeners();
        return ApiResponse(
            data: 'Hey ${_user.name}. Your profile was updated!');
      },
    );
  }
}
