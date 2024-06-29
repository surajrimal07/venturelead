import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ConnectionController extends GetxController {
  var userId = ''.obs;
  var companyId = ''.obs;
  var reason = ''.obs;
  var isLoading = false.obs;
  var subject = ''.obs;
  var messgage = ''.obs;
  var email = ''.obs;
  var linkedinID = ''.obs;
  var isSubmitted = false.obs;

  void setLoading(bool loading) {
    isLoading.value = loading;
  }

  void setReason(String reason) {
    this.reason.value = reason;
  }

  void setSubject(String subject) {
    this.subject.value = subject;
  }

  void setMessage(String message) {
    messgage.value = message;
  }

  void setEmail(String email) {
    this.email.value = email;
  }

  void setUserId(String userId) {
    this.userId.value = userId;
  }


  void setCompanyId(String companyId) {
    this.companyId.value = companyId;
  }

  void setLinkedinID(String linkedinID) {
    this.linkedinID.value = linkedinID;
  }

  void setSubmitted(bool isSubmitted) {
    this.isSubmitted.value = isSubmitted;
  }

  void clearFields() {
    reason.value = '';
    subject.value = '';
    messgage.value = '';
    email.value = '';
    linkedinID.value = '';
    userId.value = '';
    companyId.value = '';
  }
}
