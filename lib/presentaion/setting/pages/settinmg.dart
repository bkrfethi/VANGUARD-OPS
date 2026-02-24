import 'package:flutter/material.dart';
import 'package:vanguard_ops/common/helper/appbar/app_bar..dart';

class Settingpage
 extends StatelessWidget {
  const Settingpage
({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.black, 
      body: Column(
        children: [
          const RdAppBar(),
          
          Expanded(
            child: Center(
              child: Text(
                "CONTENU DE LA CARTE ICI", 
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}