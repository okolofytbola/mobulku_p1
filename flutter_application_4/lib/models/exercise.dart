class Exercise {
  final String name;
  final String type;
  final String muscle;
  final String equipment;
  final String difficulty;
  final String instructions;

  Exercise({
    required this.name,
    required this.type,
    required this.muscle,
    required this.equipment,
    required this.difficulty,
    required this.instructions,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] as String? ?? 'Упражнение',
      type: json['type'] as String? ?? 'strength',
      muscle: json['muscle'] as String? ?? 'general',
      equipment: json['equipment'] as String? ?? 'none',
      difficulty: json['difficulty'] as String? ?? 'beginner',
      instructions: json['instructions'] as String? ?? 'Инструкция отсутствует',
    );
  }
}
