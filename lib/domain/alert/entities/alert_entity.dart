class AlertEntity {
  final String? id;
  final String userId;
  final double latitude;
  final double longitude;
  final String description;
  final String status; 
  final DateTime createdAt;

  AlertEntity({
    this.id,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.description,
    this.status = 'active',
    required this.createdAt,
  });
}