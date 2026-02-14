import '../../domain/models/contract.dart';

/// Repositório de contratos. Na v1, usa dados mockados.
abstract class ContractRepository {
  Future<List<Contract>> getContractsByTenant(String tenantId);
  Future<List<Contract>> getContractsByOwner(String ownerId);
  Future<Contract?> getContractById(String id);
  Future<Contract> createContract(Contract contract);
  Future<Contract> updateStatus(String contractId, ContractStatus newStatus);
}

class MockContractRepository implements ContractRepository {
  final List<Contract> _contracts = [];

  @override
  Future<List<Contract>> getContractsByTenant(String tenantId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _contracts.where((c) => c.tenantId == tenantId).toList();
  }

  @override
  Future<List<Contract>> getContractsByOwner(String ownerId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _contracts.where((c) => c.ownerId == ownerId).toList();
  }

  @override
  Future<Contract?> getContractById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _contracts.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Contract> createContract(Contract contract) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _contracts.add(contract);
    return contract;
  }

  @override
  Future<Contract> updateStatus(
    String contractId,
    ContractStatus newStatus,
  ) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _contracts.indexWhere((c) => c.id == contractId);
    if (index == -1) throw Exception('Contrato não encontrado');

    final contract = _contracts[index];
    if (!contract.canTransitionTo(newStatus)) {
      throw Exception(
        'Transição inválida: ${contract.status.name} → ${newStatus.name}',
      );
    }

    final updated = contract.copyWith(status: newStatus);
    _contracts[index] = updated;
    return updated;
  }
}
