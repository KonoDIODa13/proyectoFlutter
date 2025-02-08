import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:library_of_ohara/application/components/input.dart';
import 'package:library_of_ohara/application/views/register.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Registro de usuario - Pruebas de integración', () {
    testWidgets('Debe mostrar errores si los campos están vacíos',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Register()));

      // Pulsar el botón de "Crear Cuenta" sin rellenar los campos
      await tester.tap(find.text('Crear Cuenta'));
      await tester.pump();

      // Verificar que aparecen los errores de validación
      expect(find.text('Por favor, ingresa tu nombre.'), findsOneWidget);
      expect(find.text('Por favor, ingresa tu contraseña.'), findsOneWidget);
      expect(find.text('Por favor, ingresa tu correo electrónico.'),
          findsOneWidget);
    });
// este test, no he conseguido que funcionara.
    testWidgets('Debe registrar usuario y navegar a UserPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Register()));

      // Encontrar los campos de texto
      final nombreField = find.widgetWithText(TextFormField, "Nombre:");
      final contrasenaField = find.widgetWithText(TextFormField, "Contraseña:");
      final gmailField =
          find.widgetWithText(TextFormField, "Correo Electrónico:");

      // Escribir en los campos de entrada
      await tester.enterText(nombreField, "TestUser");
      await tester.enterText(contrasenaField, "123456");
      await tester.enterText(gmailField, "test@example.com");

      // Pulsar el botón "Crear Cuenta"
      await tester.tap(find.text("Crear Cuenta"));
      await tester.pumpAndSettle();

      // Verificar que navega a UserPage
      expect(find.text("Tus Libros"), findsOneWidget);
    });

    testWidgets('Debe navegar a la pantalla de Login',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Register()));

      // Pulsar en el enlace "Login"
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verificar que navega a Login
      expect(find.text("Login"), findsOneWidget);
    });

    testWidgets('Debe volver a la pantalla de inicio',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Register()));

      // Pulsar el botón flotante de volver
      await tester.tap(find.byIcon(Icons.keyboard_double_arrow_left));
      await tester.pumpAndSettle();

      // Verificar que navega a InitApp
      expect(find.text("Crear una Cuenta"), findsOneWidget);
    });
  });
}
