import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serenestream/Constants/AppSizer.dart';
import 'package:serenestream/Constants/colors.dart';

class CustomTimerPicker extends StatefulWidget {
  final Function(Duration) onDurationChanged;
  final Duration initialDuration;

  CustomTimerPicker({required this.onDurationChanged, required this.initialDuration});

  @override
  _CustomTimerPickerState createState() => _CustomTimerPickerState();
}

class _CustomTimerPickerState extends State<CustomTimerPicker> {
  int selectedHours = 0;
  int selectedMinutes = 0;
  int selectedSeconds = 0;

  @override
  void initState() {
    super.initState();
    selectedHours = widget.initialDuration.inHours;
    selectedMinutes = widget.initialDuration.inMinutes % 60;
    selectedSeconds = widget.initialDuration.inSeconds % 60;
  }

  void _onSelectedItemChanged() {
    final duration = Duration(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSeconds);
    widget.onDurationChanged(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPicker(
          label: 'Hours',
          value: selectedHours,
          onChanged: (value) {
            setState(() {
              selectedHours = value;
              _onSelectedItemChanged();
            });
          },
          itemCount: 24,
        ),
        _buildPicker(
          label: 'Minutes ',
          value: selectedMinutes,
          onChanged: (value) {
            setState(() {
              selectedMinutes = value;
              _onSelectedItemChanged();
            });
          },
          itemCount: 60,
        ),
        _buildPicker(
          label: ' Seconds',
          value: selectedSeconds,
          onChanged: (value) {
            setState(() {
              selectedSeconds = value;
              _onSelectedItemChanged();
            });
          },
          itemCount: 60,
        ),
      ],
    );
  }

  Widget _buildPicker({required String label, required int value, required ValueChanged<int> onChanged, required int itemCount}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.h,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(label,style: TextStyle(fontSize: AppSizer.fifteen,fontWeight: FontWeight.w600,color: AppColors.blackshade),),
          ),
          SizedBox(
            height: 240.h,
            width: 60,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(initialItem: value),
              itemExtent: 80,
              onSelectedItemChanged: onChanged,
              children: List<Widget>.generate(itemCount, (index) {
                return Center(child: Text(style: TextStyle(fontSize: AppSizer.thirty,fontWeight: FontWeight.w400,color: AppColors.black),index.toString().padLeft(2, '0')));
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Duration selectedDuration = Duration(hours: 0, minutes: 50, seconds: 0);

  void _navigateToDurationDisplayPage(Duration duration) {
    String formattedDuration = _formatDuration(duration);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DurationDisplayPage(duration: formattedDuration),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTimerPicker(
              initialDuration: selectedDuration,
              onDurationChanged: (duration) {
                setState(() {
                  selectedDuration = duration;
                });
                _navigateToDurationDisplayPage(duration);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DurationDisplayPage extends StatelessWidget {
  final String duration;

  DurationDisplayPage({required this.duration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Duration Display'),
      ),
      body: Center(
        child: Text(
          duration,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}
