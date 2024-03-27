import 'package:fpdart/fpdart.dart';
import 'package:group_project/backend/core/entities/user/user.dart';
import 'package:group_project/backend/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithPassword(
      String name, String email, String password);

  Future<Either<Failure, User>> loginWithPassword(
      String email, String password);

  Future<Either<Failure, User>> loginWithGoogle();

  /// Logout the current user
  Future<void> signOut();
}
