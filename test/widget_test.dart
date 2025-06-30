// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// 1. CORREÇÃO: Importe o arquivo 'app.dart' onde NuntiusApp está definido.
// Certifique-se de que 'nuntius_app' é o nome exato do seu pacote no pubspec.yaml.
import 'package:nuntius/app.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // 2. CORREÇÃO: Use NuntiusApp em vez de MyApp.
    await tester.pumpWidget(const NuntiusApp());

    // Verify that our counter starts at 0.
    // Estes são testes padrão para um contador.
    // Se o seu aplicativo Nuntius não tem um contador, você pode remover ou adaptar estas linhas.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
