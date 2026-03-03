import 'package:vanguard_ops/domain/alert/entities/alert_entity.dart';

class AlertModel extends AlertEntity {
  AlertModel({
    super.id,
    required super.userId,
    required super.latitude,
    required super.longitude,
    required super.description,
    super.status,
    required super.createdAt,
  });

  factory AlertModel.fromEntity(AlertEntity entity) {
    return AlertModel(
      id: entity.id,
      userId: entity.userId,
      latitude: entity.latitude,
      longitude: entity.longitude,
      description: entity.description,
      status: entity.status,
      createdAt: entity.createdAt,
    );
  }

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      id: json['id']?.toString(),
      userId: json['user_id'] ?? '',
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lng'] as num).toDouble(),
      description: json['description'] ?? '',
      status: json['status'] ?? 'active',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'lat': latitude,
    'lng': longitude,
    'description': description,
    'status': status,
    'created_at': createdAt.toIso8601String(),
  };
}