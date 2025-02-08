import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_of_ohara/application/components/input.dart';

void main() {
  group('Test para comprobar si funcionan los TextFromField (Importante)', () {
    late TextEditingController controlador;

    setUp(() {
      controlador = TextEditingController();
    });

    testWidgets('Muestra el formulario (Importante)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Input(
              controlador: controlador,
              etiqueta: 'Nombre',
              validacion: (value) =>
                  value == null || value.isEmpty ? 'Campo requerido' : null,
            ),
          ),
        ),
      );

      expect(find.text('Nombre'), findsOneWidget);
    });

    testWidgets('Permite escribir texto (Importante)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Input(
              controlador: controlador,
              etiqueta: 'Nombre',
              validacion: (value) =>
                  value == null || value.isEmpty ? 'Campo requerido' : null,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'John Doe');
      expect(controlador.text, 'John Doe');
    });

    testWidgets('Muestra error de validación (Importante)', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Input(
                controlador: controlador,
                etiqueta: 'Nombre',
                validacion: (value) =>
                    value == null || value.isEmpty ? 'Campo requerido' : null,
              ),
            ),
          ),
        ),
      );

      // Simular validación
      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Campo requerido'), findsOneWidget);
    });
  });
}
