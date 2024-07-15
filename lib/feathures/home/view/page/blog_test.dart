import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:venturelead/feathures/home/controller/network_controller.dart';

class BlogViewer extends StatefulWidget {
  const BlogViewer({super.key});

  @override
  _BlogViewerState createState() => _BlogViewerState();
}

class _BlogViewerState extends State<BlogViewer> {
  final HtmlEditorController controller = HtmlEditorController();
  List<dynamic> blogs = [];

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    try {
      final response = await httpService.dio.get('/api/blogs/get_all_blogs');

      if (response.statusCode == 200) {
        setState(() {
          blogs = response.data as List<dynamic>;
        });
      } else {
        Get.showSnackbar(GetSnackBar(
          title: 'Error',
          message: response.data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
        ));
      }
    } catch (e) {
      print('Error fetching blogs: $e');
      Get.showSnackbar(const GetSnackBar(
        title: 'Error',
        message: 'Failed to fetch blogs.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    String htmlContent = blogs.isNotEmpty ? blogs[0]['description'] ?? '' : '';

    return Scaffold(
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
