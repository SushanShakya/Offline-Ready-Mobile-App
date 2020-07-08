import 'package:Intern_Project_naxa/src/Constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final String firstName;
  final String lastName;
  final int id;
  final String email;
  final String avatar;
  final AnimationController animationController;
  final Animation animation;

  const UserDetails(
      {Key key,
      this.firstName,
      this.lastName,
      this.id,
      this.email,
      this.avatar,
      this.animation,
      this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Card(
              margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              elevation: 10.0,
              child: Container(
                // height: 250,
                padding: EdgeInsets.all(30.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      minRadius: 50.0,
                      maxRadius: 60.0,
                      backgroundImage: CachedNetworkImageProvider(avatar),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ID : $id'),
                          Text(
                            '$firstName $lastName',
                            style: kHeader.copyWith(
                                fontSize: 16.0, letterSpacing: 1.0),
                          ),
                          Text('$email'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
