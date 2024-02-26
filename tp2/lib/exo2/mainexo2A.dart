import 'package:flutter/material.dart';

void main() => runApp(const Exo2A());

class Exo2A extends StatelessWidget {
  const Exo2A({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
      ),
      home: const SliderExample(),
    );
  }
}

class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _currentSliderValueX = 0;
  double _currentSliderValueZ = 0;
  double _currentSliderValueScale = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SliderTest')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(color: Colors.white),
            child: Transform.rotate(
              angle: _currentSliderValueX,
              child: Transform(
                transform: Matrix4.rotationX(_currentSliderValueZ),
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: _currentSliderValueScale,
                  child: Image.network(
                    'https://picsum.photos/1024/512',
                    width: 1024.0,
                    height: 512.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          // Slider pour la rotation X
          _SliderX(
            value: _currentSliderValueX,
            onChanged: (double value) {
              setState(() {
                _currentSliderValueX = value;
              });
            },
            label: 'Rotate X:',
          ),
          // Slider pour la translation Y
          _SliderZ(
            value: _currentSliderValueZ,
            onChanged: (double value) {
              setState(() {
                _currentSliderValueZ = value;
              });
            },
            label: 'Rotate Z:',
          ),
          // Slider pour l'échelle Z
          _SliderScale(
            value: _currentSliderValueScale,
            onChanged: (double value) {
              setState(() {
                _currentSliderValueScale = value;
              });
            },
            label: 'Scale:',
          ),
        ],
      ),
    );
  }

  Widget _SliderX({
    required double value,
    required ValueChanged<double> onChanged,
    required String label,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        const SizedBox(width: 20),
        Expanded(
          child: Slider(
            value: value,
            min: 0,
            max: 2 *
                3.14, // Vous pouvez ajuster la plage en fonction de vos besoins
            divisions: 100,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _SliderZ({
    required double value,
    required ValueChanged<double> onChanged,
    required String label,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        const SizedBox(width: 20),
        Expanded(
          child: Slider(
            value: value,
            min: 0,
            max: 2 *
                3.14, // Vous pouvez ajuster la plage en fonction de vos besoins
            divisions: 100,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _SliderScale({
    required double value,
    required ValueChanged<double> onChanged,
    required String label,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        const SizedBox(width: 20),
        Expanded(
          child: Slider(
            value: value,
            min: 0.5,
            max: 2, // Vous pouvez ajuster la plage en fonction de vos besoins
            divisions: 75,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
