import 'package:flutter/material.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
      setState(() {
        _jogadores.clear();
      });
      for (int i = 0; i < nomes.length; i++) {
        setState(() {
          _jogadores.add(User(
            nomes[i],
            ponto: _pontuacao,
          ));
        });
      }
    }
  }

  void _createPopUp() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: _createPopUp,
                tooltip: "Novo Jogador",
                icon: const Icon(Icons.add_circle_rounded)),
            IconButton(
                onPressed: _resetaPontos,
                tooltip: "Resetar Pontos",
                icon: const Icon(Icons.hourglass_empty)),
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _pontuacao -= 100;
                        _atualizaPonto();
                      });
                    },
                    icon: const Icon(Icons.ac_unit)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _pontuacao -= 10;
                        _atualizaPonto();
                      });
                    },
                    icon: const Icon(Icons.ac_unit)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _pontuacao--;
                        _atualizaPonto();
                      });
                    },
                    icon: const Icon(Icons.ac_unit)),
                Text('$_pontuacao'),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _pontuacao++;
                        _atualizaPonto();
                      });
                    },
                    icon: const Icon(Icons.add)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _pontuacao += 10;
                        _atualizaPonto();
                      });
                    },
                    icon: const Icon(Icons.add)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _pontuacao += 100;
                        _atualizaPonto();
                      });
                    },
                    icon: const Icon(Icons.add)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _jogadores.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _jogadores[index];
                  }),
            ),
          ],
        ));
  }
}
/*

 */