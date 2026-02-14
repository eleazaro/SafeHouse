/// Status do contrato seguindo a máquina de estados:
/// ANÚNCIO → RESERVA → CONTRATO_ASSINADO → ENTREGA_CHAVES → LOCAÇÃO_ATIVA → ENCERRAMENTO
/// Com possibilidade de INADIMPLENTE a partir de LOCAÇÃO_ATIVA.
enum ContractStatus {
  anuncio,
  reserva,
  contratoAssinado,
  entregaChaves,
  locacaoAtiva,
  inadimplente,
  encerramento,
}

class Contract {
  final String id;
  final String propertyId;
  final String tenantId;
  final String ownerId;
  final ContractStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final double monthlyRent;
  final double deposit;
  final double brokeragePercent;
  final DateTime createdAt;

  const Contract({
    required this.id,
    required this.propertyId,
    required this.tenantId,
    required this.ownerId,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.monthlyRent,
    required this.deposit,
    required this.brokeragePercent,
    required this.createdAt,
  });

  Contract copyWith({
    String? id,
    String? propertyId,
    String? tenantId,
    String? ownerId,
    ContractStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    double? monthlyRent,
    double? deposit,
    double? brokeragePercent,
    DateTime? createdAt,
  }) {
    return Contract(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      tenantId: tenantId ?? this.tenantId,
      ownerId: ownerId ?? this.ownerId,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      monthlyRent: monthlyRent ?? this.monthlyRent,
      deposit: deposit ?? this.deposit,
      brokeragePercent: brokeragePercent ?? this.brokeragePercent,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Transições válidas na máquina de estados.
  static const Map<ContractStatus, List<ContractStatus>> _transitions = {
    ContractStatus.anuncio: [ContractStatus.reserva],
    ContractStatus.reserva: [ContractStatus.contratoAssinado, ContractStatus.anuncio],
    ContractStatus.contratoAssinado: [ContractStatus.entregaChaves],
    ContractStatus.entregaChaves: [ContractStatus.locacaoAtiva],
    ContractStatus.locacaoAtiva: [ContractStatus.inadimplente, ContractStatus.encerramento],
    ContractStatus.inadimplente: [ContractStatus.locacaoAtiva, ContractStatus.encerramento],
    ContractStatus.encerramento: [],
  };

  /// Verifica se a transição de status é válida.
  bool canTransitionTo(ContractStatus newStatus) {
    return _transitions[status]?.contains(newStatus) ?? false;
  }
}
