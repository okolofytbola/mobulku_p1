import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../interceptors/auth_interceptor.dart';

class ApiKeyDialog extends StatefulWidget {
  final VoidCallback onKeyUpdated;

  const ApiKeyDialog({super.key, required this.onKeyUpdated});

  @override
  State<ApiKeyDialog> createState() => _ApiKeyDialogState();
}

class _ApiKeyDialogState extends State<ApiKeyDialog> {
  late final TextEditingController _controller;
  final AuthInterceptor _authInterceptor = GetIt.instance<AuthInterceptor>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _authInterceptor.apiKey);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveKey() {
    final newKey = _controller.text.trim();
    _authInterceptor.apiKey = newKey;
    widget.onKeyUpdated();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('API-ключ успешно обновлен'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.key, color: Colors.deepPurple),
          SizedBox(width: 8),
          Text('Настройки API-ключа'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ключ автоматически подставляется в заголовок X-Api-Key через AuthInterceptor при каждом сетевом запросе к api-ninjas.com.',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'X-Api-Key',
              hintText: 'Введите ваш ключ с api-ninjas.com',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.vpn_key),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _saveKey,
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}
