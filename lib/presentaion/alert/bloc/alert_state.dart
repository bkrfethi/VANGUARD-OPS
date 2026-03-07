import 'package:vanguard_ops/domain/alert/entities/alert_entity.dart';

abstract class AlertState {}

class AlertInitial extends AlertState {}
class AlertLoading extends AlertState {}
class AlertTimerInProgress extends AlertState {
  final int secondsLeft;
  AlertTimerInProgress(this.secondsLeft);
}
class AlertSending extends AlertState {}
class AlertSuccess extends AlertState {
  final AlertEntity alert;
  AlertSuccess(this.alert);
}
class AlertCancelling extends AlertState {}
class AlertError extends AlertState {
  final String message;
  AlertError(this.message);
}