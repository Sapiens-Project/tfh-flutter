import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  final List<Event> events;

  const Timeline({Key? key, required this.events}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final minEpoch =
        widget.events.map((e) => e.epoch).reduce((a, b) => a < b ? a : b);
    final maxEpoch =
        widget.events.map((e) => e.epoch).reduce((a, b) => a > b ? a : b);

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
        child: Stack(
          children: [
            CustomPaint(
              size: Size.infinite,
              painter: TimelinePainter(),
            ),
            for (final event in widget.events)
              Positioned(
                left: MediaQuery.of(context).size.width / 2 - 10,
                top: (event.epoch - minEpoch) /
                    (maxEpoch - minEpoch) *
                    MediaQuery.of(context).size.height,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(event.title),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${event.date}'),
                            SizedBox(height: 8),
                            Text('Description: ${event.description}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                  ),
                ),
              ),
          ],
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Event {
  final String title;
  final String date;
  final String description;
  final int epoch;

  Event({
    required this.title,
    required this.date,
    required this.description,
    required this.epoch,
  });
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final events = [
    Event(
      title: 'Event 1',
      date: '2023-01-01',
      description: 'Description of Event 1',
      epoch: 1640995200,
    ),
    Event(
      title: 'Event 2',
      date: '2023-02-14',
      description: 'Description of Event 2',
      epoch: 1644787200,
    ),
    Event(
      title: 'Event 3',
      date: '2023-03-21',
      description: 'Description of Event 3',
      epoch: 1647849600,
    ),
    Event(
      title: 'Event 4',
      date: '2023-04-15',
      description: 'Description of Event 4',
      epoch: 1650172800,
    ),
    Event(
      title: 'Event 5',
      date: '2023-05-05',
      description: 'Description of Event 5',
      epoch: 1651891200,
    ),
    Event(
      title: 'Event 6',
      date: '2023-06-12',
      description: 'Description of Event 6',
      epoch: 1655174400,
    ),
    Event(
      title: 'Event 7',
      date: '2023-07-04',
      description: 'Description of Event 7',
      epoch: 1656998400,
    ),
    Event(
      title: 'Event 8',
      date: '2023-08-23',
      description: 'Description of Event 8',
      epoch: 1661395200,
    ),
    Event(
      title: 'Event 9',
      date: '2023-09-18',
      description: 'Description of Event 9',
      epoch: 1663555200,
    ),
    Event(
      title: 'Event 10',
      date: '2023-10-31',
      description: 'Description of Event 10',
      epoch: 1667251200,
    ),
    Event(
        title: 'Event11',
        date: '2023-11-15',
        description: 'Description of event11',
        epoch: 1668547200),
    Event(
        title: 'Event12',
        date: '2023-12-01',
        description: 'Description of event12',
        epoch: 1670092800),
    Event(
        title: 'Event13',
        date: '2024-01-01',
        description: 'Description of event13',
        epoch: 1672444800),
    Event(
        title: 'Event14',
        date: '2024-02-14',
        description: 'Description of event14',
        epoch: 1676236800),
    Event(
        title: 'Event15',
        date: '2024-03-21',
        description: 'Description of event15',
        epoch: 1679299200),
    Event(
        title: 'Event16',
        date: '2024-04-15',
        description: 'Description of event16',
        epoch: 1681622400),
    Event(
        title: 'Event17',
        date: '2024-05-05',
        description: 'Description of event17',
        epoch: 1683340800),
    Event(
        title: 'Event18',
        date: '2024-06-12',
        description: 'Description of event18',
        epoch: 1686624000),
    Event(
        title: 'Event19',
        date: '2024-07-04',
        description: 'Description of event19',
        epoch: 1688448000),
    Event(
        title: 'Event20',
        date: '2024-08-23',
        description: 'Description of event20',
        epoch: 1692844800)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Timeline(
          events: events,
        ),
      ),
    );
  }
}
