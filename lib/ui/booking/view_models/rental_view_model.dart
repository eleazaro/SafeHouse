import 'package:flutter/foundation.dart';

import '../../../data/repositories/contract_repository.dart';
import '../../../domain/models/contract.dart';
import '../../../domain/models/property.dart';

class RentalViewModel extends ChangeNotifier {
  final ContractRepository _contractRepository;

  RentalViewModel(this._contractRepository);

  Property? _property;
  Property? get property => _property;

  bool _agreedToTerms = false;
  bool get agreedToTerms => _agreedToTerms;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Contract? _createdContract;
  Contract? get createdContract => _createdContract;

  int _durationMonths = 12;
  int get durationMonths => _durationMonths;

  void setProperty(Property property) {
    _property = property;
    notifyListeners();
  }

  void setDuration(int months) {
    _durationMonths = months;
    notifyListeners();
  }

  void toggleTermsAgreement() {
    _agreedToTerms = !_agreedToTerms;
    notifyListeners();
  }

  double get depositAmount => (_property?.rentPrice ?? 0) * 3;

  double get totalFirstPayment =>
      (_property?.rentPrice ?? 0) + depositAmount;

  Future<void> confirmReservation({
    required String tenantId,
  }) async {
    if (_property == null || !_agreedToTerms) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final now = DateTime.now();
      final contract = Contract(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        propertyId: _property!.id,
        tenantId: tenantId,
        ownerId: _property!.ownerId,
        status: ContractStatus.reserva,
        startDate: now.add(const Duration(days: 30)),
        endDate: now.add(Duration(days: 30 + _durationMonths * 30)),
        monthlyRent: _property!.rentPrice,
        deposit: depositAmount,
        brokeragePercent: _property!.brokeragePercent,
        createdAt: now,
      );

      _createdContract = await _contractRepository.createContract(contract);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Erro ao criar reserva. Tente novamente.';
      _isLoading = false;
      notifyListeners();
    }
  }
}
