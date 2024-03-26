import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepositoryInterface {
  Future<Either<String, String>> signUpWithEmailAndPassword(
      String name, String email, String password);

  Future<Either<String, String>> loginWithEmailAndPassword(
      String email, String password);
}
