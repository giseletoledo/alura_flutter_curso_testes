import 'package:estilizacao_componentes/components/box_card.dart';
import 'package:estilizacao_componentes/data/bank_http.mocks.dart';
import 'package:estilizacao_componentes/data/bank_inherited.dart';
import 'package:estilizacao_componentes/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main(){

  final MockBankHttp httpMock = MockBankHttp();

  testWidgets('My widget has a text "Spent" ', (widgetTester) async{
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('10'));
    //constrói a tela que será testada
    await widgetTester.pumpWidget(MaterialApp(
        home: BankInherited(
            child: Home(api: httpMock.dolarToReal())
        ),
       ));
    //busca o texto no widget
    final spentFinder = find.text('Spent');
    expect(spentFinder, findsOneWidget);
  });

  testWidgets('finds a LinearProgressIndicator', (widgetTester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('10'));
    await widgetTester.pumpWidget(MaterialApp(
      home: BankInherited(
          child: Home(api: httpMock.dolarToReal())
      ),
    ));
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  //Busca 5 BoxCards
  testWidgets('finds 5 BoxCards ', (widgetTester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('10'));
    await widgetTester.pumpWidget(MaterialApp(
      home: BankInherited(
          child: Home(api: httpMock.dolarToReal())
      ),
    ));
    expect(find.byWidgetPredicate((widget){
      if(widget is BoxCard){
        return true;
      } else  {
        return false;
      }
    }), findsNWidgets(5));
  });

  //Busca 5 BoxCards
  testWidgets('finds 5 BoxCards ', (widgetTester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('10'));
    await widgetTester.pumpWidget(MaterialApp(
      home: BankInherited(
          child: Home(api: httpMock.dolarToReal())
      ),
    ));
    expect(find.byWidgetPredicate((widget){
      if(widget is BoxCard){
        return true;
      } else  {
        return false;
      }
    }), findsNWidgets(5));
  });

  //desafio 1
  testWidgets('My widget has a text "Transfer" ', (widgetTester) async{
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('10'));
    //constrói a tela que será testada
    await widgetTester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: httpMock.dolarToReal()),//Inserir a API Mock, no app real é outra API
      ),
    ));
    //busca o texto no widget
    final transferFinder = find.text('Transfer');
    expect(transferFinder, findsOneWidget);
  });

  testWidgets('When tap Deposit should upload earned in 10', (tester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('10'));
    //constrói a tela que será testada
    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: httpMock.dolarToReal()),
      ),
    ));
    await tester.tap(find.text('Deposit'));//ao fazer o tap muda para 10
    await tester.tap(find.text('Earned'));

    await tester.pumpAndSettle();// obrigatório para atualizar a tela

    expect(find.text('\$10.0'), findsOneWidget);//verifica se tem o valor 10
  });

  //Teste de mock
  testWidgets('Testing MockHttp dolarToReal', (tester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5'));
    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: httpMock.dolarToReal()),
      ),
    ));
    verify(httpMock.dolarToReal()).called(7);//Só é 7 se rodar tudo, o main()
  });
}