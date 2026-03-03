import 'package:vanguard_ops/domain/alert/entities/alert_entity.dart';

class AlertModel extends AlertEntity {
  AlertModel({
    super.id, required super.userId, required super.latitude, 
    required super.longitude, required super.description, 
    super.status, required super.createdAt
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'lat': latitude,
    'lng': longitude,
    'description': description,
    'status': status,
    'created_at': createdAt.toIso8601String(),
  };
}