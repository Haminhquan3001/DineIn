import 'package:fpdart/fpdart.dart';
import 'package:group_project/backend/auth/infraestructure/models/user_model.dart';
import 'package:group_project/backend/auth/infraestructure/sources/auth_supabase_api.dart';
import 'package:group_project/backend/auth/domain/repositories/auth_repository.dart';
import 'package:group_project/backend/core/entities/user/user.dart';
import 'package:group_project/backend/core/error/exceptions.dart';
import 'package:group_project/backend/core/error/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiDataSource remoteApi; // dependency injection

  AuthRepositoryImpl({required this.remoteApi});

  @override
  Future<Either<Failure, User>> signUpWithPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      final userId = await remoteApi.signUpWithPassword(
        name: name,
        email: email,
        password: password,
      );

      final user = UserModel(
        id: userId,
        name: name,
        email: email,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithPassword(
    String email,
    String password,
  ) async {
    try {
      final userId = await remoteApi.loginWithPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        id: userId,
        name: '',
        email: email,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithGoogle() async {
    try {
      await remoteApi.loginWithGoogle();
      final user = remoteApi.getCurrentUser();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<void> signOut() async {
    return await remoteApi.signOut();
  }
}
