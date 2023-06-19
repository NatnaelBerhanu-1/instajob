class EndPoint {
  static String baseUrl = "https://shaybani-web.flutterclone.com/api/";

  static String imageBaseUrl = "https://shaybani-web.flutterclone.com";

  /// Common api's
  static String checkUser = "check_user";
  static String logout = "logout";
  static String sendCode = "forgotpassword";
  static String checkVerificationCode = "checkcodemail";
  static String changePassword = "changepassword";

  /// ---------------- EMPLOYEE INTERFACE --------------- ///

  /// base64
  static String base64 = "base64";

  /// auth
  static String registerEmp = "registration";
  static String loginEmp = "signin";
  static String employeeUpdate = "employe_update";

  ///companies
  static String addCompany = "insertcompany";
  static String getCompanies = "list_of_all_companies";
  static String searchCompany = "getSearchcompanies";

  /// job position
  static String addJobPosition = "insert_of_jobpossition";
  static String getJobPosition = "list_of_jobposition";
  static String editJobPosition = "edit_of_jobposition";
  static String saveJob = "save_job";
  static String insertSaveJob = "insert_savejob";
  static String deleteJobPosition = "delete_jobposition";

  /// Apply Job
  static String applyForJob = "apply";

  /// feedBack
  static String feedbackInsert = "feedback_insert";
  static String autoMsg = "automate_msg_enable_disable";

  // static String reSendCodeForEmp = "resendpassword_employe";

  /// ----------------  USER INTERFACE ---------------  ///

  /// auth
  static String loginUser = "login";
  static String registerUser = "register";
  static String updateUser = "user_update";

  ///resume
  static String addResume = "resume";
  static String getResume = "list_of_resume";
  static String editResume = "edit_resume";

  static String addEducation = "education";
  static String tellUs = "tell_us_about_self";
  static String addWorkExperience = "work_experience";
  static String addSkills = "skill_add";
  static String addAchievement = "achivment_add";

  ///search
  static String searchJob = "search_job";

  // static String reSendCodeForUser = "resendpassword_user";
}
