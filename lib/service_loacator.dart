import 'package:get_it/get_it.dart';
import 'package:vanguard_ops/data/auth/serevices/auth_supabase_service.dart';

final sl =GetIt.instance;

Future<void> initializedependencies() async {
  // services 

    sl.registerSingleton<AuthSupabaseService>(AuthSupabaseServiceImpl());


//repositories 
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());



// usecese 

}