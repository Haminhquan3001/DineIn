import 'package:fpdart/fpdart.dart';
import 'package:group_project/backend/auth/infraestructure/sources/supabase_api/auth_api_data.dart';
import 'package:group_project/backend/auth/domain/repositories/auth_repository.dart';
import 'package:group_project/backend/core/error/exceptions.dart';

class AuthRepositoryImpl implements AuthRepositoryInterface {
  final AuthApiInterface remoteData; // dependency injection

  AuthRepositoryImpl({required this.remoteData});

  @override
  Future<Either<String, String>> loginWithEmailAndPassword(
    Object email,
    String password,
  ) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> signUpWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      final userId = await remoteData.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );

      return right(userId);
    } on ServerException catch (e) {
      return left(e.message);
    }
  }
}
