import 'package:flutter/material.dart';
import 'package:trivia_quiz/trivia_quiz.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Random Question Quizz', quizzService: compose()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key, required this.title, required this.quizzService});
  final QuizzService quizzService;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;
  Quizz? _currentQuiz;

  void _incrementCounter() async {
    setState(() {
      _isLoading = true;
    });
    _currentQuiz = await widget.quizzService.getRandomQuizz();

    setState(() {
      _isLoading = false;
    });
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
            if (_isLoading) ...[
              const CircularProgressIndicator(),
              Text("Loading your question",
                  style: Theme.of(context).textTheme.headlineMedium)
            ],
            if (_currentQuiz == null && !_isLoading)
              Text(
                "Push the play button to get a random question",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            if (_currentQuiz != null && !_isLoading) RenderQuizz(_currentQuiz!)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Get Random Question',
        child: const Icon(Icons.arrow_right),
      ),
    );
  }
}

class RenderQuizz extends StatelessWidget {
  final Quizz _quizz;
  const RenderQuizz(this._quizz, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(key: const ValueKey("question"), children: [
          Text(_quizz.question,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
          Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                      child: Text(
                    _quizz.suggestions[0]!,
                    key: const ValueKey("suggestion 1"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  )),
                  Flexible(
                      child: Text(_quizz.suggestions[1]!,
                          key: const ValueKey("suggestion 2"),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20))),
                ],
              )),
          const SizedBox.square(
            dimension: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                  child: Text(_quizz.suggestions[2]!,
                      textAlign: TextAlign.center,
                      key: const ValueKey("suggestion 3"),
                      style: const TextStyle(fontSize: 20))),
              Flexible(
                  child: Text(_quizz.suggestions[3]!,
                      textAlign: TextAlign.center,
                      key: const ValueKey("suggestion 4"),
                      style: const TextStyle(fontSize: 20))),
            ],
          )
        ]));
  }
}
