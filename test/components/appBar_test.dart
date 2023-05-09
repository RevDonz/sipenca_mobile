// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:sipenca_mobile/components/appBar.dart';

// void main() {
//   testWidgets("Tes", (widgetTester) async {
//     await widgetTester.pumpWidget(MaterialApp(
//       home: Container(child: AppBarSipenca(role: "Pengungsi")),
//     ));

//     final roleFinder = find.text("Pengungsi");

//     expect(roleFinder, findsOneWidget);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sipenca_mobile/components/appBar.dart';

void main() {
  testWidgets('AppBar should have a title', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: const AppBarSipenca(role: "asd"),
      ),
    ));

    final titleFinder = find.text('Test Title');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('AppBar should have a leading icon', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
        ),
      ),
    ));

    final iconFinder = find.byIcon(Icons.menu);
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('AppBar should have a trailing icon',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        ),
      ),
    ));

    final iconFinder = find.byIcon(Icons.search);
    expect(iconFinder, findsOneWidget);
  });
}
