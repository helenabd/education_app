import 'package:education_app/core/core.dart';
import 'package:education_app/src/onboarding/domain/domain.dart';
import 'package:education_app/src/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();

  @override
  void initState() {
    context.read<OnboardingCubit>().checkIfUserIsFirstTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: BlocConsumer<OnboardingCubit, OnboardingState>(
          listener: (context, state) {
            if (state is OnboardingStatus && !state.isFirstTimer) {
              Navigator.of(context).pushReplacementNamed('/home');
            } else if (state is UserCached) {
              //TODO(@helenabd): Implement user cached logic
            }
          },
          builder: (context, state) {
            if (state is CheckingIfUserIsFirstTimer ||
                state is CachingFirstTimer) {
              return const LoadingView();
            } else if (state is OnboardingError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Stack(
                children: [
                  PageView(
                    controller: pageController,
                    children: [
                      OnboardingBody(pageContent: PageContent.first()),
                      OnboardingBody(pageContent: PageContent.second()),
                      OnboardingBody(pageContent: PageContent.third()),
                    ],
                  ),
                  Align(
                    alignment: const Alignment(0, 0.04),
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      onDotClicked: (index) {
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 40,
                        activeDotColor: Colours.primaryColor,
                        dotColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
