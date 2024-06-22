import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/feathures/auth/controller/auth_controller.dart';
import 'package:venturelead/feathures/auth/model/user_model.dart';
import 'package:venturelead/feathures/home/controller/connection_controller.dart';
import 'package:venturelead/feathures/home/view/widget/connection_success.dart';

class ConnectionMessage extends StatefulWidget {
  const ConnectionMessage({super.key});

  @override
  _ConnectionMessageState createState() => _ConnectionMessageState();
}

class _ConnectionMessageState extends State<ConnectionMessage> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final User user = Get.find<AuthController>().authState.value.authEntity;
  final connectionController = Get.find<ConnectionController>();

  final _formKey = GlobalKey<FormState>();

  var wordCount = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => {
                    connectionController.clearFields(),
                    Navigator.of(context).pop(),
                  },
                ),
                const Text(
                  'Get Connected',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Please share a crisp and clear message on why you are looking to connect.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text('To: Founder at Karkhana'),
            const SizedBox(height: 16),
            _buildTextField(
                'Subject*', subjectController, 'Custom Subject Line'),
            _buildTextField('Message*', messageController, 'Message',
                maxLines: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Obx(() => Text(
                    '${wordCount.value}/200',
                    style: const TextStyle(color: Colors.grey),
                  )),
            ),
            _buildTextField('Email*', emailController, user.email),
            _buildTextField(
                'Linkedin Url', linkedinController, 'Enter Your LinkedIn URL'),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () => validateAndSubmit(
                  connectionController,
                  subjectController,
                  messageController,
                  emailController,
                  linkedinController),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Connect to the company',
                      style: TextStyle(color: Colors.white)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String hint,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: (value) {
            wordCount.value = value.split(' ').length;
          },
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            wordCount.value = value.split(' ').length;
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void validateAndSubmit(
      ConnectionController connectionController,
      subjectController,
      messageController,
      emailController,
      linkedinController) {
    if (_formKey.currentState!.validate()) {
      // connectionController.sendMessage(
      //     subjectController.text,
      //     messageController.text,
      //     emailController.text,
      //     linkedinController.text);

      

      Navigator.of(context).pop();

      connectionController.clearFields();

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return ConnectionSuccess();
        },
      );
    }
    return;
  }

  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();
    emailController.dispose();
    linkedinController.dispose();
    super.dispose();
  }
}
