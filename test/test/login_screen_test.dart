import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps/test/login_screen.dart';

void main() {
testWidgets("test behaviour", (WidgetTester tester)async{
  await tester.pumpWidget(MaterialApp(home:LoginScreen() ,));
  await tester.tap(find.byKey(Key("login")));
  await tester.enterText(find.bySemanticsLabel("Email"), "invalid-email");
});
}