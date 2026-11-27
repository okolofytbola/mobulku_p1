import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseDetailDialog extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailDialog({super.key, required this.exercise});

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.fitness_center, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              exercise.name,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildInfoRow(Icons.category, 'Тип', exercise.type),
            _buildInfoRow(Icons.accessibility_new, 'Мышцы', exercise.muscle),
            _buildInfoRow(Icons.sports, 'Оборудование', exercise.equipment),
            _buildInfoRow(Icons.speed, 'Сложность', exercise.difficulty),
            const Divider(height: 20),
            const Text(
              'Техника выполнения:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 8),
            Text(
              exercise.instructions,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Закрыть'),
        ),
      ],
    );
  }
}
