import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/strings/app_strings.dart';
import '../../../config/theme/app_colors.dart';

class SafeHouseAppBar extends StatelessWidget {
  final String userName;
  final String? photoUrl;
  final VoidCallback? onNotificationTap;

  const SafeHouseAppBar({
    super.key,
    required this.userName,
    this.photoUrl,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary,
            backgroundImage:
                photoUrl != null ? NetworkImage(photoUrl!) : null,
            child: photoUrl == null
                ? Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : AppStrings.defaultAvatarLetter,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onPrimary,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${AppStrings.greeting}$userName',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onBackground,
                  ),
                ),
                Text(
                  AppStrings.welcomeBack,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.onBackgroundSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Notification
          IconButton(
            onPressed: onNotificationTap,
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.onBackground,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
