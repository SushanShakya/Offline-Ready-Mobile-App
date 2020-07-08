import 'package:Intern_Project_naxa/src/Models/users_model.dart';
import 'package:Intern_Project_naxa/src/Services/Network/network_service.dart';
import 'package:Intern_Project_naxa/src/Services/Offline/offline_service.dart';
import 'package:flutter/material.dart';

class DataStorageController with ChangeNotifier {
  NetworkService _networkService;

  DataStorageController() {
    _networkService = NetworkService();
  }

  String _message = "Try Connecting to the Internet";

  String get message => _message;

  List<UserData> usersData;

  Future<bool> fetchData() async {
    if (!await _getUsers()) {
      try {
        final response = await _networkService.get("/users?page=1");
        await OfflineService.writeToFile(response);
        usersData = usersModelFromJson(response).data;
      } catch (e) {
        _message = e.toString();
        return false;
      }
    }
    return true;
  }

  Future<bool> _getUsers() async {
    try {
      final String data = await OfflineService.readFromFile();
      usersData = usersModelFromJson(data).data;
      return true;
    } catch (e) {
      _message = e.toString();
      return false;
    }
  }

  void refresh() {
    notifyListeners();
  }
}
