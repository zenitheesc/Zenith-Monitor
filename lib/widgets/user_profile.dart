import 'package:flutter/material.dart';
import 'package:zenith_monitor/utils/mixins/class_user.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key, required this.user});

  final User user;

  //método para fazer a verificação se o user possui algum link de foto
  Widget profileChild() {
    if (user.imageLink == null) {
      return const Icon(Icons
          .person); //coloquei um icone mas acho que a ideia eh colocar a primeira letra do nome da pessoa
    }

    return ClipOval(
      child: Image.network(
        user.imageLink!, //aqui é possível ver como ocorre o nullSafety, se tirar a exclamacao não vai funcionar porque imageLink pode guardar null
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80.0, 0, 20.0),
              child: Container(
                width: 160,
                //height: screenWidth / 3,
                child: profileChild(),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: lightCoral,
                ),
              ),
            ),
						Text(
              user.name,
              style: const TextStyle(
								fontWeight: FontWeight.bold,
                color: white,
                fontFamily: 'DMSans',
              ),
            ),
						Container(
							padding: const EdgeInsets.all(12.0),
							decoration: const BoxDecoration(
								color: gray,
								borderRadius: BorderRadius.all(Radius.circular(30)),
							),
							child : Text(
								user.accessLevel,
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
