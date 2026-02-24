abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninSuccess extends SigninState {}

class SigninFailure extends SigninState {
  final String errorMessage;
  SigninFailure({required this.errorMessage});
}