import 'dart:io';
import 'package:Intern_Project_naxa/src/Services/Network/exceptions/custom_exceptions.dart';
import 'package:path_provider/path_provider.dart';

class OfflineService {
  //Get path
  static Future<String> get _localPath async{
    Directory _directory = await getApplicationDocumentsDirectory();

    return _directory.path;
  }

  // Get reference to the file
  static Future<File> get _file async{
    String _path = await _localPath;

    return File('$_path/users.txt');
  }

  // Write to the file
  static Future<void> writeToFile(String json) async{
    File file = await _file;
    await file.writeAsString(json);
  }

  // Read from the file
  static Future<String> readFromFile() async{
    try{
      File file = await _file;
      return await file.readAsString();
    }catch(e) {
      throw FetchDataException('Could not read from file.');
    }
  }
}