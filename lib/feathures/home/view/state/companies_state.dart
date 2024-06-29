class CompaniesState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final List<dynamic> companies;
  final List<dynamic> allCompanies;
  final List<dynamic> featuredCompanies;

  final dynamic selectedCompany;

  CompaniesState({
    required this.isLoading,
    this.error,
    required this.showMessage,
    required this.companies,
    this.selectedCompany,
    this.allCompanies = const [],
    this.featuredCompanies = const [],
  });

  factory CompaniesState.initialState() => CompaniesState(
      isLoading: false,
      error: null,
      showMessage: false,
      companies: [],
      selectedCompany: null,
      featuredCompanies: [],
      allCompanies: []);

  CompaniesState copyWith(
      {bool? isLoading,
      String? error,
      bool? showMessage,
      dynamic selectedCompany,
      List<dynamic>? allCompanies,
      List<dynamic>? featuredCompanies,
      List<dynamic>? companies}) {
    return CompaniesState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        selectedCompany: selectedCompany ?? this.selectedCompany,
        allCompanies: allCompanies ?? this.allCompanies,
        featuredCompanies: featuredCompanies ?? this.featuredCompanies,
        companies: companies ?? this.companies);
  }
}
