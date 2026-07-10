import 'dart:io';

import 'package:path_provider/path_provider.dart';

class XmlService {
  Future<File> getXmlFile() async {
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/vehiculos.xml');

    if (!await file.exists()) {
      await file.writeAsString('''
<App Version="2.0">

<Vehicles>

</Vehicles>

</App>
''');
    }

    return file;
  }

  Future<String> readXml() async {
    final file = await getXmlFile();

    return file.readAsString();
  }
}
