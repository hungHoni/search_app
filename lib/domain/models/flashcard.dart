class Flashcard {
  final String question;
  final String answer;

  const Flashcard({required this.question, required this.answer});

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      question: json['question'] as String? ?? 'Error: Missing question',
      answer: json['answer'] as String? ?? 'Error: Missing answer',
    );
  }

  Map<String, dynamic> toJson() {
    return {'question': question, 'answer': answer};
  }
}
