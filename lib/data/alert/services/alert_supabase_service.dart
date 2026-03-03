import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AlertService {
  Future<Map<String, dynamic>> sendAlert(Map<String, dynamic> alertData);
  Future<void> cancelAlert(String alertId);
}

class AlertServiceImpl implements AlertService {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<Map<String, dynamic>> sendAlert(Map<String, dynamic> alertData) async {
    return await _supabase
        .from('incidents')
        .insert(alertData)
        .select()
        .single();
  }

  @override
  Future<void> cancelAlert(String alertId) async {
    await _supabase
        .from('incidents') 
        .update({'status': 'cancelled'})
        .eq('id', alertId);
  }
}