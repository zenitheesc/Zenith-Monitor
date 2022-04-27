import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/modules/login/bloc/login_bloc.dart';
import 'package:zenith_monitor/utils/helpers/name_abbreviation.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/user_image.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key});

  @override
  Widget build(BuildContext context) {
    final LocalUser? user = context.select((LoginBloc bloc) => bloc.state.user);
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Center(
        child: (user == null)
            ? const Text("Usuário não encontrado",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: white,
                    fontFamily: 'DMSans'))
            : Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 80.0, 0, 20.0),
                      child: UserImage(
                        user: user,
                        radius: 80.0,
                      )),
                  Text(
                    nameAbbreviation(user.getCompleteName(), screenWidth, 24.0),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: white,
                      fontFamily: 'DMSans',
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
                    decoration: const BoxDecoration(
                      color: gray,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Text(
                      user.getAccessLevel(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: white,
                        fontFamily: 'DMSans',
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
