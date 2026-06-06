import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Replace these with your actual Supabase values
const supabaseUrl = 'https://vllgxhtoxmckmgbptpct.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZsbGd4aHRveG1ja21nYnB0cGN0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA4MjgzNjcsImV4cCI6MjA4NjQwNDM2N30.y1gnt1E-VuaKdg5Th2lVlqSyeAizHdd3UJaVhrYNs6M';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(const MyApp());
}

// Global Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter(); // Load last saved counter when app starts
  }

  // Increment counter and save to Supabase
  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });

    try {
      await supabase.from('counters').insert({'value': _counter});
    } catch (e) {
      print('Error saving to Supabase: $e');
    }
  }

  // Load last saved counter from Supabase
  Future<void> _loadCounter() async {
    try {
      final response = await supabase
          .from('counters')
          .select()
          .order('id', ascending: false)
          .limit(1)
          .maybeSingle();

      if (response != null) {
        setState(() {
          _counter = response['value'] as int;
        });
      }
    } catch (e) {
      print('Error loading counter: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter + Supabase Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
