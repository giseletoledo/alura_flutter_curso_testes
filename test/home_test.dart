import 'package:estilizacao_componentes/data/bank_inherited.dart';
import 'package:estilizacao_componentes/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets('My widget has a text "Spent" ', (widgetTester) async{
    await widgetTester.pumpWidget(MaterialApp(
        home: BankInherited(
            child: Home()
        ),
       ));
    final spentFinder = find.text('Spent');
    expect(spentFinder, findsOneWidget);
  });
}