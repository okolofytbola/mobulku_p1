import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../models/exercise.dart';

class ExerciseService {
  final Dio _dio = GetIt.instance<Dio>();

  static final List<Exercise> defaultExercises = [
    Exercise(
      name: 'Подтягивания на перекладине',
      type: 'strength',
      muscle: 'lats',
      equipment: 'pull-up bar',
      difficulty: 'intermediate',
      instructions:
          'Возьмитесь за перекладину хватом шире плеч. На выдохе плавно подтянитесь вверх до уровня подбородка. Сделайте секундную паузу и плавно опуститесь в исходное положение.',
    ),
    Exercise(
      name: 'Отжимания от пола',
      type: 'strength',
      muscle: 'chest',
      equipment: 'bodyweight',
      difficulty: 'beginner',
      instructions:
          'Примите упор лежа на вытянутых руках, ладони на ширине плеч. Опускайте корпус до касания грудью пола, сохраняя тело прямым. На выдохе вернитесь в исходную позицию.',
    ),
    Exercise(
      name: 'Приседания со штангой',
      type: 'strength',
      muscle: 'quadriceps',
      equipment: 'barbell',
      difficulty: 'expert',
      instructions:
          'Расположите гриф штанги на трапециевидных мышцах. Спина прямая, колени направлены в сторону носков. Плавно опускайтесь до параллели бедер с полом, затем мощным движением поднимитесь вверх.',
    ),
    Exercise(
      name: 'Сгибания рук с гантелями на бицепс',
      type: 'strength',
      muscle: 'biceps',
      equipment: 'dumbbell',
      difficulty: 'beginner',
      instructions:
          'Встаньте прямо, удерживая гантели по бокам ладонями вперед. Прижимая локти к туловищу, выполните подъем гантелей вверх за счет изолированного сокращения бицепсов.',
    ),
    Exercise(
      name: 'Французский жим на трицепс',
      type: 'strength',
      muscle: 'triceps',
      equipment: 'barbell',
      difficulty: 'intermediate',
      instructions:
          'Лежа на горизонтальной скамье, удерживайте штангу на прямых руках. Сгибая руки в локтевых суставах, опустите гриф ко лбу, затем верните вес в исходное положение.',
    ),
    Exercise(
      name: 'Скручивания на пресс',
      type: 'strength',
      muscle: 'abdominals',
      equipment: 'bodyweight',
      difficulty: 'beginner',
      instructions:
          'Лежа на спине, согните ноги в коленях, руки за головой. За счет сокращения мышц живота оторвите лопатки от пола. Задержитесь на секунду в пиковом сокращении и плавно опуститесь.',
    ),
    Exercise(
      name: 'Планка статическая',
      type: 'strength',
      muscle: 'abdominals',
      equipment: 'bodyweight',
      difficulty: 'beginner',
      instructions:
          'Удерживайте упор на предплечьях и носках ног. Тело должно образовывать прямую линию от макушки до пят. Напрягите мышцы кора и удерживайте позицию 45-60 секунд.',
    ),
    Exercise(
      name: 'Выпады с гантелями',
      type: 'strength',
      muscle: 'glutes',
      equipment: 'dumbbell',
      difficulty: 'intermediate',
      instructions:
          'Сделайте широкий шаг вперед одной ногой и опуститесь вниз так, чтобы переднее бедро было параллельно полу. Вернитесь в исходное положение и повторите на другую ногу.',
    ),
    Exercise(
      name: 'Бег на беговой дорожке',
      type: 'cardio',
      muscle: 'quadriceps',
      equipment: 'treadmill',
      difficulty: 'beginner',
      instructions:
          'Начните с динамической разминки шагом со скоростью 5 км/ч. Постепенно увеличьте темп до комфортного бега в пульсовой зоне 130-150 ударов в минуту.',
    ),
    Exercise(
      name: 'Растяжка подколенных сухожилий',
      type: 'stretching',
      muscle: 'hamstrings',
      equipment: 'bodyweight',
      difficulty: 'beginner',
      instructions:
          'Сидя на полу с выпрямленными перед собой ногами, плавно наклоняйтесь корпусом вперед к стопам, сохраняя спину ровной. Удерживайте растяжение 30 секунд без рывков.',
    ),
  ];

  Future<List<Exercise>> fetchExercises({
    String? muscle,
    String? type,
    String? query,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (muscle != null && muscle.isNotEmpty && muscle != 'all') {
        queryParams['muscle'] = muscle;
      }
      if (type != null && type.isNotEmpty && type != 'all') {
        queryParams['type'] = type;
      }
      if (query != null && query.isNotEmpty) {
        queryParams['name'] = query;
      }

      final response = await _dio.get(
        '/exercises',
        queryParameters: queryParams,
      );

      if (response.data is List) {
        final list = response.data as List<dynamic>;
        if (list.isNotEmpty) {
          return list
              .map((item) => Exercise.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      }
      return _filterFallback(muscle, type, query);
    } on DioException catch (e) {
      debugPrint('DioException caught in ExerciseService: ${e.message}');
      return _filterFallback(muscle, type, query);
    } catch (e) {
      debugPrint('Unexpected error in ExerciseService: $e');
      return _filterFallback(muscle, type, query);
    }
  }

  List<Exercise> _filterFallback(String? muscle, String? type, String? query) {
    return defaultExercises.where((ex) {
      if (muscle != null && muscle != 'all' && ex.muscle != muscle) {
        return false;
      }
      if (type != null && type != 'all' && ex.type != type) {
        return false;
      }
      if (query != null && query.isNotEmpty) {
        final q = query.toLowerCase();
        final matchesName = ex.name.toLowerCase().contains(q);
        final matchesMuscle = ex.muscle.toLowerCase().contains(q);
        if (!matchesName && !matchesMuscle) return false;
      }
      return true;
    }).toList();
  }
}
