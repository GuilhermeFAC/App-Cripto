import 'package:criptocoin/models/moeda.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
        icone: 'images/icons8-bitcoin-48.png',
        nome: 'Bitcoin',
        sigla: 'BTC',
        preco: 164603.00),
    Moeda(
        icone: 'images/icons8-ethereum-48.png',
        nome: 'Ethereum',
        sigla: 'ETH',
        preco: 9485.00),
    Moeda(
        icone: 'images/icons8-litecoin-48.png',
        nome: 'Litecoin',
        sigla: 'LTC',
        preco: 3423.00),
    Moeda(
        icone: 'images/icons8-tether-48.png',
        nome: 'Tether',
        sigla: 'USDT',
        preco: 43.00),
    Moeda(
        icone: 'images/icons8-xrp-48.png',
        nome: 'XRP',
        sigla: 'XRP',
        preco: 87675.00),
  ];
}
