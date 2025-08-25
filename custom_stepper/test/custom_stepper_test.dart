import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:custom_stepper/custom_stepper.dart';

void main() {
  group('CustomStepper Widget Test', () {
    testWidgets('renders correct number of steps', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomStepper(
              totalSteps: 3,
              currentStep: 1,
              labels: ["Cart", "Billing", "Shipping"],
              type: CustomStepperType.circle,
            ),
          ),
        ),
      );

      // ✅ Harus ada label sesuai jumlah step
      expect(find.text("Cart"), findsOneWidget);
      expect(find.text("Billing"), findsOneWidget);
      expect(find.text("Shipping"), findsOneWidget);
    });

    testWidgets('shows current active step correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomStepper(
              totalSteps: 3,
              currentStep: 2,
              labels: ["Cart", "Billing", "Shipping"],
              type: CustomStepperType.circle,
            ),
          ),
        ),
      );

      // ✅ Pastikan step aktif (1 & 2) terisi warna active
      final activeCircles = find.byWidgetPredicate((widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == Colors.green);

      expect(activeCircles, findsNWidgets(2)); // Step 1 dan Step 2 aktif
    });

    testWidgets('progress bar works with current step',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomStepper(
              totalSteps: 3,
              currentStep: 2,
              labels: ["Cart", "Billing", "Shipping"],
              type: CustomStepperType.bar,
            ),
          ),
        ),
      );

      // ✅ Cari LinearProgressIndicator
      final progress = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );

      // Harus sesuai dengan (currentStep / totalSteps)
      expect(progress.value, equals(2 / 3));
    });
  });
}
