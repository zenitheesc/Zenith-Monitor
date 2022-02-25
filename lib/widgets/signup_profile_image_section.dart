import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class ProfileImageSection extends StatelessWidget {
  double screenWidth;
  double screenHeight;
  double _imageContainerSize;
  double _iconButtonContainerSize;

  ProfileImageSection({required this.screenWidth, required this.screenHeight})
      : _imageContainerSize = 0.2 * screenHeight,
        _iconButtonContainerSize = 0.07 * screenHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: _imageContainerSize,
          width: _imageContainerSize,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.5 * _imageContainerSize),
              color: white),
          margin: EdgeInsets.only(
              right: 0.8 * screenWidth - _imageContainerSize,
              bottom: 0.07 * screenHeight),
          child: Center(
            child: Icon(
              Icons.person_outlined,
              size: 0.8 * _imageContainerSize,
            ),
          ),
        ),
        Positioned(
          top: 0.65 * _imageContainerSize,
          left: 0.75 * _imageContainerSize,
          child: Container(
            height: _iconButtonContainerSize,
            width: _iconButtonContainerSize,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(0.5 * _iconButtonContainerSize),
                color: white),
            child: IconButton(
              iconSize: 0.6 * _iconButtonContainerSize,
              padding: const EdgeInsets.all(0.0),
              splashRadius: 0.65 * _iconButtonContainerSize,
              onPressed: () {
                print('Icon button was pressed!');
              },
              icon: Icon(
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
