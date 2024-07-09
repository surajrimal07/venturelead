class FAQ {
  String id;
  String question;
  String answer;

  FAQ({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      id: json['_id'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}
