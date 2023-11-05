import 'package:flutter/material.dart';
import 'package:thejokenpotheory/Home.dart';

class Informacoes extends StatefulWidget {
  const Informacoes({super.key});

  @override
  State<Informacoes> createState() => _InformacoesState();
}

class _InformacoesState extends State<Informacoes> {
  void _voltar() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Faz com que o container ocupe toda a tela
        children: [
          Image.asset(
            "images/instrucoes2.png",
            fit: BoxFit.cover, // Para preencher toda a tela
          ),
          Column(
            mainAxisAlignment:
                MainAxisAlignment.end, // Alinhar a coluna na parte inferior
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.blue),
                onPressed: _voltar,
                icon: const Icon(Icons.arrow_back),
                label: const Text("Voltar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
