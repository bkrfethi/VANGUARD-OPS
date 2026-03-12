import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/common/bloc/NavigationCubit.dart';
import 'package:vanguard_ops/common/wigets/AppBottomNavbar.dart';
import 'package:vanguard_ops/presentaion/contact/pages/contact.dart';
import 'package:vanguard_ops/presentaion/home/pages/Home.dart';
import 'package:vanguard_ops/presentaion/setting/pages/settinmg.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, int>(
        builder: (context, activeIndex) {
          return IndexedStack(
            index: activeIndex,
            children: const [
              ReportIncidentPage(),    
              ContactsPage(),
              SettingsPage(),
            
            ],
          );
        },
      ),
      bottomNavigationBar: const AppBottomNavbar(),
    );
  }
}