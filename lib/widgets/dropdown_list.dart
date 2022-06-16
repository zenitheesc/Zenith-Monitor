import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/core/pipelines/data_pipeline/data_bloc.dart';

class DropdownList extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final List<String> itemsList;

  const DropdownList(
      {Key? key, required this.itemsList, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String defaultValue = context.select((DataBloc bloc) => bloc.missionName);
    if (!itemsList.contains(defaultValue)) {
      itemsList.add(defaultValue);
    }
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: eerieBlack,
        ),
        child: DropdownButton<String>(
          value: defaultValue,
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
            onChanged(newValue);
          },
          items: itemsList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
  }
}
