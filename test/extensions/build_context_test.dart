import 'package:flutter_core/src/extensions/build_context.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  late BuildContext savedContext;

  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          savedContext = context;
          return child;
        },
      ),
    );
  }

  group('BuildContextExtension', () {
    testWidgets('mediaQuery properties', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(const SizedBox()));

      expect(savedContext.mediaQuery, isA<MediaQueryData>());
      expect(savedContext.mediaPadding, isA<EdgeInsets>());
    });

    testWidgets('theme properties', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(const SizedBox()));

      expect(savedContext.theme, isA<ThemeData>());
      expect(savedContext.colorScheme, isA<ColorScheme>());
      expect(savedContext.textTheme, isA<TextTheme>());
    });

    testWidgets('orientation property', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(const SizedBox()));

      expect(savedContext.orientation, isA<Orientation>());
    });

    testWidgets('screen size properties', (WidgetTester tester) async {
      const testWidth = 800.0;
      const testHeight = 600.0;

      await tester.binding.setSurfaceSize(const Size(testWidth, testHeight));
      await tester.pumpWidget(buildTestWidget(const SizedBox()));

      expect(savedContext.mediaSize, const Size(testWidth, testHeight));
      expect(savedContext.screenWidth, testWidth);
      expect(savedContext.screenHeight, testHeight);
    });

    testWidgets('focus scope properties', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(const SizedBox()));

      expect(savedContext.focusScope, isA<FocusScopeNode>());
    });

    //   testWidgets('dismissKeyboard unfocuses when not primary focus',
    //       (WidgetTester tester) async {
    //     final focusNode = FocusNode();

    //     await tester.pumpWidget(
    //       buildTestWidget(
    //         TextField(focusNode: focusNode),
    //       ),
    //     );

    //     focusNode.requestFocus();
    //     await tester.pump();
    //     expect(focusNode.hasFocus, isTrue);

    //     savedContext.dismissKeyboard();
    //     await tester.pump();
    //     expect(focusNode.hasFocus, isFalse);

    //     focusNode.dispose();
    //   });

    //   testWidgets('dismissKeyboard does nothing when has primary focus',
    //       (WidgetTester tester) async {
    //     final focusNode = FocusNode();

    //     await tester.pumpWidget(
    //       buildTestWidget(
    //         TextField(focusNode: focusNode),
    //       ),
    //     );

    //     // Simulate primary focus
    //     focusNode.requestFocus();
    //     await tester.pump();

    //     // Mock primary focus
    //     FocusScope.of(savedContext).setFirstFocus(FocusScopeNode());

    //     savedContext.dismissKeyboard();
    //     await tester.pump();

    //     expect(focusNode.hasFocus, isTrue);

    //     focusNode.dispose();
    //   });
  });
}
