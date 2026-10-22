import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tabib_app/core/cache_helper/cached_user_role.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import '../../widgets/doc/complete_doc_profile_step_one.dart';
import '../../widgets/doc/complete_doc_profile_step_two.dart';

class CompleteDocProfileView extends StatefulWidget {
  const CompleteDocProfileView({super.key});

  @override
  State<CompleteDocProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteDocProfileView> {
  late PageController _pageController;
  late final List<Widget> completesProfileSteps;

  @override
  void initState() {
    _pageController = PageController();
    completesProfileSteps = [
      CompleteDocProfileStepOne(pageController: _pageController),
      const CompleteDocProfileStepTwo(),
    ];
    super.initState();
  }

  void _goToHome() {
    CachedUserRole.uiRole = 'doctor';
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.mainLayoutView,
      (route) => false,
      arguments: 'doctor',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: _goToHome,
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'auth.completeProfile.skip'.tr(),
                    textAlign: TextAlign.start,
                    style: theme.bold18.copyWith(
                      fontSize: 16,
                      color: theme.textColor200,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SmoothPageIndicator(
                controller: _pageController,
                count: 2,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotColor: theme.primaryColor300,
                  activeDotColor: theme.primaryColor,
                ),
                onDotClicked: (index) {},
              ),
              const SizedBox(height: 24),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: completesProfileSteps.length,
                  itemBuilder: (context, index) {
                    return completesProfileSteps[index];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
