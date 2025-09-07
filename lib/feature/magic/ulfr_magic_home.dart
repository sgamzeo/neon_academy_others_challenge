import 'package:flutter/material.dart';

class UlfrMagicHome extends StatefulWidget {
  const UlfrMagicHome({super.key});

  @override
  State<UlfrMagicHome> createState() => _UlfrMagicHomeState();
}

class _UlfrMagicHomeState extends State<UlfrMagicHome>
    with TickerProviderStateMixin {
  // Invisibility Spell
  bool _isVisible = true;

  // Rotation Spell
  double _rotation = 0;

  // Movement Spell
  double _alignmentY = 0;

  // Size Spell
  double _size = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ulfr's Magic")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Invisibility Spell
            const Text('Invisibility Spell'),
            AnimatedOpacity(
              opacity: _isVisible ? 1 : 0,
              duration: const Duration(seconds: 1),
              child: Container(color: Colors.blue, width: 100, height: 100),
            ),
            TextButton(
              onPressed: () => setState(() => _isVisible = !_isVisible),
              child: Text(_isVisible ? 'Hide' : 'Show'),
            ),
            const SizedBox(height: 30),

            // Rotation Spell
            const Text('Rotation Spell'),
            AnimatedRotation(
              turns: _rotation,
              duration: const Duration(seconds: 1),
              child: const Icon(Icons.shield, size: 80),
            ),
            TextButton(
              onPressed: () => setState(() => _rotation += 0.25),
              child: const Text('Rotate'),
            ),
            const SizedBox(height: 30),

            // Movement Spell
            // Movement Spell
            const Text('Movement Spell'),
            SizedBox(
              height: 100, // hareket alanı
              child: AnimatedAlign(
                alignment: Alignment(0, _alignmentY),
                duration: const Duration(seconds: 1),
                child: const Text('Move me!', style: TextStyle(fontSize: 24)),
              ),
            ),
            TextButton(
              onPressed: () =>
                  setState(() => _alignmentY = _alignmentY == 0 ? -1 : 0),
              child: const Text('Move Up/Down'),
            ),
            // Size Spell
            const Text('Size Spell'),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: _size,
              height: _size,
              color: Colors.red,
            ),
            TextButton(
              onPressed: () => setState(() => _size = _size == 100 ? 150 : 100),
              child: const Text('Grow/Shrink'),
            ),
          ],
        ),
      ),
    );
  }
}
