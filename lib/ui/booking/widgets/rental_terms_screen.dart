import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../config/strings/app_strings.dart';
import '../../../config/theme/app_colors.dart';
import '../../../data/repositories/contract_repository.dart';
import '../../../data/repositories/property_repository.dart';
import '../view_models/rental_view_model.dart';

class RentalTermsScreen extends StatelessWidget {
  final String propertyId;

  const RentalTermsScreen({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final vm = RentalViewModel(context.read<ContractRepository>());
        // Carrega o imóvel
        context.read<PropertyRepository>().getPropertyById(propertyId).then((p) {
          if (p != null) vm.setProperty(p);
        });
        return vm;
      },
      child: _RentalTermsBody(propertyId: propertyId),
    );
  }
}

class _RentalTermsBody extends StatelessWidget {
  final String propertyId;

  const _RentalTermsBody({required this.propertyId});

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

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          AppStrings.rentalTerms,
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
            // Resumo do imóvel
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.home_outlined, color: AppColors.primary, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.title,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.onBackground,
                          ),
                        ),
                        Text(
                          '${property.address}, ${property.city}',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.onBackgroundSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Duração do contrato
            Text(
              AppStrings.contractDuration,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [12, 24, 36].map((months) {
                final isSelected = vm.durationMonths == months;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text('$months meses'),
                      selected: isSelected,
                      onSelected: (_) => vm.setDuration(months),
                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.surface,
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? AppColors.onPrimary
                            : AppColors.onBackgroundSecondary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.divider,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Valores
            Text(
              AppStrings.financialSummary,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
            ),
            const SizedBox(height: 12),
            _ValueRow(
              label: AppStrings.monthlyRent,
              value: AppStrings.priceLabel(
                property.rentPrice.toStringAsFixed(0),
              ),
            ),
            _ValueRow(
              label: AppStrings.securityDeposit,
              value: AppStrings.priceLabel(
                vm.depositAmount.toStringAsFixed(0),
              ),
            ),
            const Divider(color: AppColors.divider, height: 24),
            _ValueRow(
              label: AppStrings.totalFirstPayment,
              value: AppStrings.priceLabel(
                vm.totalFirstPayment.toStringAsFixed(0),
              ),
              isBold: true,
            ),
            _ValueRow(
              label: AppStrings.brokerage,
              value: '${property.brokeragePercent.toInt()}%',
            ),

            const SizedBox(height: 24),

            // Proteção jurídica
            if (property.hasLegalSupport)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.gavel, color: AppColors.primary, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        AppStrings.legalProtectionIncluded,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // Termos
            Text(
              AppStrings.termsAndConditions,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                AppStrings.termsText,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.onBackgroundSecondary,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: vm.agreedToTerms,
                  onChanged: (_) => vm.toggleTermsAgreement(),
                  activeColor: AppColors.primary,
                ),
                Expanded(
                  child: Text(
                    AppStrings.agreeToTerms,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.onBackground,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
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
          onPressed: vm.agreedToTerms
              ? () => context.push('/reservation/$propertyId')
              : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            disabledBackgroundColor: AppColors.divider,
          ),
          child: Text(
            AppStrings.continueToReservation,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: vm.agreedToTerms
                  ? AppColors.onPrimary
                  : AppColors.onBackgroundSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _ValueRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _ValueRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
              color: AppColors.onBackgroundSecondary,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: isBold ? AppColors.primary : AppColors.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
