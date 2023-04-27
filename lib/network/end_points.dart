class EndPoint {
  static String baseUrl =
      "https://shaybani-web.ondemandservicesappinflutter.online/api/";
  static String imageBaseUrl =
      "https://shaybani-web.ondemandservicesappinflutter.online";

  /// EMPLOYEE INTERFACE

  /// Common api's
  static String checkUser = "check_user";
  static String logout = "logout";
  static String updateUser = "user_update";

  /// base64
  static String base64 = "base64";

  /// auth
  static String registerEmp = "registration";
  static String loginEmp = "signin";

  ///companies
  static String addCompany = "insertcompany";
  static String getCompanies = "list_of_all_companies";
  static String searchCompany = "getSearchcompanies";

  /// job position
  static String addJobPosition = "insert_of_jobpossition";
  static String getJobPosition = "list_of_jobposition";
  static String editJobPosition = "edit_of_jobposition";

  /// feedBack
  static String feedbackInsert = "feedback_insert";

  /// USER INTERFACE

  /// auth
  static String loginUser = "login";
  static String registerUser = "register";

  ///resume
  static String addResume = "resume";
  static String getResume = "list_of_resume";
  static String editResume = "edit_resume";

  ///search
  static String searchJob = "search_job";
}
