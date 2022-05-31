import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class DropdownList extends StatefulWidget {
  final ValueChanged<String?> onChanged;
  final List<String> itemsList;
  final String defaultValue;

  const DropdownList(
      {Key? key,
      required this.itemsList,
      required this.defaultValue,
      required this.onChanged})
      : super(key: key);

  @override
  _DropdownListState createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  late String _defaultValue;

  @override
  initState() {
    super.initState();
    _defaultValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: eerieBlack,
        ),
        child: DropdownButton<String>(
          value: _defaultValue,
          icon: const Icon(
            Icons.expand_more,
            color: white,
          ),
          style: const TextStyle(color: white),
          underline: Container(
            height: 2,
            color: white,
          ),
          onChanged: (String? newValue) {
            setState(() {
              _defaultValue = newValue!;
            });
            widget.onChanged(newValue);
          },
          items: widget.itemsList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
  }
}
