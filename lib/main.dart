import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Model
class ToDoList extends ChangeNotifier {
  List<String> _tasks = [];

  List<String> get tasks => _tasks;

  void addTask(String newTask) {
    _tasks.add(newTask);
    notifyListeners();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}

// Main
void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => ToDoList(),
    child: const MyApp(),
  ),
);

// MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elegant ToDo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ToDoListScreen(),
    );
  }
}

// UI
class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todo = Provider.of<ToDoList>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Text(
              'My ToDo List 📝',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            const SizedBox(height: 20),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter your task...',
                  prefixIcon: const Icon(Icons.task),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                final task = _controller.text.trim();
                if (task.isNotEmpty) {
                  todo.addTask(task);
                  _controller.clear();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Task"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[600],
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: todo.tasks.isEmpty
                  ? const Center(
                child: Text(
                  "No tasks yet!",
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
              )
                  : ListView.separated(
                itemCount: todo.tasks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final task = todo.tasks[index];
                  return Dismissible(
                    key: Key(task + index.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => todo.removeTask(index),
                    background: Container(
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(task),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => todo.removeTask(index),
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































/*


          ,
            itemCount: todolistmodel.tasks.length,
          ))
        ],
      ),
    );
  }
}



 */


/*
class TextDataProvider extends ChangeNotifier{
  String _text = '';
  String get text => _text;

  void setText(String newstring){
    _text = newstring;
    notifyListeners();
  }
}

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({super.key});
//دي اعلن انه استعكل الستليسس
//crete an obj from class
  @override
  Widget build(BuildContext context) {
    //provuder=دور في التري الي فوق
    //كونتيكست مه كونتيسكت
    //consumer
    final textProvider = Provider.of<TextDataProvider> (context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Text'),
      ),
      body: Center(
        child: Text(textProvider.text),
      ),
    );
  }
}

class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textProvider = Provider.of<TextDataProvider>(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text("InputScreen"),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (text)=>textProvider.setText(text),
            decoration: InputDecoration(hintText: 'Enter here Tetx'),
          ),
          ElevatedButton(onPressed: (){

            //لما اكبس على البتون ينقلني على صفحه بس لانه انا كاتبهتهم في نفس الفايل استخدمت الماتيريلبلدر
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayScreen())
            );
          }, child: Text('Go To Display'))
        ],
      ),
    );
  }
}
void main()=>runApp(
  ChangeNotifierProvider(create: (_)=>TextDataProvider(),
  child: MaterialApp(
    home: InputScreen(),
  ),)
);

 */

