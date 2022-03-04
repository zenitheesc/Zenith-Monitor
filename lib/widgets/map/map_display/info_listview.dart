import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/widgets/map/map_display/map_cards.dart';
import '../../../modules/map/bloc/map_bloc.dart';
import '../map.dart';

Widget infoListView(BuildContext context, Orientation orientation) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
          height: screenSize(context, "height", 0.25),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
            if (state is UserInfoState) {
              List scrollList = state.newPackage.getVariablesList();

              return ListView.separated(
                  itemCount: scrollList.length % 2 == 0
                      ? scrollList.length ~/ 2
                      : scrollList.length ~/ 2 + 1,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                          height: MediaQuery.of(context).size.height * 0.02),
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      bottom: MediaQuery.of(context).size.height * 0.01),
                  itemBuilder: (BuildContext context, int index) {
                    if (2 * index + 1 < scrollList.length) {
                      return informations(
                          context,
                          orientation,
                          scrollList[index * 2].getVariableName().toString(),
                          scrollList[index * 2 + 1]
                              .getVariableName()
                              .toString(),
                          scrollList[index * 2].getVariableValue().toString(),
                          scrollList[index * 2 + 1]
                              .getVariableValue()
                              .toString());
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.23,
                            left: MediaQuery.of(context).size.width * 0.23),
                        child: informationsContainer(
                            context,
                            orientation,
                            scrollList[index * 2].getVariableName().toString(),
                            scrollList[index * 2].getVariableName().toString()),
                      );
                    }
                  });
            }
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const []);
          }))
    ],
  );
}
