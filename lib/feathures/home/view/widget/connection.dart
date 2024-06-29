import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/feathures/auth/controller/auth_controller.dart';
import 'package:venturelead/feathures/auth/model/user_model.dart';
import 'package:venturelead/feathures/home/controller/connection_controller.dart';
import 'package:venturelead/feathures/home/view/widget/connection_message.dart';

class ConnectionModel extends StatelessWidget {
  const ConnectionModel({super.key});

  @override
  Widget build(BuildContext context) {
    //final connectionController = Get.find<ConnectionController>();
    final connectionController = Get.put(ConnectionController());
    final User user = Get.find<AuthController>().authState.value.authEntity;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Reason',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Please tell us know why you would like to connect with the company?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          _buildOption(
              'Business Proposal', context, connectionController, user.userid),
          _buildOption('Interested in Product', context, connectionController,
              user.userid),
          _buildOption('Strategic Partnership', context, connectionController,
              user.userid),
          _buildOption('Would like to work with the company', context,
              connectionController, user.userid),
          _buildOption(
              'Congratulate them', context, connectionController, user.userid),
          _buildOption(
              'Anything Else', context, connectionController, user.userid),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildOption(
      String text, BuildContext context, connectionController, userid) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(text),
        trailing: const Icon(Icons.chevron_right, color: Colors.red),
        onTap: () {
          connectionController.reason.value = text;
          connectionController.userId.value = userid;
          connectionController.reason.value = text;

          Navigator.of(context).pop();

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: const ConnectionMessage(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
