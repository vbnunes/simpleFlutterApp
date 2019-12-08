import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alcool ou gasolina',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Álcool ou gasolina'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController valorGasolina = new TextEditingController();
    TextEditingController valorAlcool = new TextEditingController();
  String _valeOuNao = "Qual vale mais?";

  void _cleanUp() {
    //Limpa os testes de cada um dos campos 
    valorGasolina.text = "";
    valorAlcool.text = "";
    //Limpa o foco do app
    FocusScope.of(context).requestFocus(new FocusNode());
    //
    setState(() {_valeOuNao = "Qual vale mais?";});
  }

  void _calculate(){
    if(valorGasolina.text == "" || valorAlcool.text == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Faltando Valores"),
            content: new Text("É necessário preencher todos os valores para continuar com os cálculos"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
    );
    } else {
      var gasolina = double.parse(valorGasolina.text);
      var alcool = double.parse(valorAlcool.text);

      var valorTotal = alcool / gasolina;
      
      setState(() {_valeOuNao = valorTotal > 0.7 ? 'Gasolina' : 'Alcool';});
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$_valeOuNao',
              style: Theme.of(context)
              .textTheme
              .display1
              .copyWith(color: Colors.black)
            ),
            Container(
              constraints: BoxConstraints.expand(
                height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 100.0,
              ),
              padding: const EdgeInsets.only(left: 40.0, right: 20.0),
              alignment: Alignment.center,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Entre com os valores da gasolina e dop alcool:',
                    ),
                    TextField(
                      controller: valorGasolina,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Valor gasolina:',
                      ),
                    ),
                    TextField(
                      controller: valorAlcool,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Valor Alcool:',
                      ),
                    )
                  ],
                ),
              )
            ),
              const SizedBox(height: 30),
              CupertinoButton(
                color: Colors.blue,
                onPressed: _calculate,
                child: const Text(
                  'Calcular',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              CupertinoButton(
                color: Colors.blue,
                onPressed: _cleanUp,
                child: const Text(
                  'Limpar',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
