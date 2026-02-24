import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vanguard_ops/data/auth/models/user_sognin_req.dart';


abstract class AuthSupabaseService {
  Future<Either> signin(UserSigninReq user);
}

class AuthSupabaseServiceImpl extends AuthSupabaseService {
  final supabase = Supabase.instance.client;

  @override
  Future<Either> signin(UserSigninReq user) async {
    try {
      await supabase.auth.signInWithPassword(
        email: user.email!,
        password: user.password!,
      );
      
      return const Right(true);
    } on AuthException catch (e) {
      return Left(e.message); 
    } catch (e) {
      return const Left("Une erreur inattendue est survenue");
    }
  }
}