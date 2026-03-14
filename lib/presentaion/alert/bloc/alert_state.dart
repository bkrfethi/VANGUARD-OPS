import 'package:vanguard_ops/domain/alert/entities/alert_entity.dart';

abstract class AlertState {
  const AlertState();
}

class AlertInitial extends AlertState {
  const AlertInitial();
}

class AlertLoading extends AlertState {
  const AlertLoading();
}

class AlertTimerInProgress extends AlertState {
  final int secondsLeft;
  const AlertTimerInProgress(this.secondsLeft);
}

class AlertSending extends AlertState {
  const AlertSending();
}

class AlertSuccess extends AlertState {
  final AlertEntity alert;
  const AlertSuccess(this.alert);
}

class AlertCancelling extends AlertState {
  const AlertCancelling();
}

class AlertError extends AlertState {
  final String message;
  const AlertError(this.message);
}