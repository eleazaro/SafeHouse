import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/strings/app_strings.dart';
import '../../../config/theme/app_colors.dart';
import '../../../domain/models/property.dart';

class FilterChipsBar extends StatelessWidget {
  final PropertyType? activeFilter;
  final ValueChanged<PropertyType?> onFilterChanged;

  const FilterChipsBar({
    super.key,
    required this.activeFilter,
    required this.onFilterChanged,
  });

  static final _filters = [
    (label: AppStrings.filterAll, type: null, icon: Icons.bookmark_outline),
    (label: AppStrings.filterApartment, type: PropertyType.apartment, icon: Icons.apartment),
    (label: AppStrings.filterHouse, type: PropertyType.house, icon: Icons.home_outlined),
    (label: AppStrings.filterStudio, type: PropertyType.studio, icon: Icons.weekend_outlined),
    (label: AppStrings.filterCommercial, type: PropertyType.commercial, icon: Icons.business),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isActive = activeFilter == filter.type;

          return GestureDetector(
            onTap: () => onFilterChanged(filter.type),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: isActive
                    ? null
                    : Border.all(color: AppColors.divider),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index == 0) ...[
                    Icon(
                      filter.icon,
                      size: 16,
                      color: isActive
                          ? AppColors.onPrimary
                          : AppColors.onBackgroundSecondary,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    filter.label,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isActive
                          ? AppColors.onPrimary
                          : AppColors.onBackgroundSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
