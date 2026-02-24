import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/data/auth/models/user_sognin_req.dart';
import 'package:vanguard_ops/domain/auth/usecases/SigninUseCase.dart';
import 'package:vanguard_ops/presentaion/auth/bloc/signin_state.dart';
import 'package:vanguard_ops/service_loacator.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SigninInitial());

  Future<void> execute(UserSigninReq params) async {
    emit(SigninLoading());

    final result = await sl<SigninUseCase>().call(params: params);

    result.fold(
      (error) {
        emit(SigninFailure(errorMessage: error.toString()));
      },
      (success) {
        emit(SigninSuccess());
      },
    );
  }
}