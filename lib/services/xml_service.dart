import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart';

class XmlService {
  static const String _fileName = 'vehiculos.xml';

  Future<File> getXmlFile() async {
    final directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/$_fileName');

    if (!await file.exists()) {
      await file.writeAsString(_defaultXml);
    }

    return file;
  }

  Future<XmlDocument> loadDocument() async {
    final file = await getXmlFile();

    final xml = await file.readAsString();

    return XmlDocument.parse(xml);
  }

  Future<void> saveDocument(XmlDocument document) async {
    final file = await getXmlFile();

    await file.writeAsString(document.toXmlString(pretty: true, indent: '  '));
  }

  Future<void> resetDatabase() async {
    final file = await getXmlFile();

    await file.writeAsString(_defaultXml);
  }

  static const String _defaultXml = '''
<?xml version="1.0" encoding="UTF-8"?>

<App Version="2.0">

  <Settings>

  </Settings>

  <Vehicles>

  </Vehicles>

  <Parameters>

    <DocumentTypes>

    </DocumentTypes>

    <MaintenanceTypes>

    </MaintenanceTypes>

  </Parameters>

</App>
''';
}
