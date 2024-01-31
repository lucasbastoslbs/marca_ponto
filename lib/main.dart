import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widget/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff966912)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Marca Pontos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<User> _jogadores = <User>[User('teste')];
  int _pontuacao = 0;
  List<int> intervals = <int>[
    -100,
    -50,
    -25,
    -10,
    -5,
    -1,
    1,
    5,
    10,
    25,
    50,
    100
  ];

  void _atualizaPonto() {
    if (_jogadores.isNotEmpty) {
      for (User j in _jogadores) {
        j.ponto = _pontuacao;
      }
    }
  }

  void _resetaPontos() {
    if (_jogadores.isNotEmpty) {
      List<String> nomes = <String>[];
      for (int i = 0; i < _jogadores.length; i++) {
        nomes.add(_jogadores[i].name);
      }
      _jogadores.clear();
      _pontuacao = 0;
      for (int i = 0; i < nomes.length; i++) {
        _jogadores.add(User(
          nomes[i],
          ponto: _pontuacao,
        ));
        setState(() {});
      }
    }
  }

  void _newUserPopUp() {
    String texto = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text("Nome"),
            content: TextField(onChanged: (value) {
              texto = value;
            }),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _jogadores.add(User(texto, ponto: _pontuacao));
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Concluir"))
            ],
          );
        });
  }

  void _editNumberPopUp() {
    String texto = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text("Pontuação"),
            content: TextField(
              onChanged: (value) {
                texto = value;
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]*')),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _pontuacao = int.tryParse(texto) ?? 0;
                      _atualizaPonto();
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Concluir"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: _newUserPopUp,
                tooltip: "Novo Jogador",
                icon: const Icon(Icons.person_add_alt)),
            IconButton(
                onPressed: _resetaPontos,
                tooltip: "Resetar Pontos",
                icon: const Icon(Icons.hourglass_empty_outlined)),
          ],
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...intervals.map((valor) {
                    return TextButton(
                        onPressed: () {
                          setState(() {
                            _pontuacao += valor;
                            _atualizaPonto();
                          });
                        },
                        child: Text(valor < 0 ? '$valor' : '+$valor'));
                  }).toList()
                ],
              ),
            ),
            TextButton(
              onPressed: _editNumberPopUp,
              child: Text(
                '$_pontuacao',
                style: const TextStyle(fontSize: 28),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _jogadores.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = _jogadores[index];
                    return Dismissible(
                      key: Key(item.name),
                      onDismissed: (direction) {
                        setState(() {
                          _jogadores.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${item.name} removido.')));
                      },
                      child: item,
                    );
                  }),
            ),
          ],
        ));
  }
}
/*

 */