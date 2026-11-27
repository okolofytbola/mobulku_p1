import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'services/exercise_service.dart';
import 'widgets/api_key_dialog.dart';
import 'widgets/exercise_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupService();
  runApp(const ExerciseApp());
}

void setupService() {
  final getIt = GetIt.instance;
  if (getIt.isRegistered<Dio>()) {
    return;
  }

  final authInterceptor = AuthInterceptor();
  final loggingInterceptor = LoggingInterceptor();

  getIt.registerSingleton<AuthInterceptor>(authInterceptor);
  getIt.registerSingleton<LoggingInterceptor>(loggingInterceptor);

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.api-ninjas.com/v1/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.addAll([
      authInterceptor,
      loggingInterceptor,
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    ]);

  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<ExerciseService>(ExerciseService());
}

class ExerciseApp extends StatelessWidget {
  const ExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Спортивные упражнения',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExerciseScreen(),
    );
  }
}

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final GlobalKey<ExerciseListState> _listKey = GlobalKey<ExerciseListState>();

  void _openApiKeyDialog() {
    showDialog(
      context: context,
      builder: (context) => ApiKeyDialog(
        onKeyUpdated: () {
          _listKey.currentState?.loadExercises();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Спортивные упражнения'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.vpn_key),
            tooltip: 'Настройки API-ключа',
            onPressed: _openApiKeyDialog,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Обновить',
            onPressed: () {
              _listKey.currentState?.loadExercises();
            },
          ),
        ],
      ),
      body: ExerciseList(key: _listKey),
    );
  }
}
