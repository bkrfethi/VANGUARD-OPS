import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vanguard_ops/core/services/localisaation_services.dart';
import 'package:vanguard_ops/domain/alert/entities/alert_entity.dart';
import 'package:vanguard_ops/domain/alert/usecases/cancel_alert_usecase.dart';
import 'package:vanguard_ops/domain/alert/usecases/send_alert_usecases.dart';
import 'package:vanguard_ops/service_loacator.dart';
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
    // 1. Vérifier si l'utilisateur est connecté
    final user = sl<SupabaseClient>().auth.currentUser;
    if (user == null) {
      emit(AlertError("Erreur : Utilisateur non authentifié. Veuillez vous reconnecter."));
      return;
    }

    // 2. Récupérer la position GPS
    final position = await sl<LocationService>().getCurrentPosition();
    
    _activeAlert = AlertEntity(
      userId: user.id, // Plus de "!" ici, on a vérifié au-dessus
      latitude: position.latitude,
      longitude: position.longitude,
      description: description,
      createdAt: DateTime.now(),
    );
    
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

  Future<void> _sendFinalAlert() async {
    emit(AlertSending());
    
    final result = await sl<SendAlertUseCase>().call(params: _activeAlert);
    
    result.fold(
      (error) => emit(AlertError(error)),
      (alert) {
        _activeAlert = alert; 
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