import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/strings/app_strings.dart';
import '../../../config/theme/app_colors.dart';
import '../../../domain/models/property.dart';

class PropertyCard extends StatefulWidget {
  final Property property;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onPhoneTap;
  final bool isBookmarked;

  const PropertyCard({
    super.key,
    required this.property,
    this.onTap,
    this.onBookmarkTap,
    this.onPhoneTap,
    this.isBookmarked = false,
  });

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with bookmark
                _buildImage(),
                // Info
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.property.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppStrings.brokerageLabel(widget.property.brokeragePercent.toInt()),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppColors.onBackgroundSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Bottom row: phone + price + book now
                      Row(
                        children: [
                          // Phone button
                          GestureDetector(
                            onTap: widget.onPhoneTap,
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.onBackgroundSecondary
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                              child: const Icon(
                                Icons.phone_outlined,
                                color: AppColors.onSurface,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Price
                          Expanded(
                            child: Text(
                              AppStrings.priceLabel(widget.property.rentPrice.toStringAsFixed(0)),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          // Book Now button
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppStrings.bookNow,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.onPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: 16,
                                    color: AppColors.onPrimary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        // Hero image
        Hero(
          tag: 'property-image-${widget.property.id}',
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: CachedNetworkImage(
                imageUrl: widget.property.imageUrls.first,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(
                  color: AppColors.shimmer,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                errorWidget: (_, _, _) => Container(
                  color: AppColors.shimmer,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: AppColors.onBackgroundSecondary,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Bookmark button
        Positioned(
          top: 12,
          right: 12,
          child: GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              widget.onBookmarkTap?.call();
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.isBookmarked
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: AppColors.onPrimary,
                size: 20,
              ),
            ),
          ),
        ),
        // Location badge
        Positioned(
          bottom: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.background.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primary,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  '${widget.property.city}, ${widget.property.state}',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onBackground,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
