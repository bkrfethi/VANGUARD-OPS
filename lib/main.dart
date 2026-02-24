import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://spyovrtrcmrxgwdtimzd.supabase.co',
    anonKey: 'sb_publishable_n4HqG0AuT5jK3TbRgxapnQ_ZnLaisuJ',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ',
   
    );
  }
}


