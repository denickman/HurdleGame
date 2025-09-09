import 'package:flutter/material.dart';
import 'package:hurdleapp/providers/hurdle_provider.dart';
import 'package:hurdleapp/widgets/keyboard_view.dart';
import 'package:hurdleapp/widgets/wordle_view.dart';
import 'package:provider/provider.dart';

class WordHurdlePage extends StatefulWidget {
  const WordHurdlePage({super.key});

  @override
  State<WordHurdlePage> createState() {
    return _WordHurdlePageState();
  }
}

class _WordHurdlePageState extends State<WordHurdlePage> {
  // didChangeDependencies здесь нужен, чтобы вызвать init() у HurdleProvider в тот момент,
  // когда context уже готов и в дереве точно есть провайдер.
  @override
  void didChangeDependencies() {
    Provider.of<HurdleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hurdle App')),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            children: [
              Expanded(
                child: Consumer<HurdleProvider>(
                  builder: (ctx, provider, child) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                    itemCount: provider.hurdleBoard.length,
                    itemBuilder: (context, index) {
                      final wordle = provider.hurdleBoard[index];
                      return WordleView(wordle: wordle);
                    },
                  ),
                ),
              ),
              Consumer<HurdleProvider>(
                builder: (context, provider, child) => KeyboardView(
                  excludedLetters: provider.excludedLetters,
                  onPressed: (letter) {
                    debugPrint(letter);
                    provider.inputLetter(letter);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<HurdleProvider>(
                  builder: (context, provider, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                            provider.deleteLetter();
                        },
                        child: const Text('DELETE'),
                      ),

                      ElevatedButton(
                        onPressed: () {
                            if (!provider.isAValidWord) {
                              ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Not a word in my dictionary')));
                              return;
                            }
                        },
                        child: const Text('SUBMIT'),
                      ),
                    ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
