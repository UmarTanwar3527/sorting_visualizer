import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import '../widgets/sorting_bar.dart';
import '../algorithms/sorting_algorithms.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> _array = [];
  int _arraySize = 25;
  double _speed = 100;
  bool _isSorting = false;
  String _selectedAlgorithm = 'Bubble Sort';
  final List<String> _algorithms = [
    'Bubble Sort',
    'Selection Sort',
    'Insertion Sort',
    'Merge Sort',
    'Quick Sort',
  ];

  int _targetedIndex = -1;
  int _runningIndex = -1;

  @override
  void initState() {
    super.initState();
    _generateNewArray();
  }

  void _generateNewArray() {
    final rand = Random();
    _array = List.generate(_arraySize, (_) => rand.nextInt(150) + 10);
    setState(() {
      _targetedIndex = -1;
      _runningIndex = -1;
    });
  }

  Future<void> _startSort() async {
    setState(() => _isSorting = true);

    switch (_selectedAlgorithm) {
      case 'Bubble Sort':
        await bubbleSort(
            _array,
            (int target, int running) => setState(() {
                  _targetedIndex = target;
                  _runningIndex = running;
                }),
            _speed.toInt());
        break;
      case 'Selection Sort':
        await selectionSort(
            _array,
            (int target, int running) => setState(() {
                  _targetedIndex = target;
                  _runningIndex = running;
                }),
            _speed.toInt());
        break;
      case 'Insertion Sort':
        await insertionSort(
            _array,
            (int target, int running) => setState(() {
                  _targetedIndex = target;
                  _runningIndex = running;
                }),
            _speed.toInt());
        break;
      case 'Merge Sort':
        await mergeSort(
            _array,
            0,
            _array.length - 1,
            (int target, int running) => setState(() {
                  _targetedIndex = target;
                  _runningIndex = running;
                }),
            _speed.toInt());
        break;
      case 'Quick Sort':
        await quickSort(
            _array,
            0,
            _array.length - 1,
            (int target, int running) => setState(() {
                  _targetedIndex = target;
                  _runningIndex = running;
                }),
            _speed.toInt());
        break;
    }

    setState(() {
      _isSorting = false;
      _targetedIndex = -1;
      _runningIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    double barWidth = MediaQuery.of(context).size.width / _array.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sorting Visualizer'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          DropdownButton<String>(
            value: _selectedAlgorithm,
            items: _algorithms.map((String algo) {
              return DropdownMenuItem<String>(
                value: algo,
                child: Text(algo),
              );
            }).toList(),
            onChanged: !_isSorting
                ? (String? value) {
                    setState(() {
                      _selectedAlgorithm = value!;
                    });
                  }
                : null,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: !_isSorting ? _generateNewArray : null,
                child: const Text('New Array'),
              ),
              ElevatedButton(
                onPressed: !_isSorting ? _startSort : null,
                child: const Text('Start Sort'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Slider(
            value: _speed,
            min: 10,
            max: 300,
            divisions: 29,
            label: '${_speed.toInt()} ms',
            onChanged:
                !_isSorting ? (value) => setState(() => _speed = value) : null,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: _array.map((val) {
                int index = _array.indexOf(val);
                return SortingBar(
                  value: val.toDouble(),
                  width: barWidth,
                  color: Colors.deepPurple,
                  isTargeted: index == _targetedIndex,
                  isRunning: index == _runningIndex,
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                final url =
                    Uri.parse('https://www.linkedin.com/in/umartanwar/');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: const Text(
                'Made by Umar Tanwar',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
