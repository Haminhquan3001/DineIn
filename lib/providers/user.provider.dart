import 'package:flutter/material.dart';
import 'package:group_project/backend/auth/domain/repositories/auth_repository.dart';
import 'package:group_project/backend/core/entities/user/user.dart';
import 'package:group_project/config/constants.dart';

class UserProvider with ChangeNotifier {
  UserProvider(this._authRepository);

  User _user = User(id: '', name: '', email: '');
  final AuthRepository _authRepository;
  bool _isLoading = false;

  User get user => _user;
  bool get isLoading => _isLoading;

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
        _user = user;
        notifyListeners();
        return ApiResponse(data: user);
      },
    );
  }

  Future<ApiResponse<User>> useSignUpWithPassword(
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
      (user) {
        _user = user;
        notifyListeners();
        return ApiResponse(data: user);
      },
    );
  }

  Future<ApiResponse<User>> useLoginWithGoogle() async {
    final result = await _authRepository.loginWithGoogle();

    return result.fold(
      (error) => ApiResponse(error: error.message),
      (user) {
        _user = user.copyWith();
        return ApiResponse<User>(data: user);
      },
    );
  }

  Future<void> useSignOut() async {
    _isLoading = true;
    notifyListeners();

    await _authRepository.signOut();

    _isLoading = false;
    _user = User(id: '', name: '', email: '');
    notifyListeners();
  }
}
