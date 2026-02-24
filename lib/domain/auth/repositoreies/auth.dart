import 'package:dartz/dartz.dart';
import 'package:vanguard_ops/data/auth/models/user_sognin_req.dart';

abstract  class AuthRepository{
  Future<Either> signin(UserSigninReq signinReq);
}