import 'package:flutter/material.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

import '../../../../core/constant/assets_manager.dart';
import '../../../../core/extension/app_extension.dart';
import 'accepts_doctor_reviews.dart';

class RequestReviewDocCard extends StatelessWidget {
  const RequestReviewDocCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: const Color(0xFFE8E9EC)),
          borderRadius: BorderRadius.circular(24),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x33C6BBCA),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x05FFFFFF),
            blurRadius: 0,
            offset: Offset(0, -1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        spacing: 16,
          children: [
            Row(
              spacing: 10,
              children: [
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      "A. Marwa Al-Sudani",
                      style: theme.bold18.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.primaryColor500,
                      fontSize: 14,
                    ),
                  ),

                  Text(
                    "Disclosure - Persistent headache and neck pain",
                    style: theme.bold12.copyWith(
                      color: theme.textColor300,
                      fontSize: 10,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: theme.textColor300,
                        size: 18,
                      ),
                      Text(
                        'Tomorrow - 9:30 AM',
                        style: theme.bold12.copyWith(color: theme.textColor300),
                      ),
                    ],
                  ),
                ],
              ),
              
              CustomImageView(imagePath: AssetsManager.edit),
            ],
          ),
          AcceptDoctorBtn(),
        ],
      ),
    );
  }
}

