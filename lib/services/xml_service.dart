import 'dart:io';

import 'package:path_provider/path_provider.dart';

class XmlService {
  static const String _fileName = 'vehiculos.xml';

  Future<File> getXmlFile() async {
    final directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/$_fileName');

    if (!await file.exists()) {
      await createIfNotExists();
    }

    return file;
  }

  Future<void> createIfNotExists() async {
    final directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/$_fileName');

    if (await file.exists()) {
      return;
    }

    await file.writeAsString('''
<?xml version="1.0" encoding="UTF-8"?>

<App Version="2.0">

  <Vehicles>

  </Vehicles>

</App>
''');
  }

  Future<String> readXml() async {
    final file = await getXmlFile();

    return file.readAsString();
  }

  Future<void> writeXml(String xml) async {
    final file = await getXmlFile();

    await file.writeAsString(xml);
  }
}
