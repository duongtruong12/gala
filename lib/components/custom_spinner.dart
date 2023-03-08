import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';

class Spinner extends StatefulWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final String behindText;
  final ValueChanged<int> onChanged;

  const Spinner({
    Key? key,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    required this.behindText,
  }) : super(key: key);

  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: _value > widget.minValue
              ? () {
                  setState(() {
                    _value -= 1;
                  });
                  widget.onChanged(_value);
                }
              : null,
          icon: const Icon(Icons.remove),
        ),
        SizedBox(
          width: 64,
          child: Text(
            '$_value${widget.behindText}',
            style: tNormalTextStyle.copyWith(color: kTextColorDark),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          onPressed: _value < widget.maxValue
              ? () {
                  setState(() {
                    _value += 1;
                  });
                  widget.onChanged(_value);
                }
              : null,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
