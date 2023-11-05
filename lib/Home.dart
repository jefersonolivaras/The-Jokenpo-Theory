// ignore_for_file: file_names, library_private_types_in_public_api, unnecessary_new, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:thejokenpotheory/informacoes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _numeroAleatorio = 0;
  int _numeroAleatorioModalidade = 0;
  int eu = 0, adv = 0; //para contar pontos atual
  double tamanhoEU = 15; //tamanho do texto de EU
  double tamanhoADV = 15; //tamanho do texto de ADV
  var corEU = Colors.purple; //cor de EU
  var corADV = Colors.purple; //cor de ADV

  var img = "images/logo.png"; //imagem inicial
  var msg = "Vamos Jogar?"; //msg inicial
  var msg2 =
      "Clique no botão Modo para selecionar uma modalidade"; //msg2 inicial
  int countRodadeAtual = 0;
  int qtdRodada =
      30; //Para definir numero de rodada maxima, quando a rodada atinge o limite, quem tiver mais pontos VENCE
  int qtdPontos =
      30; //Para definir numero de pontos, quem chegar lá primeiro VENCE

  List adversario = [
    //possiveis jogadas do adversario
    "images/pedra.png",
    "images/papel.png",
    "images/tesoura.png",
    "images/lagarto.png",
    "images/spock.png",
  ];

  List modalidade = [
    //São 2 modalidades, 0 2 4 6 8 10 modalidade Rodada, restantes modalidade pontos
    "Vamos confrontar durante 30 Rodadas",
    "Quem vai chegar a 30 primeiro?",
    "Vamos lá, 30 Rodadas",
    "Aposto que vou chegar a 30 primeiro",
    "Vai ser 30 Rodadas",
    "30 pontos é o que vou fazer",
    "Vai ser 30 Rodadas divertidas",
    "Preparado para eu te vencer por 30 pontos?",
    "30 Rodadas te amassando por completo",
    "Vc não vai escapar, vou fazer 30 pontos primeiro",
    "Vou te destruir durante 30 rodadas",
  ];

  void _instrucoes() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Informacoes()));
  }

  void _jogadaAdversario() {
    //gerando numero aleatorio para definir a jogada do adversario
    setState(() {
      _numeroAleatorio = new Random().nextInt(adversario.length.toInt());
      img = adversario[_numeroAleatorio];
    });
  }

  void vencendo() {
    //para saber a pontuação atual, baseado na pontuação atribui cor e o tamanho da fonte
    setState(() {
      if (eu > adv) {
        tamanhoEU = 25;
        tamanhoADV = 15;
        corEU = Colors.green;
        corADV = Colors.red;
      } else if (eu < adv) {
        tamanhoEU = 15;
        tamanhoADV = 25;
        corEU = Colors.red;
        corADV = Colors.green;
      } else {
        tamanhoEU = 15;
        tamanhoADV = 15;
        corEU = Colors.purple;
        corADV = Colors.purple;
      }
    });
  }

  void reset() {
    //para reiniciar as variaveis, ou seja, jogo volta ao inicio
    setState(() {
      eu = 0;
      adv = 0;
      corEU = Colors.purple;
      corADV = Colors.purple;
      tamanhoEU = 15;
      tamanhoADV = 15;
      countRodadeAtual = 0;
    });
  }

  void selecionaModalidade() {
    //gerando um numero aleatorio para saber a modalidade que será jogada
    setState(() {
      _numeroAleatorioModalidade =
          new Random().nextInt(modalidade.length.toInt());

      msg2 = modalidade[_numeroAleatorioModalidade];
    });
  }

  void jogar() {
    //definindo as regras do jogo para cada 1 das 2 modalidades existente
    if (_numeroAleatorioModalidade == 0 ||
        _numeroAleatorioModalidade == 2 ||
        _numeroAleatorioModalidade == 4 ||
        _numeroAleatorioModalidade == 6 ||
        _numeroAleatorioModalidade == 8 ||
        _numeroAleatorioModalidade == 10) {
      //modalidade rodada
      countRodadeAtual++; //passndo para proxima rodada

      msg2 =
          "Rodada $countRodadeAtual de $qtdRodada"; //informando a rodada atual

      if (countRodadeAtual == qtdRodada) {
        //verificando se chegou a rodada final
        if (adv > eu) {
          //se pontos do adversario na rodada final for maior que eu, adversario vence
          msg = "O Adversário te derotou por $adv a $eu";
        } else if (adv < eu) {
          //se pontos do adversario na rodada final for menor que eu, adversario perde
          msg = "Vc venceu por $eu a $adv";
        } else {
          //se pontos do adversario na rodada final for igual a eu, final empate
          msg = "Que incrível! Um final com empate";
        }

        msg2 = "FIM DO JOGO! Rodada $countRodadeAtual de $qtdRodada";

        reset(); //reiniciando as variaveis
      }
    } else {
      //modalidade pontos
      //verificando a pontuação atual para informar quem está  vencendo
      if (adv > eu) {
        //se pontos do adversario na rodada final for maior que eu, adversario vence
        msg2 = "Adversário esta vencendo com $adv de $qtdPontos";
      } else if (adv < eu) {
        //se pontos do adversario na rodada final for menor que eu, adversario perde
        msg2 = "Vc esta vencendo com $eu de $qtdPontos";
      } else {
        //se pontos do adversario na rodada final for igual a eu, final empate
        msg2 = "Estão empatados com $eu de $qtdPontos";
      }

      if (adv == qtdPontos) {
        //verificando se adversário chegou ao ponto primeiro, adversario vence
        if ((adv - eu) > (qtdPontos / 2)) {
          //se a diferença for maior do que a metade
          msg = "O Adversário te AMASSOUUUU por $adv a $eu";
        } else {
          //se a diferença for menor do que a metade
          msg = "O Adversário te derotou por $adv a $eu";
        }

        reset(); //reiniciando as variaveis
      } else if (eu == qtdPontos) {
        //se a diferença for maior do que a metade
        if ((adv - eu) > (qtdPontos / 2)) {
          msg = "Vc AMASSOUUUU o adversário por $eu a $adv";
        } else {
          //se a diferença for menor do que a metade
          msg = "Vc venceu o adversário por $eu a $adv";
        }

        reset(); //reiniciando as variaveis
      }
    }
  }

  void _pedra() {
    //chamado ao apertar botao de pedra
    _jogadaAdversario(); //para saber qual a jogada do adversario

    //Comparando as jogadas
    if (_numeroAleatorio == 0) {
      msg = "EMPATE Pedra com Pedra";
    } else if (_numeroAleatorio == 1 || _numeroAleatorio == 4) {
      msg = "Vc PERDEU, Papel ou Spock ganham de Pedra";
      adv++; //pontos para adversario
    } else if (_numeroAleatorio == 3 || _numeroAleatorio == 2) {
      msg = "Vc VENCEU, Pedra ganha de Tesoura ou Lagarto";
      eu++; //pontos para eu
    }

    vencendo(); //verificando a pontuação atual para atribuir cores e formataçoes
    jogar(); //para aplicar as regras da modalidade atual
  }

  void _papel() {
    //mesmos comentarios que pedra()
    _jogadaAdversario();

    //Comparando as jogadas
    if (_numeroAleatorio == 1) {
      msg = "EMPATE Papel com Papel";
    } else if (_numeroAleatorio == 2 || _numeroAleatorio == 3) {
      msg = "Vc PERDEU, Tesoura ou Lagarto ganham de Papel";
      adv++; //pontos para adversario
    } else if (_numeroAleatorio == 0 || _numeroAleatorio == 4) {
      msg = "Vc VENCEU, Papel ganha de Pedra ou Spock";
      eu++; //pontos para eu
    }

    vencendo();
    jogar();
  }

  void _tesoura() {
    //mesmos comentarios que pedra()
    _jogadaAdversario();

    //Comparando as jogadas
    if (_numeroAleatorio == 2) {
      msg = "EMPATE Tesoura com Tesoura";
    } else if (_numeroAleatorio == 0 || _numeroAleatorio == 4) {
      msg = "Vc PERDEU, Pedra ou Spock ganham de Tesoura";
      adv++; //pontos para adversario
    } else if (_numeroAleatorio == 1 || _numeroAleatorio == 3) {
      msg = "Vc VENCEU, Tesoura ganha de Papel ou Lagarto";
      eu++; //pontos para eu
    }

    vencendo();
    jogar();
  }

  void _lagarto() {
    //mesmos comentarios que pedra()
    _jogadaAdversario();

    //Comparando as jogadas
    if (_numeroAleatorio == 3) {
      msg = "EMPATE Lagarto com Lagarto";
    } else if (_numeroAleatorio == 0 || _numeroAleatorio == 2) {
      msg = "Vc PERDEU, Pedra ou Tesoura ganham de Lagarto";
      adv++; //pontos para adversario
    } else if (_numeroAleatorio == 1 || _numeroAleatorio == 4) {
      msg = "Vc VENCEU, Lagarto ganha de Papel ou Spock";
      eu++; //pontos para eu
    }

    vencendo();
    jogar();
  }

  void _spock() {
    //mesmos comentarios que pedra()
    _jogadaAdversario();

    //Comparando as jogadas
    if (_numeroAleatorio == 4) {
      msg = "EMPATE Spock com Spock";
    } else if (_numeroAleatorio == 1 || _numeroAleatorio == 3) {
      msg = "Vc PERDEU, Papel ou Lagarto ganham de Spock";
      adv++; //pontos para adversario
    } else if (_numeroAleatorio == 0 || _numeroAleatorio == 2) {
      msg = "Vc VENCEU, Spock ganha de Pedra ou Tesoura";
      eu++; //pontos para eu
    }

    vencendo();
    jogar();
  }

  void _reiniciar() {
    setState(() {
      msg =
          "Jogo Reiniciado! Vamos Jogar?"; //msg diferente para mostrar que o jogo foi reiniciado
      img = "images/logo.png"; //chamando o logotipo novamente

      reset(); //reiniciando as variaveis

      selecionaModalidade(); //reiniciar a seleção da modalidade
    });
  }

  @override
  void initState() {
    super.initState();
    selecionaModalidade();
  }

  @override
  Widget build(BuildContext context) {
    // Cores Synthwave
    Color backgroundColor = const Color(0xFF0E0E1A); // Fundo escuro
    Color primaryColor = const Color(0xFFFC77FF); // Rosa
    Color secondaryColor = const Color(0xFF33FFFC); // Azul ciano
    Color accentColor = const Color(0xFFFFAA33); // Laranja

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/fundo.png"),
            fit: BoxFit.cover, // Para preencher toda a tela
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "EU: $eu",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: tamanhoEU,
                          color: corEU,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "VS",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Adv: $adv",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: tamanhoADV,
                          color: corADV,
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Escolha do adversário:",
                  style: TextStyle(color: Colors.white),
                ),
                Image.asset(
                  "$img",
                  height: 300,
                ),
                Text(
                  "$msg",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "$msg2",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: secondaryColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _pedra,
                      child: Image.asset(
                        "images/pedra2.png",
                        height: 75,
                      ),
                    ),
                    GestureDetector(
                      onTap: _papel,
                      child: Image.asset(
                        "images/papel2.png",
                        height: 75,
                      ),
                    ),
                    GestureDetector(
                      onTap: _tesoura,
                      child: Image.asset(
                        "images/tesoura2.png",
                        height: 75,
                      ),
                    ),
                    GestureDetector(
                      onTap: _lagarto,
                      child: Image.asset(
                        "images/lagarto2.png",
                        height: 75,
                      ),
                    ),
                    GestureDetector(
                      onTap: _spock,
                      child: Image.asset(
                        "images/spock2.png",
                        height: 75,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _reiniciar,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(accentColor),
                      ),
                      child: Text(
                        "Reiniciar",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: backgroundColor,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _instrucoes,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(accentColor),
                      ),
                      child: Text(
                        "Instruções",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: backgroundColor,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
