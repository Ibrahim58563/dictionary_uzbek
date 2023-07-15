import 'package:dictionary/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: AppColors.secondary,
              size: 120,
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                'Ushbu dastur O’zbek tililning izohli lughat kitobidan olingan bo’lib, turli tuman sohalarga oyid 80,000 so’z va so’z birikmalarini o’z ichiga oladi.\nAlloh taolo barcha musulmonlar va ilm talabalari uchun foydali qilsin.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
