import 'package:Intern_Project_naxa/src/Constants/constants.dart';
import 'package:Intern_Project_naxa/src/Controller/data_storage_controller.dart';
import 'package:Intern_Project_naxa/src/Views/Widgets/user_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataStorageController>(
      create: (context) => DataStorageController(),
      child: WillPopScope(
        onWillPop: () async {
          bool value = await showDialog(
              context: context,
              child: AlertDialog(
                title: Text(
                  "Exit ?",
                  style: kHeader,
                ),
                content: Text("Are you sure you want to quit ?"),
                actions: <Widget>[
                  MaterialButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  MaterialButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ));

          if (value) {
            await animationController.reverse();
          }
          return value;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Offline Ready",
              style: kHeader,
            ),
          ),
          body: Consumer<DataStorageController>(
            builder: (context, controller, child) {
              return RefreshIndicator(
                onRefresh: () async {
                  controller.refresh();
                  animationController.reset();
                  return Future.delayed(Duration.zero);
                },
                child: FutureBuilder<bool>(
                  future: controller.fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      animationController.forward();
                      return (snapshot.data)
                          ? ListView.builder(
                              itemCount: controller.usersData.length,
                              itemBuilder: (context, index) {
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                    parent: animationController,
                                    curve: Interval(
                                        (1 / controller.usersData.length) *
                                            index,
                                        1.0,
                                        curve: Curves.fastOutSlowIn),
                                  ),
                                );

                                return UserDetails(
                                  animationController: animationController,
                                  animation: animation,
                                  firstName:
                                      controller.usersData[index].firstName,
                                  lastName:
                                      controller.usersData[index].lastName,
                                  email: controller.usersData[index].email,
                                  id: controller.usersData[index].id,
                                  avatar: controller.usersData[index].avatar,
                                );
                              },
                            )
                          : AlertDialog(
                              title: Text("Error"),
                              content: Text("${controller.message}"),
                              actions: <Widget>[
                                MaterialButton(
                                  child: Text('Retry'),
                                  onPressed: () {
                                    controller.refresh();
                                  },
                                )
                              ],
                            );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
