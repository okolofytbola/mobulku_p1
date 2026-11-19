import 'package:flutter/material.dart';

void main() {
  runApp(const NotesApp());
}

class Note {
  final String id;
  String text;
  bool isImportant;

  Note({
    required this.text,
    this.isImportant = false,
  }) : id = UniqueKey().toString();
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Заметки',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NotesScreen(),
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Note> _notes = [];
  final TextEditingController _controller = TextEditingController();

  void _addNote() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _notes.add(Note(text: text));
        _controller.clear();
      });
    }
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  void _markImportant(int index) {
    setState(() {
      _notes[index].isImportant = true;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Заметка отмечена как важная'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _resetImportant(int index) {
    setState(() {
      _notes[index].isImportant = false;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Статус заметки восстановлен'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _viewNote(Note note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              const Text('Просмотр заметки'),
              if (note.isImportant) ...[
                const SizedBox(width: 8),
                const Text('⭐', style: TextStyle(fontSize: 20)),
              ],
            ],
          ),
          content: SingleChildScrollView(
            child: Text(
              note.text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  void _editNote(int index) {
    final editController = TextEditingController(text: _notes[index].text);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Редактировать заметку'),
          content: TextField(
            controller: editController,
            autofocus: true,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Введите текст заметки',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                final newText = editController.text.trim();
                if (newText.isNotEmpty) {
                  setState(() {
                    _notes[index].text = newText;
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Введите текст заметки',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _addNote,
                child: const Text('Сохранить'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _notes.isEmpty
                  ? const Center(
                      child: Text(
                        'Заметок пока нет',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _notes.length,
                      itemBuilder: (context, index) {
                        final note = _notes[index];
                        return Dismissible(
                          key: Key(note.id),
                          direction: DismissDirection.horizontal,
                          background: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.green.shade400,
                            child: const Row(
                              children: [
                                Icon(Icons.restore, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  'Обычный статус',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          secondaryBackground: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.red.shade400,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Удалить',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.delete, color: Colors.white),
                              ],
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              _deleteNote(index);
                              return true;
                            } else if (direction == DismissDirection.startToEnd) {
                              _resetImportant(index);
                              return false;
                            }
                            return false;
                          },
                          child: GestureDetector(
                            onTap: () => _viewNote(note),
                            onDoubleTap: () => _markImportant(index),
                            onLongPress: () => _editNote(index),
                            child: Card(
                              color: note.isImportant ? Colors.amber.shade100 : null,
                              elevation: note.isImportant ? 3 : 1,
                              child: ListTile(
                                title: Text(note.text),
                                trailing: note.isImportant
                                    ? const Text('⭐', style: TextStyle(fontSize: 20))
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
