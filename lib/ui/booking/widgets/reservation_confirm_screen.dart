import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../config/strings/app_strings.dart';
import '../../../config/theme/app_colors.dart';
import '../../../data/repositories/contract_repository.dart';
import '../../../data/repositories/property_repository.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../view_models/rental_view_model.dart';

class ReservationConfirmScreen extends StatelessWidget {
  final String propertyId;

  const ReservationConfirmScreen({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final vm = RentalViewModel(context.read<ContractRepository>());
        context.read<PropertyRepository>().getPropertyById(propertyId).then((p) {
          if (p != null) vm.setProperty(p);
        });
        return vm;
      },
      child: const _ReservationConfirmBody(),
    );
  }
}

class _ReservationConfirmBody extends StatelessWidget {
  const _ReservationConfirmBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RentalViewModel>();
    final property = vm.property;

    if (property == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    // Se já criou o contrato, mostra tela de sucesso
    if (vm.createdContract != null) {
      return _SuccessView(
        propertyTitle: property.title,
        onGoHome: () => context.go('/home'),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          AppStrings.confirmReservation,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: AppColors.onBackground,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: AppColors.onBackground,
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ícone de confirmação
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.home_work_outlined,
                  color: AppColors.primary,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                AppStrings.almostThere,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onBackground,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                AppStrings.reviewBeforeConfirm,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.onBackgroundSecondary,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Dados do imóvel
            _SummarySection(
              title: AppStrings.propertyLabel,
              items: [
                _SummaryItem(AppStrings.nameLabel, property.title),
                _SummaryItem(
                  AppStrings.addressLabel,
                  '${property.address}, ${property.city} - ${property.state}',
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Dados financeiros
            _SummarySection(
              title: AppStrings.financialSummary,
              items: [
                _SummaryItem(
                  AppStrings.monthlyRent,
                  AppStrings.priceLabel(property.rentPrice.toStringAsFixed(0)),
                ),
                _SummaryItem(
                  AppStrings.securityDeposit,
                  AppStrings.priceLabel(vm.depositAmount.toStringAsFixed(0)),
                ),
                _SummaryItem(
                  AppStrings.contractDuration,
                  '${vm.durationMonths} meses',
                ),
                _SummaryItem(
                  AppStrings.brokerage,
                  '${property.brokeragePercent.toInt()}%',
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (vm.error != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.error, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        vm.error!,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: ElevatedButton(
          onPressed: vm.isLoading
              ? null
              : () {
                  HapticFeedback.mediumImpact();
                  final auth = context.read<AuthViewModel>();
                  vm.confirmReservation(
                    tenantId: auth.currentUser?.id ?? '',
                  );
                },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
          ),
          child: vm.isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.onPrimary,
                  ),
                )
              : Text(
                  AppStrings.confirmAndReserve,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onPrimary,
                  ),
                ),
        ),
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  final String title;
  final List<_SummaryItem> items;

  const _SummarySection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.onBackground,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      item.label,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.onBackgroundSecondary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      item.value,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.onBackground,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem {
  final String label;
  final String value;
  const _SummaryItem(this.label, this.value);
}

class _SuccessView extends StatelessWidget {
  final String propertyTitle;
  final VoidCallback onGoHome;

  const _SuccessView({required this.propertyTitle, required this.onGoHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  color: AppColors.success,
                  size: 56,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.reservationSuccess,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onBackground,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.reservationSuccessMessage(propertyTitle),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.onBackgroundSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onGoHome,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 48),
                ),
                child: Text(
                  AppStrings.backToHome,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
