import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/utils/doctor_withdraw_args.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/view_model/doctor_withdraw_state.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/view_model/doctor_withdraw_view_model.dart';

class DoctorWithdrawForm extends StatefulWidget {
  final DoctorWithdrawArgs args;

  const DoctorWithdrawForm({super.key, required this.args});

  @override
  State<DoctorWithdrawForm> createState() => _DoctorWithdrawFormState();
}

class _DoctorWithdrawFormState extends State<DoctorWithdrawForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _amountController;
  late final TextEditingController _ibanController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _ibanController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _ibanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final args = widget.args;
    final available =
        NumberFormat('#,##0.##').format(args.availableBalance);
    final min = NumberFormat('#,##0.##').format(args.minimumWithdrawal);

    return BlocBuilder<DoctorWithdrawViewModel, DoctorWithdrawState>(
      buildWhen: (p, c) => p.submitState.isLoading != c.submitState.isLoading,
      builder: (context, state) {
        final isLoading = state.submitState.isLoading;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'wallet.doctor.availableHint'.tr(
                    namedArgs: {
                      'amount': available,
                      'currency': args.currency,
                    },
                  ),
                  style: theme.regular14.copyWith(color: theme.textColor300),
                ),
                const SizedBox(height: 4),
                Text(
                  'wallet.doctor.minimumWithdrawalHint'.tr(
                    namedArgs: {
                      'amount': min,
                      'currency': args.currency,
                    },
                  ),
                  style: theme.regular12.copyWith(color: theme.textColor200),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _amountController,
                  hintText: 'wallet.doctor.amount'.tr(),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'wallet.doctor.amountRequired'.tr();
                    }
                    final parsed = double.tryParse(value.trim());
                    if (parsed == null || parsed <= 0) {
                      return 'wallet.doctor.amountInvalid'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _ibanController,
                  hintText: 'wallet.doctor.iban'.tr(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'wallet.doctor.ibanRequired'.tr();
                    }
                    if (value.trim().length < 8) {
                      return 'wallet.doctor.ibanInvalid'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onSubmit,
                    child: isLoading
                        ? SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: theme.whiteColor,
                            ),
                          )
                        : Text('wallet.doctor.submitWithdraw'.tr()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final args = widget.args;
    final amount = double.parse(_amountController.text.trim());
    context.read<DoctorWithdrawViewModel>().submit(
          amount: amount,
          iban: _ibanController.text,
          availableBalance: args.availableBalance,
          minimumWithdrawal: args.minimumWithdrawal,
          canWithdraw: args.canWithdraw,
        );
  }
}
