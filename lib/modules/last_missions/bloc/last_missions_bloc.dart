import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/pipelines/mission_pipeline/mission_bloc.dart';
import '../../../widgets/last_missions/last_missions.dart';

class LastMissionsBloc extends StatelessWidget {
  const LastMissionsBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => MissionBloc()),
    ], child: const LastMissionsWidget());
  }
}
