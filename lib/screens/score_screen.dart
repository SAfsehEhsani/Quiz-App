import 'package:flutter/material.dart';
import '../services/db_service.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  List<int> _scores = [];

  @override
  void initState() {
    super.initState();
    loadScores();
  }

  Future<void> loadScores() async {
    final scores = await DBService.getScores();
    setState(() => _scores = scores);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Score History')),
      body: _scores.isEmpty
          ? Center(child: Text('No scores yet!'))
          : ListView.builder(
              itemCount: _scores.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('Score: ${_scores[index]} / 5'),
                );
              },
            ),
    );
  }
}
