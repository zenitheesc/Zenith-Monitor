import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/signup/bloc/sign_up_bloc.dart';

class ProfileImageSection extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final double _imageContainerSize;
  final double _iconButtonContainerSize;

  const ProfileImageSection(
      {required this.screenWidth, required this.screenHeight})
      : _imageContainerSize = 0.2 * screenHeight,
        _iconButtonContainerSize = 0.07 * screenHeight;

  @override
  _ProfileImgSecState createState() => _ProfileImgSecState();
}

class _ProfileImgSecState extends State<ProfileImageSection> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              right: 0.8 * widget.screenWidth - widget._imageContainerSize,
              bottom: 0.07 * widget.screenHeight),
          child: CircleAvatar(
            radius: 0.5 * widget._imageContainerSize,
            backgroundColor: white,
            child: ClipOval(
              child: SizedBox(
                height: 180.0,
                width: 180.0,
                child: BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    final File? profileImage =
                        context.select((SignUpBloc bloc) => bloc.profileImage);

                    if (state is ProfileImagePicked && profileImage != null) {
                      return Image.file(
                        profileImage,
                        fit: BoxFit.cover,
                      );
                    }
                    return Icon(
                      Icons.person_outlined,
                      color: raisingBlackDarker,
                      size: 0.8 * widget._imageContainerSize,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0.65 * widget._imageContainerSize,
          left: 0.75 * widget._imageContainerSize,
          child: Container(
            height: widget._iconButtonContainerSize,
            width: widget._iconButtonContainerSize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    0.5 * widget._iconButtonContainerSize),
                color: white),
            child: IconButton(
              iconSize: 0.6 * widget._iconButtonContainerSize,
              padding: const EdgeInsets.all(0.0),
              splashRadius: 0.65 * widget._iconButtonContainerSize,
              onPressed: () => showDialog<String>(
                  context: context,
                  builder: (_) => BlocProvider.value(
                        value: context.read<SignUpBloc>(),
                        child: AlertDialog(
                          title: const Text('Foto de perfil'),
                          content: const Text('De onde deseja obter a foto?'),
                          elevation: 24.0,
                          actions: <Widget>[
                            IconButton(
                                onPressed: () {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      PickImageEvent(
                                          source: ImageSource.gallery));

                                  Navigator.pop(_);
                                },
                                icon: const Icon(Icons.folder_rounded)),
                            IconButton(
                                onPressed: () {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      PickImageEvent(
                                          source: ImageSource.camera));

                                  Navigator.pop(_);
                                },
                                icon: const Icon(Icons.photo_camera_rounded)),
                          ],
                        ),
                      )),
              icon: const Icon(
                Icons.photo_library_outlined,
              ),
            ),
          ),
        )
      ],
      clipBehavior: Clip.none,
    );
  }
}
