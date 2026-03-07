import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vanguard_ops/core/services/location_service.dart';
import 'package:vanguard_ops/domain/alert/entities/alert_entity.dart';
import 'package:vanguard_ops/domain/alert/usecases/send_alert_usecase.dart';
import 'package:vanguard_ops/domain/alert/usecases/cancel_alert_usecase.dart';
import 'alert_state.dart';

class AlertCubit extends Cubit<AlertState> {
  Timer? _timer;
  int _countdown = 3;
  AlertEntity? _activeAlert;

  AlertCubit() : super(AlertInitial());

  // Déclenche le processus : GPS -> Timer -> Envoi
  Future<void> triggerEmergency(String description) async {
    emit(AlertLoading());

    try {
      // 1. Récupérer la position GPS immédiatement
      Position position = await sl<LocationService>().getCurrentPosition();
      
      // 2. Préparer l'entité (on l'enverra après le timer)
      _activeAlert = AlertEntity(
        userId: sl<SupabaseClient>().auth.currentUser!.id,
        latitude: position.latitude,
        longitude: position.longitude,
        description: description,
        createdAt: DateTime.now(),
      );

      // 3. Lancer le compte à rebours
      _startTimer();
    } catch (e) {
      emit(AlertError("GPS non disponible : $e"));
    }
  }

  void _startTimer() {
    _countdown = 3;
    emit(AlertTimerInProgress(_countdown));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      _countdown--;
      
      if (_countdown > 0) {
        emit(AlertTimerInProgress(_countdown));
      } else {
        _timer?.cancel();
        _sendFinalAlert();
      }
    });
  }

  // Envoi effectif à Supabase
  Future<void> _sendFinalAlert() async {
    emit(AlertSending());
    
    final result = await sl<SendAlertUseCase>().call(params: _activeAlert);
    
    result.fold(
      (error) => emit(AlertError(error)),
      (alert) {
        _activeAlert = alert; // On garde l'ID pour une éventuelle annulation
        emit(AlertSuccess(alert));
      }
    );
  }

  // Annuler l'alerte
  Future<void> cancelAlert() async {
    _timer?.cancel();
    
    if (_activeAlert?.id != null) {
      emit(AlertCancelling());
      final result = await sl<CancelAlertUseCase>().call(params: _activeAlert!.id);
      result.fold(
        (error) => emit(AlertError(error)),
        (_) => emit(AlertInitial())
      );
    } else {
      emit(AlertInitial());
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}