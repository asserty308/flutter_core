import 'package:flutter/material.dart';
import 'package:flutter_core/src/extensions/widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ignore: sized_box_for_whitespace
  final testWidget = Container(width: 100, height: 100);

  group('WidgetExtension', () {
    testWidgets('centered adds Center widget', (tester) async {
      await tester.pumpWidget(testWidget.centered);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    group('padding tests', () {
      testWidgets('paddingAll adds uniform padding', (tester) async {
        await tester.pumpWidget(testWidget.paddingAll(16.0));
        final padding = tester.widget<Padding>(find.byType(Padding));
        expect(padding.padding, EdgeInsets.all(16.0));
      });

      testWidgets('paddingLTRB adds directional padding', (tester) async {
        await tester.pumpWidget(testWidget.paddingLTRB(1, 2, 3, 4));
        final padding = tester.widget<Padding>(find.byType(Padding));
        expect(padding.padding, EdgeInsets.fromLTRB(1, 2, 3, 4));
      });

      testWidgets('paddingOnly adds specific padding', (tester) async {
        await tester.pumpWidget(testWidget.paddingOnly(left: 10, bottom: 20));
        final padding = tester.widget<Padding>(find.byType(Padding));
        expect(padding.padding, EdgeInsets.only(left: 10, bottom: 20));
      });

      testWidgets('paddingHorizontal adds horizontal padding', (tester) async {
        await tester.pumpWidget(testWidget.paddingHorizontal(8.0));
        final padding = tester.widget<Padding>(find.byType(Padding));
        expect(padding.padding, EdgeInsets.symmetric(horizontal: 8.0));
      });

      testWidgets('paddingVertical adds vertical padding', (tester) async {
        await tester.pumpWidget(testWidget.paddingVertical(8.0));
        final padding = tester.widget<Padding>(find.byType(Padding));
        expect(padding.padding, EdgeInsets.symmetric(vertical: 8.0));
      });

      testWidgets('paddingSymmetric adds symmetric padding', (tester) async {
        await tester.pumpWidget(testWidget.paddingSymmetric(8.0, 16.0));
        final padding = tester.widget<Padding>(find.byType(Padding));
        expect(
          padding.padding,
          EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        );
      });
    });

    group('layout tests', () {
      testWidgets('expanded adds Expanded widget', (tester) async {
        await tester.pumpWidget(
          MaterialApp(home: Row(children: [testWidget.expanded])),
        );
        expect(find.byType(Expanded), findsOneWidget);
      });

      testWidgets('flexible adds Flexible widget', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Row(
              children: [testWidget.flexible(flex: 2, fit: FlexFit.tight)],
            ),
          ),
        );
        final flexible = tester.widget<Flexible>(find.byType(Flexible));
        expect(flexible.flex, 2);
        expect(flexible.fit, FlexFit.tight);
      });
    });

    group('decoration tests', () {
      testWidgets('withTooltip adds Tooltip when message provided', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(home: testWidget.withTooltip('Test tooltip')),
        );
        expect(find.byType(Tooltip), findsOneWidget);
        final tooltip = tester.widget<Tooltip>(find.byType(Tooltip));
        expect(tooltip.message, 'Test tooltip');
      });

      testWidgets('withTooltip returns original widget when message is null', (
        tester,
      ) async {
        await tester.pumpWidget(testWidget.withTooltip(null));
        expect(find.byType(Tooltip), findsNothing);
      });

      testWidgets('clip adds ClipRRect', (tester) async {
        await tester.pumpWidget(testWidget.clip);
        expect(find.byType(ClipRRect), findsOneWidget);
      });
    });

    group('size tests', () {
      testWidgets('toSize sets width and height', (tester) async {
        await tester.pumpWidget(testWidget.toSize(50, 60));
        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 50);
        expect(sizedBox.height, 60);
      });

      testWidgets('toWidth sets only width', (tester) async {
        await tester.pumpWidget(testWidget.toWidth(50));
        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 50);
        expect(sizedBox.height, null);
      });

      testWidgets('toHeight sets only height', (tester) async {
        await tester.pumpWidget(testWidget.toHeight(60));
        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, null);
        expect(sizedBox.height, 60);
      });
    });
  });
}
