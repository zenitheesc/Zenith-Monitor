import 'package:zenith_monitor/utils/helpers/string_to_pattern.dart';

class MissionVariable<T> {
  late String _variableName;
  late String _variableType;
  T? _variableValue;

  MissionVariable(String variableName, String variableType) {
    _variableName = variableName;
    _variableType = stringToPattern(variableType);
    _variableValue = null;
  }

  String getVariableName() {
    return _variableName;
  }

  String getVariableType() {
    return _variableType;
  }

  T? getVariableValue() {
    return _variableValue;
  }

  void addValue(var value) {
    _variableValue = (value) as T?;
  }
}
