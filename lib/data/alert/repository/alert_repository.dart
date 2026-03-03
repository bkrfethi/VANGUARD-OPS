import 'package:dartz/dartz.dart';
import 'package:vanguard_ops/data/alert/model/alert_model.dart';
import 'package:vanguard_ops/domain/alert/entities/alert_entity.dart';
import 'package:vanguard_ops/service_loacator.dart';
import '../../../domain/alert/repository/alert_repository.dart';
import '../services/alert_supabase_service.dart';
class AlertRepositoryImpl implements AlertRepository {

  @override
  Future<Either<String, AlertEntity>> sendAlert(AlertEntity alert) async {
    try {
      final model = AlertModel.fromEntity(alert);
      
      final data = await sl<AlertService>().sendAlert(model.toJson());
      
      return Right(AlertModel.fromJson(data));
    } catch (e) {
      return Left("Erreur technique : Impossible d'envoyer l'alerte.");
    }
  }

  @override
  Future<Either<String, void>> cancelAlert(String alertId) async {
    try {
      await sl<AlertService>().cancelAlert(alertId);
      return const Right(null);
    } catch (e) {
      return Left("Erreur technique : Impossible d'annuler l'alerte.");
    }
  }
}