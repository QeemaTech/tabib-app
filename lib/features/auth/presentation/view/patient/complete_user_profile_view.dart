import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/auth/presentation/view_model/patient/complete_patient_profile_state.dart';
import 'package:tabib_app/features/auth/presentation/view_model/patient/complete_patient_profile_view_model.dart';
import '../../widgets/patient/complete_patient_profile_step_one.dart';
import '../../widgets/patient/complete_patient_profile_step_two.dart';

class CompleteUserProfileView extends StatefulWidget {
  const CompleteUserProfileView({super.key});

  @override
  State<CompleteUserProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteUserProfileView> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    completesProfileSteps = [
      CompletePatientProfileStepOne(pageController: _pageController),
      CompletepatientProfileStepTwo(),
    ];

    super.initState();
  }

  late final List<Widget> completesProfileSteps;
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocBuilder<CompletePatientProfileViewModel, CompletePatientProfileState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.mainLayoutView,
                        (route) => false,
                      );
                    },
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
                  SizedBox(height: 40),
                  SmoothPageIndicator(
                    controller: _pageController, // PageController
                    count: 2,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotColor: theme.primaryColor300,
                      activeDotColor: theme.primaryColor,
                    ),
                    onDotClicked: (index) {},
                  ),
                  SizedBox(height: 24),

                  Text(
                    'auth.completePatientProfile.title'.tr(),
                    style: theme.bold24.copyWith(
                      fontSize: 20,
                      color: theme.textColor600,
                    ),
                  ),
                  Text(
                    'auth.completePatientProfile.description'.tr(),
                    style: theme.medium16.copyWith(
                      fontSize: 18,
                      color: theme.textColor300,
                    ),
                  ),

                  SizedBox(height: 20),

                  Expanded(
                    child: PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (value) {
                        context
                            .read<CompletePatientProfileViewModel>()
                            .updateCurrentStep(value);
                      },
                      itemCount: completesProfileSteps.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: completesProfileSteps[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
