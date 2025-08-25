import 'package:antrian/pages/onboarding/onboarding_info.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
      title: "Welcome to Antrian Online",
      description: "Your digital queue management solution.",
      animation: "assets/animation/shield.json",
    ),
    OnboardingInfo(
      title: "Get Your Queue Number",
      description: "Get your queue number and wait for your turn without hassle.",
      animation: "assets/animation/queue.json",
    ),
    OnboardingInfo(
      title: "Monitor Your Queue",
      description: "Easily track your position in the queue and get a real-time updates.",
      animation: "assets/animation/monitoring.json",
    ),
  ];
}