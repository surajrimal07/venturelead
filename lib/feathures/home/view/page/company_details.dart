// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
// import 'package:venturelead/feathures/home/controller/companies_controller.dart';

// class HtmlContentDisplay extends StatefulWidget {
//   const HtmlContentDisplay({super.key});

//   @override
//   _HtmlContentDisplayState createState() => _HtmlContentDisplayState();
// }

// class _HtmlContentDisplayState extends State<HtmlContentDisplay> {
//   late HtmlEditorController controller;
//   final CompanyController companyController = Get.find<CompanyController>();

//   @override
//   void initState() {
//     super.initState();

//     controller = HtmlEditorController();
//     controller.disable();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('HTML Content Display'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: HtmlEditor(
//             controller: controller,
//             toolbarOptions: const ToolbarOptions(
//               bold: false,
//               italic: false,
//               underline: false,
//               strikethrough: false,
//               subscript: false,
//               superscript: false,
//               fontSize: false,
//               fontName: false,
//               heading: false,
//               fontColor: false,
//               backgroundColor: false,
//               orderedList: false,
//               unorderedList: false,
//               justifyLeft: false,
//               justifyCenter: false,
//               justifyRight: false,
//               increaseIndent: false,
//               decreaseIndent: false,
//               horizontalRule: false,
//               link: false,
//               unlink: false,
//               insertImage: false,
//               insertVideo: false,
//               insertTable: false,
//               code: false,
//               removeFormat: false,
//               fullScreen: false,
//               showMoreOptions: false,
//               moreOptions: [],
//             ),
//             isPreview: true,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:venturelead/feathures/home/controller/companies_controller.dart';

class DocumentViewer extends StatefulWidget {
  const DocumentViewer({super.key, required this.title});

  final String title;

  @override
  _DocumentViewerState createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  final HtmlEditorController controller = HtmlEditorController();
  final CompanyController companyController = Get.find<CompanyController>();

  @override
  Widget build(BuildContext context) {
    final companies =
        companyController.getCompanies; //data type List<dynamic> companies
    //display this data in the html editor
    String htmlContent = companies[0]['contentData'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            HtmlEditor(
              controller: controller,
              htmlEditorOptions: HtmlEditorOptions(
                shouldEnsureVisible: true,
                initialText: htmlContent,
                disabled: true,
              ),
              htmlToolbarOptions: const HtmlToolbarOptions(
                toolbarPosition: ToolbarPosition.aboveEditor,
                toolbarType: ToolbarType.nativeScrollable,
                defaultToolbarButtons: [],
              ),
              otherOptions: const OtherOptions(height: 550),
            ),
          ],
        ),
      ),
    );
  }
}
