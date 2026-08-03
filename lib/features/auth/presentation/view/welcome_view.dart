import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/auth/presentation/view_model/auth_constants.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 60,
                    child: CustomImageView(imagePath: AssetsManager.alba),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 193),
                        CustomImageView(imagePath: AssetsManager.logo),
                        const SizedBox(height: 36),
                        Text(
                          "auth.welcome.title".tr(),
                          style: theme.medium20.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Text(
                            "auth.welcome.description".tr(),
                            textAlign: TextAlign.center,
                            style: theme.medium16.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.textColor300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.roleView,
                      arguments: {'mode': AuthMode.login},
                    );
                  },
                  child: Text("auth.welcome.loginButton".tr()),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.roleView,
                      arguments: {'mode': AuthMode.signup},
                    );
                  },
                  child: Text("auth.welcome.createAccountButton".tr()),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("auth.welcome.continueAsGuestButton".tr()),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
