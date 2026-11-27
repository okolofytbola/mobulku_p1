import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/exercise.dart';
import '../services/exercise_service.dart';
import 'exercise_card.dart';

class ExerciseList extends StatefulWidget {
  const ExerciseList({super.key});

  @override
  State<ExerciseList> createState() => ExerciseListState();
}

class ExerciseListState extends State<ExerciseList> {
  final ExerciseService _exerciseService = GetIt.instance<ExerciseService>();
  final TextEditingController _searchController = TextEditingController();

  List<Exercise> _exercises = List.from(ExerciseService.defaultExercises);
  bool _isLoading = false;
  String _selectedMuscle = 'all';
  String _selectedType = 'all';

  final List<Map<String, String>> _muscles = const [
    {'id': 'all', 'label': 'Все мышцы'},
    {'id': 'biceps', 'label': 'Бицепс'},
    {'id': 'chest', 'label': 'Грудь'},
    {'id': 'quadriceps', 'label': 'Квадрицепс'},
    {'id': 'abdominals', 'label': 'Пресс'},
    {'id': 'lats', 'label': 'Спина'},
    {'id': 'triceps', 'label': 'Трицепс'},
    {'id': 'glutes', 'label': 'Ягодицы'},
  ];

  final List<Map<String, String>> _types = const [
    {'id': 'all', 'label': 'Все типы'},
    {'id': 'strength', 'label': 'Силовые'},
    {'id': 'cardio', 'label': 'Кардио'},
    {'id': 'stretching', 'label': 'Растяжка'},
  ];

  @override
  void initState() {
    super.initState();
    loadExercises();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadExercises() async {
    final results = await _exerciseService.fetchExercises(
      muscle: _selectedMuscle,
      type: _selectedType,
      query: _searchController.text.trim(),
    );

    if (mounted) {
      setState(() {
        _exercises = results;
        _isLoading = false;
      });
    }
  }

  void _onMuscleSelected(String muscleId) {
    setState(() {
      _selectedMuscle = muscleId;
    });
    loadExercises();
  }

  void _onTypeSelected(String typeId) {
    setState(() {
      _selectedType = typeId;
    });
    loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
          child: TextField(
            controller: _searchController,
            onSubmitted: (_) => loadExercises(),
            decoration: InputDecoration(
              hintText: 'Поиск упражнения...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        loadExercises();
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: loadExercises,
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
            ),
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: _muscles.length,
            itemBuilder: (context, index) {
              final m = _muscles[index];
              final isSelected = _selectedMuscle == m['id'];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: Text(m['label']!),
                  selected: isSelected,
                  selectedColor: Colors.deepPurple.shade100,
                  checkmarkColor: Colors.deepPurple,
                  onSelected: (_) => _onMuscleSelected(m['id']!),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: _types.length,
            itemBuilder: (context, index) {
              final t = _types[index];
              final isSelected = _selectedType == t['id'];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(t['label']!),
                  selected: isSelected,
                  selectedColor: Colors.amber.shade100,
                  onSelected: (_) => _onTypeSelected(t['id']!),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _exercises.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.fitness_center,
                            size: 48,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Упражнения не найдены',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: loadExercises,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Повторить запрос'),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: loadExercises,
                      child: ListView.builder(
                        itemCount: _exercises.length,
                        itemBuilder: (context, index) {
                          return ExerciseCard(exercise: _exercises[index]);
                        },
                      ),
                    ),
        ),
      ],
    );
  }
}
