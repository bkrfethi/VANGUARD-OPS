import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/common/bloc/NavigationCubit.dart';
import 'package:vanguard_ops/core/config/assets/app_images.dart';
import 'package:vanguard_ops/core/config/theme/app_colors.dart';

class AppBottomNavbar extends StatelessWidget {
  const AppBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),  
          topRight: Radius.circular(25),
        ),
        border: Border(
          top: BorderSide(color: Colors.white10, width: 1),
        ),
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: BlocBuilder<NavigationCubit, int>(
            builder: (context, activeIndex) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    index: 0,
                    iconPath: AppImages.home,
                    activeColor: AppColors.primary,
                    isActive: activeIndex == 0,
                    context: context,
                  ),
                  _buildNavItem(
                    index: 1,
                    iconPath: AppImages.contact,
                    activeColor: AppColors.primary,
                    isActive: activeIndex == 1,
                    context: context,
                  ),
                  _buildNavItem(
                    index: 2,
                    iconPath: AppImages.setting,
                    activeColor:AppColors.primary,
                    isActive: activeIndex == 2,
                    context: context,
                  ),

                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
        required int index,
        required String iconPath,
        required Color activeColor,
        required bool isActive,
        required BuildContext context,
    }) {
        return GestureDetector(
    onTap: () {
      context.read<NavigationCubit>().setTab(index);
    },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color:  Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? activeColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Image.asset(
          iconPath,
          width: 28, 
          height: 28,
         color: isActive ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
  
}