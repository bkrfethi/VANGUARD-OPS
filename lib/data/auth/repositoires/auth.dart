import 'package:dartz/dartz.dart';
import 'package:vanguard_ops/data/auth/models/user_sognin_req.dart';
import 'package:vanguard_ops/data/auth/serevices/auth_supabase_service.dart';
import 'package:vanguard_ops/domain/auth/repositoreies/auth.dart';
import 'package:vanguard_ops/service_loacator.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
Future<Either> signin(UserSigninReq signinReq) async {
    return await sl<AuthSupabaseService>().signin(signinReq);
  }
}