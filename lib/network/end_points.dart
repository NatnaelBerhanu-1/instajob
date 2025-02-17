class EndPoint {
  static String baseUrl = "https://shaybani-web-crimson-water-6355.fly.dev/api/";
  // static String baseUrl = "https://shaybani-web.flutterclone.com/api/";
  // static String baseUrl = "http://10.0.2.2:8000/api/";
  // static String baseUrl = "http://172.17.251.109:8000/api/";

  static String imageBaseUrl = "https://shaybani-web-crimson-water-6355.fly.dev";
  // static String imageBaseUrl = "https://shaybani-web.flutterclone.com";
  // static String imageBaseUrl = "http://10.0.2.2:8000";
  // static String imageBaseUrl = "http://172.17.251.109:8000";

  /// MASKING RESUME

  /// Common api's
  static String checkUser = "check_user";
  static String logout = "logout";
  static String sendCode = "forgotpassword";
  static String checkVerificationCode = "checkcodemail";
  static String changePassword = "changepassword";
  static String checkPhoneNumber = "check_phone_number";
  static String createVideoCall = "create_videocall";
  static String getInterviews = "call_lists";

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
  static String showSaveJob = "show_save_job";
  static String insertSaveJob = "insert_savejob";
  static String deleteJobPosition = "delete_jobposition";

  /// Apply Job
  static String applyForJob = "apply";
  static String getAppliedJob = "apply_show_list";
  static String shortlistOrDenied = "shortlist_or_denied";

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
  static String maskResumeNewFull = "http://3.226.151.140/resume-masker"; // NOTE: this is using another baseurl
  static String resumeMatcherNewFull = "http://3.226.151.140/resume-matcher"; // NOTE: this is using another baseurl
  static String addEducation = "education";
  static String tellUs = "tell_us_about_self";
  static String addWorkExperience = "work_experience";
  static String addSkills = "skill_add";
  static String addAchievement = "achivment_add";
  static String showCreatedResumes = "show_created_resumes";
  static String deleteWorkingExp = "working_exp_delete";
  static String deleteEducation = "eduction_delete";

  ///search
  static String searchJob = "search_job";

  static String jobDistanceLocator = "job_distance_locator";

  // static String reSendCodeForUser = "resendpassword_user";

  /// CAREER CLUSTER

  static String getCareerCluster = "https://services.onetcenter.org/ws/online/career_clusters/";

  static String uploadMp3File = "http://3.82.226.4:8000/uploadfile/";
}
