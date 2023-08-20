import 'package:flutter/material.dart';
import 'package:testeee/components/rounded_input_field.dart';

import 'consts.dart';

void main() {
  runApp(const MyApp());
}

class IMC {
  String nome;
  double age;
  double peso;
  double altura;

  IMC(this.nome, this.age, this.peso, this.altura);

  double calcularIMC() {
    return peso / (altura * altura);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<IMC> imcList = [];

  TextEditingController nomeController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  void _calcularIMC() {
    String nome = nomeController.text;
    double age = double.tryParse(ageController.text) ?? 0;
    double peso = double.tryParse(pesoController.text) ?? 0;
    double altura = double.tryParse(alturaController.text) ?? 0;
    altura = altura / 100;
    IMC imc = IMC(nome, age, peso, altura);
    double valorIMC = imc.calcularIMC();

    String mensagem;

    if (valorIMC < 16) {
      mensagem =
          'Você está com índice de magreza grave. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else if (valorIMC >= 16 && valorIMC < 17) {
      mensagem =
          'Você está com índice de magreza moderada. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else if (valorIMC >= 17 && valorIMC < 18.5) {
      mensagem =
          'Você está com índice de magreza leve. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else if (valorIMC >= 18.5 && valorIMC < 25) {
      mensagem =
          'Você está com índice de peso saudável. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else if (valorIMC >= 25 && valorIMC < 30) {
      mensagem =
          'Você está com sobrepeso. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else if (valorIMC >= 30 && valorIMC < 35) {
      mensagem =
          'Você está com obesidade grau I. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else if (valorIMC >= 35 && valorIMC < 40) {
      mensagem =
          'Você está com obesidade grau II. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else {
      mensagem =
          'Você está com obesidade grau III. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    }

    setState(() {
      imcList.add(imc);
      nomeController.clear();
      pesoController.clear();
      alturaController.clear();
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado do IMC'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nome: $nome'),
              Text('Nome: ${age.toStringAsFixed(0)}'),
              const SizedBox(height: 8),
              Text(mensagem),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        backgroundColor: kPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('lib/images/imc.png', width: 100, height: 100),
            RoundedInputField(
                icon: Icons.perm_identity,
                hintText: 'Nome:',
                controller: nomeController,
                textInputType: TextInputType.name),
            RoundedInputField(
                icon: Icons.date_range,
                hintText: 'Idade:',
                controller: ageController,
                textInputType: const TextInputType.numberWithOptions()),
            RoundedInputField(
                icon: Icons.height,
                hintText: 'Altura: (cm)',
                controller: alturaController,
                textInputType: const TextInputType.numberWithOptions()),
            RoundedInputField(
                icon: Icons.balance,
                hintText: 'Peso: (kg)',
                controller: pesoController,
                textInputType: const TextInputType.numberWithOptions()),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ação a ser executada quando o botão é pressionado.
                _calcularIMC();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
                  minimumSize: Size(size.width * .8, 24)
                  //fina o tamanho mínimo desejado
                  ),
              child: Text("CALCULAR IMC".toUpperCase()),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: imcList.length,
                itemBuilder: (context, index) {
                  IMC imc = imcList[index];
                  double valorIMC = imc.calcularIMC();
                  String categoriaIMC = '';

                  if (valorIMC < 16) {
                    categoriaIMC = 'Magreza Grave';
                  } else if (valorIMC < 17) {
                    categoriaIMC = 'Magreza Moderada';
                  } else if (valorIMC < 18.5) {
                    categoriaIMC = 'Magreza Leve';
                  } else if (valorIMC < 25) {
                    categoriaIMC = 'Peso Saudável';
                  } else if (valorIMC < 30) {
                    categoriaIMC = 'Sobrepeso';
                  } else if (valorIMC < 35) {
                    categoriaIMC = 'Obesidade Grau I';
                  } else if (valorIMC < 40) {
                    categoriaIMC = 'Obesidade Grau II';
                  } else {
                    categoriaIMC = 'Obesidade Grau III';
                  }

                  return ListTile(
                    title: Text(
                        'Nome: ${imc.nome}\nIdade: ${imc.age.toStringAsFixed(0)} ano(s)\nIMC: ${valorIMC.toStringAsFixed(2)}'),
                    subtitle: Text('Categoria: $categoriaIMC'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
