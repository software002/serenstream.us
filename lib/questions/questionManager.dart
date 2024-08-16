
class QuestionManager {
  final List<Map<String, Object>> allQuestions;
  List<Map<String, Object>> dailyQuestions = [];

  QuestionManager(this.allQuestions) {
    generateDailyQuestions();
  }

  void generateDailyQuestions() {
    dailyQuestions = [];
    final morningQuestions = _getRandomQuestions('morning');
    final noonQuestions = _getRandomQuestions('noon');
    final nightQuestions = _getRandomQuestions('night');
    dailyQuestions.addAll(morningQuestions);
    dailyQuestions.addAll(noonQuestions);
    dailyQuestions.addAll(nightQuestions);
  }

  List<Map<String, Object>> _getRandomQuestions(String time) {
    final questions = allQuestions.where((q) => q['time'] == time).toList();
    questions.shuffle();
    return questions.take(5).toList();
  }

  List<Map<String, Object>> getQuestionsForPhase(String phase) {
    return dailyQuestions.where((q) => q['time'] == phase).toList();
  }
}