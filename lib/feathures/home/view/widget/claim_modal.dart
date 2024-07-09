import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:venturelead/feathures/auth/controller/auth_controller.dart';
import 'package:venturelead/feathures/auth/model/user_model.dart';
import 'package:venturelead/feathures/home/controller/companies_controller.dart';
import 'package:venturelead/feathures/home/controller/network_controller.dart';

class ClaimModal extends StatefulWidget {
  const ClaimModal({super.key});

  @override
  _ClaimModalState createState() => _ClaimModalState();
}

class _ClaimModalState extends State<ClaimModal> {
  final _formKey = GlobalKey<FormState>();
  final User user = Get.find<AuthController>().authState.value.authEntity;
  final CompanyController companyController = Get.put(CompanyController());
  final TextEditingController _positionController = TextEditingController();
  String? _registrationFilePath;
  String? _citizenshipFilePath;

  @override
  Widget build(BuildContext context) {
    final company = companyController.getSelectedCompany;

    return AlertDialog(
      title: const Text('Claim Company'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(
                  labelText: 'Position',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Position is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result != null) {
                    setState(() {
                      _registrationFilePath = result.files.single.path;
                    });
                  }
                },
                child: const Text(
                  'Select Registration File',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              if (_registrationFilePath != null)
                Text('File: ${_registrationFilePath!.split('/').last}'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result != null) {
                    setState(() {
                      _citizenshipFilePath = result.files.single.path;
                    });
                  }
                },
                child: const Text('Select Citizenship File',
                    style: TextStyle(color: Colors.black)),
              ),
              if (_citizenshipFilePath != null)
                Text('File: ${_citizenshipFilePath!.split('/').last}'),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(foregroundColor: Colors.black),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              FormData formData = FormData.fromMap({
                'userId': user.userid,
                'companyId': company['_id'],
                'fullname': user.username,
                'email': user.email,
                'position': _positionController.text,
                'registrationimage': _registrationFilePath,
                'citizenshipimage': _citizenshipFilePath,
              });

              bool isClaim = await handleCompanyClaim(formData);

              if (isClaim) {
                Get.showSnackbar(const GetSnackBar(
                  title: 'Success',
                  message: 'Claim request sent successfully.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 1),
                ));
                Navigator.of(context).pop();
              }
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Claim', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
