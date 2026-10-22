import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_withdrawal_details_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_withdrawal_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/view_model/doctor_withdrawal_details_view_model.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/doctor_withdrawal_info_row.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/doctor_withdrawal_related_tx_tile.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/wallet_status_chip.dart';

class DoctorWithdrawalDetailsContent extends StatelessWidget {
  final WalletWithdrawalDetailsEntity data;
  final bool isCancelling;

  const DoctorWithdrawalDetailsContent({
    super.key,
    required this.data,
    required this.isCancelling,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final w = data.withdrawal;
    final amount = NumberFormat('#,##0.##').format(w.amount);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '$amount ${w.currency}',
                style: theme.bold24.copyWith(color: theme.textColor600),
              ),
            ),
            WalletStatusChip(status: w.status),
          ],
        ),
        const SizedBox(height: 16),
        DoctorWithdrawalInfoRow(
          label: 'wallet.doctor.iban'.tr(),
          value: w.iban ?? '—',
        ),
        if (w.rejectionReason != null && w.rejectionReason!.isNotEmpty)
          DoctorWithdrawalInfoRow(
            label: 'wallet.doctor.rejectionReason'.tr(),
            value: w.rejectionReason!,
          ),
        if (w.transferReference != null && w.transferReference!.isNotEmpty)
          DoctorWithdrawalInfoRow(
            label: 'wallet.doctor.transferReference'.tr(),
            value: w.transferReference!,
          ),
        DoctorWithdrawalInfoRow(
          label: 'wallet.doctor.createdAt'.tr(),
          value: _formatDate(w.createdAt) ?? '—',
        ),
        const SizedBox(height: 20),
        Text(
          'wallet.doctor.relatedTransactions'.tr(),
          style: theme.medium16.copyWith(color: theme.textColor600),
        ),
        const SizedBox(height: 12),
        if (data.transactions.isEmpty)
          Text(
            'wallet.doctor.emptyTransactions'.tr(),
            style: theme.regular14.copyWith(color: theme.textColor300),
          )
        else
          ...data.transactions.map(
            (tx) => DoctorWithdrawalRelatedTxTile(tx: tx),
          ),
        if (w.canCancel) ...[
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed:
                  isCancelling ? null : () => _confirmCancel(context, w),
              child: isCancelling
                  ? SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.primaryColor,
                      ),
                    )
                  : Text('wallet.doctor.cancelWithdrawal'.tr()),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _confirmCancel(
    BuildContext context,
    WalletWithdrawalEntity withdrawal,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final theme = ctx.appTheme;
        return AlertDialog(
          title: Text(
            'wallet.doctor.cancelWithdrawal'.tr(),
            style: theme.bold18.copyWith(color: theme.textColor600),
          ),
          content: Text(
            'wallet.doctor.cancelConfirm'.tr(),
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text('common.no'.tr()),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text('common.yes'.tr()),
            ),
          ],
        );
      },
    );
    if (confirmed == true && context.mounted) {
      context.read<DoctorWithdrawalDetailsViewModel>().cancel(withdrawal.id);
    }
  }

  String? _formatDate(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    return DateFormat('dd MMM yyyy · HH:mm').format(parsed.toLocal());
  }
}
