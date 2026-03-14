import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vanguard_ops/core/services/localisaation_services.dart';
import 'package:vanguard_ops/domain/alert/entities/alert_entity.dart';
import 'package:vanguard_ops/domain/alert/usecases/cancel_alert_usecase.dart';
import 'package:vanguard_ops/domain/alert/usecases/send_alert_usecases.dart';
import 'package:vanguard_ops/service_loacator.dart';
import 'alert_state.dart';

class AlertCubit extends Cubit<AlertState> {
  Timer? _countdownTimer;
  StreamSubscription? _timerSubscription;
  int _countdown = 3;
  AlertEntity? _activeAlert;
  static const int _countdownDuration = 3;

  AlertCubit() : super(const AlertInitial());

  Future<void> triggerEmergency(String description) async {
    emit(const AlertLoading());

    try {
      final user = sl<SupabaseClient>().auth.currentUser;
      if (user == null) {
        emit(const AlertError("Erreur : Utilisateur non authentifié. Veuillez vous reconnecter."));
        return;
      }

      final position = await sl<LocationService>().getCurrentPosition();

      _activeAlert = AlertEntity(
        userId: user.id,
        latitude: position.latitude,
        longitude: position.longitude,
        description: description,
        createdAt: DateTime.now(),
      );

      _startCountdownTimer();
    } catch (e) {
      emit(AlertError("GPS non disponible : $e"));
    }
  }


  void _startCountdownTimer() {
    _countdown = _countdownDuration;
    emit(AlertTimerInProgress(_countdown));

    _timerSubscription?.cancel();
    _timerSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (count) => _countdownDuration - count - 1,
    ).takeWhile((tick) => tick >= 0).listen(
      (remaining) {
        if (!isClosed) {
          _countdown = remaining;
          if (remaining > 0) {
            emit(AlertTimerInProgress(remaining));
          } else {
            _sendFinalAlert();
          }
        }
      },
    );
  }

  Future<void> _sendFinalAlert() async {
    if (isClosed) return;

    emit(const AlertSending());

    final result = await sl<SendAlertUseCase>().call(params: _activeAlert);

    if (!isClosed) {
      result.fold(
        (error) => emit(AlertError(error)),
        (alert) {
          _activeAlert = alert;
          emit(AlertSuccess(alert));
        },
      );
    }
  }

  Future<void> cancelAlert() async {
    _timerSubscription?.cancel();
    _countdownTimer?.cancel();

    if (_activeAlert?.id != null) {
      if (!isClosed) {
        emit(const AlertCancelling());
      }

      final result = await sl<CancelAlertUseCase>().call(params: _activeAlert!.id);

      if (!isClosed) {
        result.fold(
          (error) => emit(AlertError(error)),
          (_) => emit(const AlertInitial()),
        );
      }
    } else {
      if (!isClosed) {
        emit(const AlertInitial());
      }
    }
  }

  @override
  Future<void> close() async {
    _timerSubscription?.cancel();
    _countdownTimer?.cancel();
    return super.close();
  }
}