import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/auth/presentation/view_model/auth_constants.dart';
import 'package:tabib_app/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:tabib_app/features/auth/presentation/widgets/role_widget.dart';

class RoleView extends StatefulWidget {
  const RoleView({super.key});

  @override
  State<RoleView> createState() => _RoleViewState();
}

class _RoleViewState extends State<RoleView> {
  String _selectedRole = 'user';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      final mode = args is Map ? args['mode'] as String? : null;
      context.read<AuthViewModel>().setAuthMode(mode ?? AuthMode.login);
      context.read<AuthViewModel>().setRole(_selectedRole);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final args = ModalRoute.of(context)?.settings.arguments;
    final mode = args is Map
        ? (args['mode'] as String? ?? AuthMode.login)
        : AuthMode.login;
    final isLogin = mode == AuthMode.login;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PositionedDirectional(
              start: 0,
              top: 60,
              child: CustomImageView(imagePath: AssetsManager.alba),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 66),
                    Align(
                      alignment: Alignment.topCenter,
                      child: CustomImageView(imagePath: AssetsManager.logo),
                    ),
                    const SizedBox(height: 36),
                    Text(
                      "auth.role.title".tr(),
                      style: theme.medium20.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "auth.role.description".tr(),
                      style: theme.medium16.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.textColor300,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "auth.role.accountType".tr(),
                      style: theme.bold18.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RoleSelectionWidget(
                      onRoleChanged: (role) {
                        setState(() {
                          _selectedRole = role;
                        });
                        context.read<AuthViewModel>().setRole(role);
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final authViewModel = context.read<AuthViewModel>();
                          authViewModel.setAuthMode(mode);
                          authViewModel.setRole(_selectedRole);
                          Navigator.pushNamed(
                            context,
                            isLogin ? AppRoutes.loginView : AppRoutes.signUpView,
                            arguments: authViewModel,
                          );
                        },
                        child: Text(
                          isLogin
                              ? "auth.login.loginButton".tr()
                              : "auth.signUp.signUpButton".tr(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(child: _AuthSwitchLink(isLoginMode: isLogin)),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthSwitchLink extends StatelessWidget {
  const _AuthSwitchLink({required this.isLoginMode});

  final bool isLoginMode;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: isLoginMode
                ? 'auth.role.haveAccount'.tr()
                : 'auth.role.haveAccount'.tr(),
            style: theme.medium16,
          ),
          TextSpan(
            text: isLoginMode
                ? 'auth.signUp.signUpButton'.tr()
                : 'auth.login.loginButton'.tr(),
            style: theme.bold18.copyWith(
              color: theme.primaryColor,
              fontSize: 16,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.roleView,
                  arguments: {
                    'mode': isLoginMode ? AuthMode.signup : AuthMode.login,
                  },
                );
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
