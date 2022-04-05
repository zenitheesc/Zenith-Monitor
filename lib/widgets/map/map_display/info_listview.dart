import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/modules/map/bloc/map_bloc.dart';
import 'package:zenith_monitor/widgets/map/map_display/map_cards.dart';

class InfoListView extends StatelessWidget {
  final Orientation orientation;
  const InfoListView({
    Key? key,
    required this.orientation,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
              if (state is UserInfoState) {
                List scrollList = state.newPackage.getVariablesList();

                return ListView.separated(
                    controller: scrollController,
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
                              scrollList[index * 2]
                                  .getVariableName()
                                  .toString(),
                              scrollList[index * 2]
                                  .getVariableName()
                                  .toString()),
                        );
                      }
                    });
              }
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const []);
            }),
          );
        },
      ),
    );
  }
}
