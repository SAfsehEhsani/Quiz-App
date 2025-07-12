import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  String? _selectedOption;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      _questions = await ApiService.fetchQuestions();
      setState(() => _isLoading = false);
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to load questions.'),
        ),
      );
    }
  }

  void submitAnswer() {
    if (_selectedOption == null) return;

    bool isCorrect = _selectedOption == _questions[_currentIndex].correctAnswer;
    if (isCorrect) _score++;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? 'Correct!' : 'Wrong!'),
        content: Text('Correct Answer: ${_questions[_currentIndex].correctAnswer}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (_currentIndex < _questions.length - 1) {
                setState(() {
                  _currentIndex++;
                  _selectedOption = null;
                });
              } else {
                DBService.insertScore(_score);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Quiz Complete!'),
                    content: Text('Your score: $_score'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return Scaffold(body: Center(child: CircularProgressIndicator()));

    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Quiz App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(question.question, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ...question.options.map((option) => RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _selectedOption,
                  onChanged: (val) => setState(() => _selectedOption = val),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitAnswer,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
