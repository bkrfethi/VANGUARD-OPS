import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vanguard_ops/common/bloc/NavigationCubit.dart';
import 'package:vanguard_ops/presentaion/auth/bloc/signin_cubit.dart';
import 'package:vanguard_ops/presentaion/contact/bloc/contacts_bloc.dart';
import 'package:vanguard_ops/presentaion/main_wrapper.dart';
import 'package:vanguard_ops/presentaion/setting/bloc/settings_cubit.dart';
import 'package:vanguard_ops/service_loacator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!, 
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SigninCubit>()),
        BlocProvider(create: (context) => sl<NavigationCubit>()),
        BlocProvider(create: (context) => sl<SettingsCubit>()), 
BlocProvider(create: (context) => sl<ContactsCubit>()..loadContacts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark, 
        ),
        home: MainWrapper(),
      ),
    );
  }
}