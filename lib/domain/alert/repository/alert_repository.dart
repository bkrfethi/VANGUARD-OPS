import 'package:dartz/dartz.dart';

import '../entities/alert_entity.dart';

abstract class AlertRepository {
  Future<Either> sendAlert(AlertEntity alert);
  Future<Either> cancelAlert(String alertId);
}