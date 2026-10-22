import 'package:tabib_app/features/doctor_flow/wallet/data/models/response/doctor_wallet_response.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/response/wallet_transactions_response.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/response/wallet_withdrawal_details_response.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/response/wallet_withdrawals_response.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/doctor_wallet_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_page_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_transaction_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_withdrawal_details_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_withdrawal_entity.dart';

extension DoctorWalletDataResponseMapper on DoctorWalletDataResponse {
  DoctorWalletEntity toEntity() {
    return DoctorWalletEntity(
      id: id ?? '',
      currency: currency ?? '',
      availableBalance: availableBalance?.toDouble() ?? 0,
      pendingBalance: pendingBalance?.toDouble() ?? 0,
      heldBalance: heldBalance?.toDouble() ?? 0,
      paidOutBalance: paidOutBalance?.toDouble() ?? 0,
      totalEarned: totalEarned?.toDouble() ?? 0,
      minimumWithdrawal: minimumWithdrawal?.toDouble() ?? 0,
      canWithdraw: canWithdraw ?? false,
    );
  }
}

extension WalletTransactionItemResponseMapper on WalletTransactionItemResponse {
  WalletTransactionEntity toEntity() {
    return WalletTransactionEntity(
      id: id ?? '',
      type: type ?? '',
      amount: amount?.toDouble() ?? 0,
      currency: currency ?? '',
      paymentId: paymentId,
      withdrawalId: withdrawalId,
      note: note,
      metadata: metadata,
      createdAt: createdAt,
    );
  }
}

extension WalletTransactionsResponseMapper on WalletTransactionsResponse {
  WalletPageEntity<WalletTransactionEntity> toEntity() {
    return WalletPageEntity(
      items: data?.map((item) => item.toEntity()).toList() ?? const [],
      page: meta?.page ?? 1,
      limit: meta?.limit ?? 20,
      total: meta?.total ?? 0,
      totalPages: meta?.totalPages ?? 1,
    );
  }
}

extension WalletWithdrawalItemResponseMapper on WalletWithdrawalItemResponse {
  WalletWithdrawalEntity toEntity() {
    final details = paymentMethodDetails;
    return WalletWithdrawalEntity(
      id: id ?? '',
      amount: amount?.toDouble() ?? 0,
      currency: currency ?? '',
      status: status ?? '',
      paymentMethodType: paymentMethodType ?? '',
      iban: details?['iban']?.toString(),
      bankName: details?['bankName']?.toString(),
      rejectionReason: rejectionReason,
      transferReference: transferReference,
      reviewedAt: reviewedAt,
      completedAt: completedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension WalletWithdrawalsResponseMapper on WalletWithdrawalsResponse {
  WalletPageEntity<WalletWithdrawalEntity> toEntity() {
    return WalletPageEntity(
      items: data?.map((item) => item.toEntity()).toList() ?? const [],
      page: meta?.page ?? 1,
      limit: meta?.limit ?? 20,
      total: meta?.total ?? 0,
      totalPages: meta?.totalPages ?? 1,
    );
  }
}

extension WalletWithdrawalDetailsDataResponseMapper
    on WalletWithdrawalDetailsDataResponse {
  WalletWithdrawalDetailsEntity toEntity() {
    final details = paymentMethodDetails;
    final withdrawal = WalletWithdrawalEntity(
      id: id ?? '',
      amount: amount?.toDouble() ?? 0,
      currency: currency ?? '',
      status: status ?? '',
      paymentMethodType: paymentMethodType ?? '',
      iban: details?['iban']?.toString(),
      bankName: details?['bankName']?.toString(),
      rejectionReason: rejectionReason,
      transferReference: transferReference,
      reviewedAt: reviewedAt,
      completedAt: completedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
    return WalletWithdrawalDetailsEntity(
      withdrawal: withdrawal,
      transactions: transactions
              ?.map(
                (tx) => WithdrawalRelatedTransactionEntity(
                  id: tx.id ?? '',
                  type: tx.type ?? '',
                  amount: tx.amount?.toDouble() ?? 0,
                  createdAt: tx.createdAt,
                ),
              )
              .toList() ??
          const [],
    );
  }
}
