import 'package:dartz/dartz.dart';
import 'package:vanguard_ops/core/usecases/usecases.dart';
import 'package:vanguard_ops/data/auth/models/user_sognin_req.dart';
import 'package:vanguard_ops/domain/auth/repositoreies/auth.dart';
import 'package:vanguard_ops/service_loacator.dart';

class SigninUseCase implements UseCase<Either, UserSigninReq>{
  @override
  Future<Either> call({UserSigninReq? params}) {
    return sl<AuthRepository>().signin(params!);
  }
}