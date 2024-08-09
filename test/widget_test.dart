// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pharmaconnect_project/main.dart'; // Certifique-se de que o caminho para o main.dart está correto

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verifique se o widget básico está sendo renderizado.
    expect(find.text('Hello, world!'), findsOneWidget);
  });
}
