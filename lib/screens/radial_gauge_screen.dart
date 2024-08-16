import 'package:flutter/material.dart';

void main() {
  runApp(RadialGaugeScreen());
}

class RadialGaugeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radial Gauge with Emojis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RadialGaugePage(),
    );
  }
}

class RadialGaugePage extends StatefulWidget {
  @override
  _RadialGaugePageState createState() => _RadialGaugePageState();
}

class _RadialGaugePageState extends State<RadialGaugePage> {
  double _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radial Gauge with Emojis'),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 4),
                  ),
                ),
                Positioned(
                  top: 10,
                  child: Text(
                    '😊',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Positioned(
                  right: 10,
                  child: Text(
                    '😄',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Text(
                    '😢',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Positioned(
                  left: 10,
                  child: Text(
                    '😡',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Positioned(
                  top: 150,
                  child: Text(
                    '😐',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                GestureDetector(
                  onPanUpdate: (details) {
                    RenderBox box = context.findRenderObject() as RenderBox;
                    Offset position = box.globalToLocal(details.globalPosition);
                    setState(() {
                      _currentValue =
                          (180 / 3.14 * (position.dx - 150) / 100) + 180;
                    });
                  },
                  child: Container(
                    width: 300,
                    height: 300,
                    child: CustomPaint(
                      painter: _RadialGaugePainter(currentValue: _currentValue),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RadialGaugePainter extends CustomPainter {
  final double currentValue;

  _RadialGaugePainter({required this.currentValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: 150),
      180 / 3.14,
      currentValue * 3.14 / 180,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
