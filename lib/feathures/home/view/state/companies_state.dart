class CompaniesState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final List<dynamic> companies;
  final dynamic selectedCompany;

  CompaniesState({
    required this.isLoading,
    this.error,
    required this.showMessage,
    required this.companies,
    this.selectedCompany,
  });

  factory CompaniesState.initialState() => CompaniesState(
      isLoading: false,
      error: null,
      showMessage: false,
      companies: [],
      selectedCompany: null);

  CompaniesState copyWith(
      {bool? isLoading,
      String? error,
      bool? showMessage,
      dynamic selectedCompany,
      List<dynamic>? companies}) {
    return CompaniesState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        selectedCompany: selectedCompany ?? this.selectedCompany,
        companies: companies ?? this.companies);
  }
}
