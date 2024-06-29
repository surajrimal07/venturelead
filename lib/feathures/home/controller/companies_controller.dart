import 'package:get/get.dart';
import 'package:venturelead/feathures/home/view/state/companies_state.dart';

class CompanyController extends GetxController {
  var companyState = CompaniesState.initialState().obs;

  void updateCompanyState(dynamic newState) {
    companyState.value = newState;
  }

  void updateAllCompanyState(dynamic newState) {
    companyState.value = companyState.value.copyWith(allCompanies: newState);
  }

  void updateFeaturedCompanyState(dynamic newState) {
    companyState.value = newState;
  }

  void setLoading(bool isLoading) {
    companyState.value = companyState.value.copyWith(isLoading: isLoading);
  }

  void setError(String? error) {
    companyState.value = companyState.value.copyWith(error: error);
  }

  void setShowMessage(bool showMessage) {
    companyState.value = companyState.value.copyWith(showMessage: showMessage);
  }

  void setCompanyEntity(List<dynamic> companyEntity) {
    companyState.value = companyState.value.copyWith(companies: companyEntity);
  }

  List<dynamic> get getCompanies => companyState.value.companies;

  List<dynamic> get getAllCompanies => companyState.value.allCompanies;

  List<dynamic> get getFeaturedCompanies =>
      companyState.value.featuredCompanies;

  void setSelectedCompany(dynamic company) {
    companyState.value = companyState.value.copyWith(selectedCompany: company);
  }

  dynamic get getSelectedCompany => companyState.value.selectedCompany;

  void clearSelectedCompany() {
    companyState.value = companyState.value.copyWith(selectedCompany: null);
  }

  void clear() {
    companyState.value = CompaniesState.initialState();
  }
}
