import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onScaleStart: (details) {
      //   setState(() {
      //     _previousScale = _scale;
      //   });
      // },
      // onScaleUpdate: (details) {
      //   setState(() {
      //     _scale = _previousScale * details.scale;
      //   });
      // },
      onDoubleTap: () {
        setState(() {
          _scale = 1.0;
          _offset = Offset.zero;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          _offset += details.delta;
        });
      },
      child: Transform(
        transform: Matrix4.identity()
          ..translate(_offset.dx, _offset.dy)
          ..scale(_scale),
        child: CustomPaint(
          size: Size.infinite,
          painter: TimelinePainter(),
        ),
      ),
    );
  }
}

class TimelinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );

    for (int i = 0; i < size.height; i += 50) {
      canvas.drawCircle(Offset(size.width / 2, i.toDouble()), 10.0, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Timeline(),
      ),
    );
  }
}
