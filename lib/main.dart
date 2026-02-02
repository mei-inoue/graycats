import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: CatTrainingApp()));
}

class Sample {
  final String imagePath;
  final String answer;
  const Sample(this.imagePath, this.answer);
}

const String appTitle = '灰色猫 種類判別トレーニング';

class CatTrainingApp extends StatefulWidget {
  const CatTrainingApp({super.key});

  @override
  State<CatTrainingApp> createState() => _CatTrainingAppState();
}

class _CatTrainingAppState extends State<CatTrainingApp> {
  final List<Sample> _samples = [
  Sample('assets/cats/britishshorthair.jpeg', '〇 ブリティッシュショートヘア'),
  Sample('assets/cats/chartreux.jpeg', '〇 シャルトリュー'),
  Sample('assets/cats/nebelong.jpeg', '〇 ネベロング'),
  Sample('assets/cats/norwegianforest.jpeg', '〇 ノルウェージャンフォレスト'),
  Sample('assets/cats/russianblue.jpeg', '〇 ロシアンブルー'),
];


  int _index = 0;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _samples.shuffle(Random());
  }

  void _onTap() {
    setState(() {
      if (_showAnswer) {
        _showAnswer = false;

        if (_index == _samples.length - 1) {
          _samples.shuffle(Random());
          _index = 0;
        } else {
          _index++;
        }
      } else {
        _showAnswer = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sample = _samples[_index];

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                sample.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Center(child: Text('画像を読み込めません')),
              ),
            ),
            if (_showAnswer)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    sample.answer,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 10,
              left: 10,
              child: _hint('${_index + 1}/${_samples.length}'),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: _hint(_showAnswer ? 'タップで次へ' : 'タップで正解表示'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hint(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}