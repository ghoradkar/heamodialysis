// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MahaDialysis';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageFrench => 'French';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get languageTooltip => 'Change language';

  @override
  String get commonSave => 'Save';

  @override
  String get commonSubmit => 'Submit';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClose => 'Close';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonNext => 'Next';

  @override
  String get commonPrevious => 'Previous';

  @override
  String get commonBack => 'Back';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonUpdate => 'Update';

  @override
  String get commonView => 'View';

  @override
  String get commonSearch => 'Search';

  @override
  String get commonClear => 'Clear';

  @override
  String get commonReset => 'Reset';

  @override
  String get commonApply => 'Apply';

  @override
  String get commonRefresh => 'Refresh';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonProceed => 'Proceed';

  @override
  String get commonGoBack => 'Go Back';

  @override
  String get commonDone => 'Done';

  @override
  String get commonSelect => 'Select';

  @override
  String get commonUpload => 'Upload';

  @override
  String get commonDownload => 'Download';

  @override
  String get commonYes => 'Yes';

  @override
  String get commonNo => 'No';

  @override
  String get commonOk => 'OK';

  @override
  String get commonLoading => 'Loading…';

  @override
  String get commonNoData => 'No data';

  @override
  String get commonNoDataFound => 'No data found';

  @override
  String get commonNoRecordsFound => 'No records found';

  @override
  String get commonSomethingWentWrong => 'Something went wrong';

  @override
  String get commonSuccess => 'Success';

  @override
  String get commonError => 'Error';

  @override
  String get commonWarning => 'Warning';

  @override
  String get commonNote => 'Note';

  @override
  String get commonPleaseSelect => 'Please select';

  @override
  String get commonPleaseWait => 'Please wait…';

  @override
  String get commonSessionExpired => 'Session expired. Please log in again.';

  @override
  String get commonNoInternet => 'No internet connection';

  @override
  String get commonCheckConnection =>
      'Please check your connection and try again';

  @override
  String get noInternetHeadline => 'Oh No';

  @override
  String get noInternetMessage => 'No internet connection found.';

  @override
  String get noInternetHint => 'Check your connection or try again.';

  @override
  String get commonRequiredField => 'This field is required';

  @override
  String fieldRequired(String field) {
    return '$field is required';
  }

  @override
  String fieldInvalid(String field) {
    return 'Please enter a valid $field';
  }

  @override
  String get validationInvalidEmail => 'Please enter a valid email';

  @override
  String get validationInvalidPan => 'Please enter a valid PAN';

  @override
  String validationDigits(int count) {
    return 'Please enter a valid $count-digit number';
  }

  @override
  String validationMinDigits(int count) {
    return 'Please enter $count digits';
  }

  @override
  String validationMaxLength(int max) {
    return 'Maximum $max characters allowed';
  }

  @override
  String charactersRemaining(int count) {
    return '$count characters remaining';
  }

  @override
  String get validationHeightFormat => 'Please enter height as e.g. 5\'8';

  @override
  String get validationInvalidNumber => 'Enter a valid number';

  @override
  String validationMaxLitres(String field, String max) {
    return '$field should not be greater than $max ltrs';
  }

  @override
  String get validationDateFormat =>
      'Please enter the date in the format dd/MM/yyyy';

  @override
  String get validationInvalidDate => 'Invalid date. Please check the format';

  @override
  String get unitFahrenheit => 'Fahrenheit';

  @override
  String get unitCelsius => 'Celsius';

  @override
  String get commonDate => 'Date';

  @override
  String get commonTime => 'Time';

  @override
  String get selectTime => 'Select Time';

  @override
  String get commonLogout => 'Logout';

  @override
  String get drawerDashboard => 'Dashboard';

  @override
  String get drawerRegistration => 'Registration';

  @override
  String get drawerDialysisScheduler => 'Dialysis Scheduler';

  @override
  String get drawerDialysisQueue => 'Dialysis Queue';

  @override
  String get drawerSessionEnd => 'Session End';

  @override
  String get drawerRoMaintenance => 'RO Maintenance';

  @override
  String get drawerMachineStatus => 'Machine Status';

  @override
  String get drawerNephrologistDesk => 'Nephrologist Desk';

  @override
  String get drawerDoctorDesk => 'Doctor Desk';

  @override
  String get drawerApplicationApproval => 'Application Approval';

  @override
  String get drawerApplicationScrutiny => 'Application Scrutiny';

  @override
  String get drawerUploadDocuments => 'Upload Documents';

  @override
  String get drawerBilling => 'Billing';

  @override
  String get drawerInvoiceApprovalSecondLevel => 'Invoice Approval (2nd Level)';

  @override
  String get drawerInvoiceGeneration => 'Invoice Generation';

  @override
  String drawerVersion(String version) {
    return 'Version: $version';
  }

  @override
  String get loginTitle => 'Login';

  @override
  String get loginButton => 'Login';

  @override
  String get loginUsername => 'Username';

  @override
  String get loginPassword => 'Password';

  @override
  String get loginForgotPassword => 'Forgot Password?';

  @override
  String get loginCaptchaHint => 'Enter the captcha as shown above';

  @override
  String get loginIndiaOnlyMessage =>
      'This app is only available in the Indian region';

  @override
  String get loginSuccessful => 'Login successful';

  @override
  String loginRunningEnv(String env) {
    return 'Running in $env environment';
  }

  @override
  String loginUnknownRole(String role) {
    return 'Unknown user role: $role';
  }

  @override
  String get loginInvalidUser => 'Invalid User';

  @override
  String get logoutConfirm => 'Are you sure you want to logout?';

  @override
  String get otpVerifyTitle => 'Verify OTP';

  @override
  String get otpSentTo => 'OTP has been sent to registered mobile number:';

  @override
  String get otpYourNumber => 'your registered number';

  @override
  String get otpValidLimited => 'This OTP is valid for a limited time';

  @override
  String get otpCanResendNow => 'Didn\'t get it? You can resend now.';

  @override
  String get otpDidntReceive => 'Didn\'t receive the code?';

  @override
  String get otpResend => 'Resend OTP';

  @override
  String otpResendIn(String time) {
    return 'Resend in $time';
  }

  @override
  String otpEnterDigits(int count) {
    return 'Please enter the $count-digit OTP';
  }

  @override
  String get otpResent => 'OTP resent';

  @override
  String get otpInvalidOrExpired => 'Invalid or Expired OTP';

  @override
  String get otpResendFailed => 'Could not resend OTP. Please login again.';

  @override
  String get commonFrom => 'From';

  @override
  String get commonTo => 'To';

  @override
  String get commonStatus => 'Status';

  @override
  String get commonActions => 'Actions';

  @override
  String get commonAll => 'All';

  @override
  String get commonCompleted => 'Completed';

  @override
  String get commonName => 'Name';

  @override
  String get commonAge => 'Age';

  @override
  String get commonGender => 'Gender';

  @override
  String get commonMobileNo => 'Mobile No';

  @override
  String get commonAddress => 'Address';

  @override
  String get commonRemarks => 'Remarks';

  @override
  String get colSrNo => 'Sr. No';

  @override
  String get colPatientId => 'Patient ID';

  @override
  String get colPatientName => 'Patient Name';

  @override
  String get colAbhaNo => 'ABHA No';

  @override
  String get colDistrictName => 'District Name';

  @override
  String get colInstituteName => 'Institute Name';

  @override
  String get colMachineCount => 'Machine Count';

  @override
  String get colCommencementDate => 'Commencement Date';

  @override
  String get colPatientRegistered => 'Patients Registered';

  @override
  String get colSessionDone => 'Sessions Done';

  @override
  String get colScheme => 'Scheme';

  @override
  String get colSessionCount => 'Session Count';

  @override
  String get colViewPatient => 'View Patient';

  @override
  String get colUnitName => 'Unit Name';

  @override
  String get colTotal => 'Total';

  @override
  String get colTotalCount => 'Total Count';

  @override
  String get colTotalPatientRegister => 'Total Patient Register';

  @override
  String get colType => 'Type';

  @override
  String get colCount => 'Count';

  @override
  String get colEventName => 'Event Name';

  @override
  String get colEventCount => 'Event Count';

  @override
  String get colTreatmentId => 'Treatment ID';

  @override
  String get colSchemeName => 'Scheme Name';

  @override
  String get colViralLoadStatus => 'Viral Load Status';

  @override
  String get colInvoiceAmount => 'Invoice Amount';

  @override
  String get colMonthYear => 'Month-Year';

  @override
  String get colMjpjayCount => 'MJPJAY Count';

  @override
  String get colNonMjpjayCount => 'Non-MJPJAY Count';

  @override
  String get colTicketTypeDataCorrection => 'Ticket Types\nData Correction';

  @override
  String get colTicketTypeNewRequirement => 'Ticket Types\nNew Requirement';

  @override
  String get colTicketTypeOperatorIssue => 'Ticket Types\nOperator Issue';

  @override
  String get colTicketTypeSoftwareServices => 'Ticket Types\nSoftware Services';

  @override
  String get colTicketTypeBug => 'Ticket Types\nBug';

  @override
  String get colTicketTypeEnhancement => 'Ticket Types\nEnhancement';

  @override
  String get colComplaintTypeDenialOfService =>
      'Complaint Types\nDenial of Service';

  @override
  String get colComplaintTypeMoneyTaken =>
      'Complaint Types\nMoney Taken Against Treat';

  @override
  String get colTestTypePending => 'Test Types\nPending';

  @override
  String get colTestTypeComplete => 'Test Types\nComplete';

  @override
  String get dashShowData => 'Show Data';

  @override
  String get dashPending => 'Pending';

  @override
  String get dashComplete => 'Complete';

  @override
  String get dashTotalPending => 'Total Pending';

  @override
  String get dashTotalComplete => 'Total Complete';

  @override
  String get dashSchemeMjpjay => 'MJPJAY';

  @override
  String get dashSchemeNonMjpjay => 'Non-MJPJAY';

  @override
  String get dashToday => 'Today';

  @override
  String get dashFromDate => 'From Date';

  @override
  String get dashToDate => 'To Date';

  @override
  String get dashSelectDate => 'Select Date';

  @override
  String get dashCurrentDate => 'Current Date';

  @override
  String get dashCurrentDay => 'Current Day';

  @override
  String get dashTillDate => 'Till Date';

  @override
  String get dashDateWise => 'Date Wise';

  @override
  String get dashWorking => 'Working';

  @override
  String get dashSchemePerformance => 'Scheme Performance';

  @override
  String get dashPatientRegistration => 'Patient Registration';

  @override
  String get dashPatientAddedList => 'Patient Added List';

  @override
  String get dashAbhaRegistration => 'ABHA Registration';

  @override
  String get dashDialysisSessions => 'Dialysis Sessions';

  @override
  String get dashDialysisSession => 'Dialysis Session';

  @override
  String get dashDialysisCancelled => 'Dialysis Cancelled';

  @override
  String get dashDialysisCancel => 'Dialysis Cancel';

  @override
  String get dashTotalDialysisCancelled => 'Total Dialysis Cancelled';

  @override
  String get dashOnlineComplaints => 'Online Complaints';

  @override
  String get dashTotalOnlineComplaints => 'Total Online Complaints';

  @override
  String get dashOnlineTickets => 'Online Tickets';

  @override
  String get dashFeedbackTitle => 'Feedback';

  @override
  String get dashDateWiseFeedback => 'Date Wise Feedback';

  @override
  String get dashLabTestAssigned => 'Laboratory Test Assigned';

  @override
  String get dashDateWiseLabTest => 'Date Wise Laboratory Test Assigned';

  @override
  String get dashTotalLabTestAssigned => 'Total Laboratory Test Assigned';

  @override
  String get dashEventOccurred => 'Event Occurred';

  @override
  String get dashDateWiseEvents => 'Date Wise Events';

  @override
  String get dashTotalAdverseEvent => 'Total Adverse Event';

  @override
  String get dashComplaintDashboardDown => 'Dashboard Down';

  @override
  String get dashComplaintMachineNotWorking => 'Machine Not Working';

  @override
  String get dashComplaintDenialOfServices => 'Denial of Services';

  @override
  String get dashComplaintMoneyTaken => 'Money taken against treatment';

  @override
  String get dashTicketDataCorrection => 'Data Correction';

  @override
  String get dashTicketNewRequirement => 'New Requirement';

  @override
  String get dashTicketOperatorIssue => 'Operator Issue';

  @override
  String get dashTicketSoftwareServices => 'Software Services';

  @override
  String get dashTicketBug => 'Bug';

  @override
  String get dashTicketEnhancement => 'Enhancement';

  @override
  String get dashCentralDashboard => 'Central Dashboard';

  @override
  String get dashTotalFunctionalUnit => 'Total Functional Unit';

  @override
  String get dashTotalProjectedCenter => 'Total Projected Center';

  @override
  String get dashFunctionalCenter => 'Functional Center';

  @override
  String get dashTotalDialysisPatient => 'Total Dialysis Patient';

  @override
  String get dashTotalPatient => 'Total Patient';

  @override
  String get dashTotalPatientRegistration => 'Total Patient Registration';

  @override
  String get dashTotalAbhaPatient => 'Total ABHA Patient';

  @override
  String get dashTotalAbhaRegistration => 'Total ABHA Registration';

  @override
  String get dashTotalDialysisSessions => 'Total Dialysis Sessions';

  @override
  String get dashTotalMachines => 'Total Machines';

  @override
  String get dashAdverseEvents => 'Adverse Events';

  @override
  String get dashAdverseEvent => 'Adverse Event';

  @override
  String get dashTickets => 'Tickets';

  @override
  String get dashTotalTickets => 'Total Tickets';

  @override
  String get dashTotalFeedback => 'Total Feedback';

  @override
  String get dashTotalInvoiceAmount => 'Total Invoice Amount';

  @override
  String get dashCurrentMonth => 'Current Month';

  @override
  String get dashTotalPayment => 'Total Payment';

  @override
  String get dashDialysisPerformance => 'Dialysis Performance';

  @override
  String get dashClusterDistrictDashboard => 'Cluster District Dashboard';

  @override
  String get dashClusterDivisionDashboard => 'Cluster Division Dashboard';

  @override
  String get dashCurrentDatePatientRegistered =>
      'Current Date Patient Registered';

  @override
  String get dashDateWisePatientRegistered =>
      'Date Wise Patient Registered Count';

  @override
  String get dashCurrentDateAbhaRegistration =>
      'Current Date ABHA Registration';

  @override
  String get dashDateWiseAbhaPatient => 'Date Wise ABHA Patient Count';

  @override
  String get dashCurrentDateDialysisSession => 'Current Date Dialysis Session';

  @override
  String get dashDateWiseDialysisSession => 'Date Wise Dialysis Session Count';

  @override
  String get dashCurrentDateDialysisCancelled =>
      'Current Date Dialysis Cancelled';

  @override
  String get dashDateWiseDialysisCancel => 'Date Wise Dialysis Cancel Count';

  @override
  String get dashCurrentDateLabTest => 'Current Date Laboratory Test Assigned';

  @override
  String get dashDateWiseTestAssign => 'Date Wise Test Assign Count';

  @override
  String get dashCurrentDateAdverseEvent => 'Current Date Adverse Event';

  @override
  String get dashDateWiseAdverseEvent => 'Date Wise Adverse Event Count';

  @override
  String get dashCurrentDateFeedback => 'Current Date Feedback';

  @override
  String get dashMisDashboard => 'MIS Dashboard';

  @override
  String get misFunctionalInstitute => 'Functional Institute';

  @override
  String get misNumberOfPatients => 'Number of Patients';

  @override
  String get misDialysisUnderMjpjay => 'Dialysis Treatment Under MJPJAY';

  @override
  String get misDialysisUnderNonMjpjay => 'Dialysis Treatment Under Non MJPJAY';

  @override
  String get misSeroPositive => 'Sero Positive Patients';

  @override
  String get misSeroNegative => 'Sero Negative Patients';

  @override
  String get misLabTestsSentToMahaLabs =>
      'Number of Laboratory Test sent to MAHA LABS';

  @override
  String get dashTotalDialysis => 'Total Dialysis';

  @override
  String get dashPatientVerification => 'Patient Verification';

  @override
  String get dashTotalEventOccurred => 'Total Event Occurred';

  @override
  String get dashTotalActiveMachines => 'Total Active Machines';

  @override
  String get dashTotalOnlineTickets => 'Total Online Tickets';

  @override
  String get scrutinyApproval => 'Scrutiny Approval';

  @override
  String get commonSearchBy => 'Search By';

  @override
  String get searchHintAppNoDateIdName =>
      'Application no, date, patient id, name';

  @override
  String get commonNoDataFoundDescription =>
      'We are unable to find the data you are looking for.';

  @override
  String get patientDetailsTitle => 'Patient Details';

  @override
  String get viewApplication => 'View Application';

  @override
  String get tabApplicationDetails => 'Application Details';

  @override
  String get tabServiceDescription => 'Service Description';

  @override
  String get colApplicationNo => 'Application No';

  @override
  String get colApplicationDate => 'Application Date';

  @override
  String get colApplicationNumber => 'Application Number';

  @override
  String get colApplicantName => 'Applicant Name';

  @override
  String get colServiceName => 'Service Name';

  @override
  String get colBloodGroup => 'Blood Group';

  @override
  String get colHeight => 'Height';

  @override
  String get colWeight => 'Weight';

  @override
  String get colDateOfRegistration => 'Date Of Registration';

  @override
  String get colNephrologistName => 'Nephrologist Name';

  @override
  String get colRelativeName => 'Relative Name';

  @override
  String get colRelativeContact => 'Relative Contact';

  @override
  String get colAbhaNumber => 'ABHA Number';

  @override
  String get colTreatmentUnderScheme => 'Treatment Under Scheme';

  @override
  String get nephroOngoingDialysisSession => 'Ongoing Dialysis Session';

  @override
  String get nephroAnswer => 'Answer';

  @override
  String get nephroAction => 'Action';

  @override
  String get nephroDescription => 'Description';

  @override
  String get nephroRemark => 'Remark';

  @override
  String get nephroEnterHint => 'Enter';

  @override
  String get nephroApprove => 'Approve';

  @override
  String get nephroReject => 'Reject';

  @override
  String get nephroSendBack => 'Send Back';

  @override
  String get nephroLevel1 => 'Level 1';

  @override
  String get nephroLevel2 => 'Level 2';

  @override
  String get nephroFillMandatory => 'Please fill mandatory field';

  @override
  String get chartMjpjayCounts => 'MJPJAY Counts';

  @override
  String get chartNonMjpjayCounts => 'Non-MJPJAY Counts';

  @override
  String get commonInfo => 'Info';

  @override
  String get commonDocument => 'Document';

  @override
  String get regNewRegistration => 'New Registration';

  @override
  String get regEditPatientDetails => 'Edit Patient Details';

  @override
  String get regViewPatientDetails => 'View Patient Details';

  @override
  String get tabPersonalInfo => 'Personal Info';

  @override
  String get tabDemographicInfo => 'Demographic Info';

  @override
  String get tabHistoryOfDialysis => 'History Of Dialysis';

  @override
  String get tabUploadDocument => 'Upload Document';

  @override
  String get regPatientInformation => 'Patient Information';

  @override
  String get regPermanentAddress => 'Permanent Address';

  @override
  String get regResidentialAddress => 'Residential Address';

  @override
  String get regSocioEcoStatus => 'Socio-Eco Status';

  @override
  String get regEmergencyRelativeInfo => 'Emergency Relative Info';

  @override
  String get regSameAsResidential => 'Per. Address Is Same As Res. Address';

  @override
  String get regFirstTimeDialysis => 'First Time Dialysis?';

  @override
  String get regPatientName => 'Patient Name';

  @override
  String get regPrefix => 'Prefix';

  @override
  String get regFirstName => 'First Name';

  @override
  String get regMiddleName => 'Middle Name';

  @override
  String get regLastName => 'Last Name';

  @override
  String get regDob => 'DOB';

  @override
  String get regEmailId => 'Email Id';

  @override
  String get regContactNo => 'Contact No';

  @override
  String get regContactNumber => 'Contact Number';

  @override
  String get regHeightFt => 'Height (In Ft.)';

  @override
  String get regHeightCm => 'Height (In cm.)';

  @override
  String get regWeight => 'Weight (Kg-Grams)';

  @override
  String get regMaritalStatus => 'Marital Status';

  @override
  String get regReligion => 'Religion';

  @override
  String get regEducation => 'Education';

  @override
  String get regOccupation => 'Occupation';

  @override
  String get regMonthlyIncome => 'Monthly Income';

  @override
  String get regNationality => 'Nationality';

  @override
  String get regCountry => 'Country';

  @override
  String get regAbhaId => 'ABHA ID';

  @override
  String get regAbhaNo => 'ABHA NO';

  @override
  String get regAbhaAddress => 'ABHA Address';

  @override
  String get regIdProof => 'Id Proof';

  @override
  String get regIdentificationNumber => 'Identification Number';

  @override
  String get regSchemeAdopted => 'Scheme Adopted';

  @override
  String get regMjpjayEnrollmentNo => 'MJPJAY Enrollment No';

  @override
  String get regViralMarkerStatus => 'Viral Marker Status';

  @override
  String get regAddress => 'Address';

  @override
  String get regPinCode => 'Pin Code';

  @override
  String get regState => 'State';

  @override
  String get regDistrict => 'District';

  @override
  String get regDivision => 'Division';

  @override
  String get regTaluka => 'Taluka';

  @override
  String get regTown => 'Town';

  @override
  String get regReferredBy => 'Referred By';

  @override
  String get regReferenceByName => 'Reference By Name';

  @override
  String get regReferredContactNumber => 'Referred Contact Number';

  @override
  String get regNephrologistName => 'Nephrologist Name';

  @override
  String get regNephrologistContactNo => 'Nephrologist Contact No';

  @override
  String get regRelation => 'Relation';

  @override
  String get regRelativeName => 'Relative Name';

  @override
  String get regDialysisMode => 'Dialysis Mode';

  @override
  String get regDialysisFreqWeek => 'Dialysis Frequency in Week';

  @override
  String get regFirstDialysisSessionDate => 'First Dialysis Session Date';

  @override
  String get regLastDialysisSessionDate => 'Last Dialysis Session Date';

  @override
  String get regLastDialysisHospitalName => 'Last Dialysis Hospital Name';

  @override
  String get regHintSelect => 'Select';

  @override
  String get regHintSelectTitle => 'Select Title';

  @override
  String get regHintEnter => 'Enter';

  @override
  String get regHintEnterName => 'Enter name';

  @override
  String get regHintEnterFirstName => 'Enter first name';

  @override
  String get regHintEnterMiddleName => 'Enter middle name';

  @override
  String get regHintEnterLastName => 'Enter last name';

  @override
  String get regHintEnterAddress => 'Enter address';

  @override
  String get regHintEnterPinCode => 'Enter pin code';

  @override
  String get regHintEnterContactNumber => 'Enter contact number';

  @override
  String get regHintEnterEmail => 'Enter Email address';

  @override
  String get regHintEnterNumber => 'Enter number';

  @override
  String get regHintFeetInches => 'Enter In Feet and Inches';

  @override
  String get regUploadDocument => 'Upload Document';

  @override
  String get regBrowseChooseFiles =>
      'Browse and choose the files you want to upload';

  @override
  String get regMaxFileSize => 'Max File Size : 10 MB';

  @override
  String get regSupportedFormats => 'Supported Formats : JPEG, PNG, PDF';

  @override
  String get regSaveNext => 'Save & Next';

  @override
  String get regCompleteDemographicFirst =>
      'Please complete Demographic Information first';

  @override
  String get regCompleteHistoryFirst =>
      'Please complete History of Dialysis first';

  @override
  String get regCompletePersonalFirst =>
      'Please complete Personal Information first';

  @override
  String get regFillMandatory => 'Please fill mandatory details';

  @override
  String get regSelectDocument => 'Please select document';

  @override
  String get regUploadRequiredDocuments => 'Please upload Required Documents';

  @override
  String get regUpdatedSuccessfully => 'Updated Successfully';

  @override
  String get regMobileExists => 'Mobile number already exists';

  @override
  String get regUploadFailed => 'Upload failed';

  @override
  String get regUploadPhotoSize => 'Upload photo below 500KB';

  @override
  String regPleaseNotePatientId(String id) {
    return 'Please note Patient Id $id';
  }

  @override
  String get regPrintReport => 'Print Report?';

  @override
  String get regRegistrationCompleted => 'Registration Completed Successfully';

  @override
  String get regRegisteredPatients => 'Registered Patients';

  @override
  String get regSelectScheme => 'Select Scheme';

  @override
  String get regSearchPatientHint => 'Patient Id, name, mobile no etc.';

  @override
  String get regDialysisCenter => 'Dialysis Center';

  @override
  String get regPatientAge => 'Patient Age';

  @override
  String get patientCardRefBy => 'Ref. By';

  @override
  String get commonValue => 'Value';

  @override
  String get commonPrint => 'Print';

  @override
  String get commonProcessing => 'Processing';

  @override
  String get commonStart => 'Start';

  @override
  String get patientCardDob => 'Date Of Birth';

  @override
  String get schedAddSchedular => 'Add Dialysis Scheduler';

  @override
  String get schedBookAppointment => 'Book Appointment';

  @override
  String get schedVisitorEntry => 'Visitor Entry';

  @override
  String get schedPatientHistory => 'Patient History';

  @override
  String get schedDialysisScheduleChart => 'Dialysis Schedule Chart';

  @override
  String get schedDialysisPatientList => 'Dialysis Patient List';

  @override
  String get schedCaseHistory => 'Case History';

  @override
  String get schedDialysisDetails => 'Dialysis Details';

  @override
  String get schedPatientDocuments => 'Patient Documents';

  @override
  String get schedSearchPatient => 'Search Patient';

  @override
  String get schedSlot => 'Slot';

  @override
  String get schedSlotTime => 'Slot Time';

  @override
  String get schedBedsAllocated => 'Beds Allocated';

  @override
  String get schedBedNo => 'Bed No.';

  @override
  String get schedMachineName => 'Machine Name';

  @override
  String get schedAppointmentDate => 'Appointment Date';

  @override
  String get schedVisitDate => 'Visit Date';

  @override
  String get schedVisitTime => 'Visit Time';

  @override
  String get schedIpNumber => 'IP Number';

  @override
  String get schedMjpjayCaseNumber => 'MJPJAY Case Number';

  @override
  String get schedMjpjayClaimNumber => 'MJPJAY Claim Number';

  @override
  String get schedMjpjayEnrollmentId => 'MJPJAY Enrollment Id';

  @override
  String get schedPreAuthApprovalDate => 'Pre Auth Approval Date';

  @override
  String get schedPreAuthNumber => 'Pre Auth Number';

  @override
  String get schedDocumentName => 'Document Name:';

  @override
  String get schedNoDocuments => 'No documents available';

  @override
  String get schedDataSaved => 'Data Saved Successfully';

  @override
  String get schedDataSaveFailed => 'Data Save Failed';

  @override
  String get schedDischargeSummary => 'Discharge Summary';

  @override
  String get schedSessionEndReport => 'Session End Report';

  @override
  String get schedHbsagPositive => 'HBsAg Positive';

  @override
  String get schedHcvPositive => 'HCV Positive';

  @override
  String get schedHivPositive => 'HIV Positive';

  @override
  String get schedHhhNegative => 'HHH Negative';

  @override
  String get clinAccessSite => 'Access Site';

  @override
  String get clinActualFbv => 'Actual FBV';

  @override
  String get clinBloodPressure => 'Blood Pressure';

  @override
  String get clinBloodTubingBarcode => 'Blood Tubing Barcode No./Sr. No';

  @override
  String get clinBloodTubingReuseNo => 'Blood Tubing Reuse No';

  @override
  String get clinCaseNarration => 'Case Narration';

  @override
  String get clinDialyserType => 'Dialyser Type';

  @override
  String get clinDialyzerType => 'Dialyzer Type';

  @override
  String get clinDialysisDuration => 'Dialysis Duration';

  @override
  String get clinDialysisStartDateTime => 'Dialysis Start Date and Time';

  @override
  String get clinDialysisStopDateTime => 'Dialysis Stop Date and Time';

  @override
  String get clinDialysisType => 'Dialysis Type';

  @override
  String get clinDialyzerBarcode => 'Dialyzer Barcode No./Sr. No';

  @override
  String get clinDialyzerDiscarded => 'Dialyzer Discarded';

  @override
  String get clinDialyzerRemark => 'Dialyzer Remark';

  @override
  String get clinDialyzerReuseNo => 'Dialyzer Reuse No';

  @override
  String get clinDryWeight => 'Dry Weight';

  @override
  String get clinHeparin => 'Heparin';

  @override
  String get clinInterdialyticGain => 'Interdialytic Gain';

  @override
  String get clinOxygenLevel => 'Oxygen Level';

  @override
  String get clinPostDialysisInjection => 'Post Dialysis Injection/Medicine';

  @override
  String get clinPostDialysisInvestigation => 'Post Dialysis Investigation';

  @override
  String get clinPostDialysisWeight => 'Post Dialysis Weight';

  @override
  String get clinPreDialysisInvestigation => 'Pre Dialysis Investigation';

  @override
  String get clinPreDialysisVitals => 'Pre Dialysis Vitals';

  @override
  String get clinPreDialysisWeight => 'Pre Dialysis Weight';

  @override
  String get clinPreHdCondition => 'Pre HD Condition';

  @override
  String get clinPulse => 'Pulse';

  @override
  String get clinRespiratoryRate => 'Respiratory Rate';

  @override
  String get clinSpecialDialysis => 'Special Dialysis';

  @override
  String get clinTemperature => 'Temperature';

  @override
  String get clinBloodTubingRemark => 'Blood Tubing Remark';

  @override
  String get clinCurrentSessionWeightDiff =>
      'Current Dialysis Session Weight Difference';

  @override
  String get clinKtv => 'kt/v';

  @override
  String get clinUfAchieved => 'UF Achieved';

  @override
  String get clinUfr => 'UFR';

  @override
  String get clinTmp => 'TMP';

  @override
  String get clinVp => 'VP';

  @override
  String get clinAp => 'AP';

  @override
  String get clinBfr => 'BFR';

  @override
  String get clinCbv => 'CBV';

  @override
  String get clinCond => 'Cond';

  @override
  String get clinTsat => 'TSAT (%)';

  @override
  String get clinEpoDose => 'EPO Dose';

  @override
  String get clinEpoAdministered => 'EPO Administered';

  @override
  String get clinBolusDose => 'Bolus Dose';

  @override
  String get clinInfusionDose => 'Infusion Dose';

  @override
  String get clinBpMmhg => 'BP(mmHg)';

  @override
  String get clinBloodPressureMmhg => 'Blood Pressure\n(mmHg)';

  @override
  String get clinPreDialysisDate => 'Pre Dialysis Date';

  @override
  String get clinDiscardedRemarks => 'Discarded Remarks';

  @override
  String get clinNewDialyzer => 'New Dialyzer';

  @override
  String get dqHdChart => 'HD Chart';

  @override
  String get dqHdChartList => 'HD Chart List';

  @override
  String get dqPreDialysisDetails => 'Pre Dialysis Details';

  @override
  String get dqPostDialysisDetails => 'Post Dialysis Details';

  @override
  String get dqEditPreDialysisDetails => 'Edit Pre Dialysis Details';

  @override
  String get dqPreDialysisPatientList => 'Pre Dialysis Patient List';

  @override
  String get dqPostDialysisPatientList => 'Post Dialysis Patient List';

  @override
  String get dqDialysisEventDetails => 'Dialysis Event Details';

  @override
  String get dqEventQueuedPatientList => 'Event Queued Patient List';

  @override
  String get dqInvestigationQueue => 'Investigation Queue';

  @override
  String get dqAllTest => 'All Test';

  @override
  String get dqTrendAnalysis => 'Trend Analysis';

  @override
  String get dqWeightTrendAnalysis => 'Weight Trend Analysis';

  @override
  String get dqTemperatureTrendAnalysis => 'Temperature Trend Analysis';

  @override
  String get dqCoverSheet => 'Cover Sheet';

  @override
  String get dqSafetyChecks => 'Safety Checks';

  @override
  String get dqClinicalHistory => 'Clinical History';

  @override
  String get dqClinicalCondition => 'Clinical Condition';

  @override
  String get dqDiagnosticInv => 'Diagnostic Inv';

  @override
  String get dqDiet => 'Diet';

  @override
  String get dqDietDetails => 'Diet Details';

  @override
  String get dqInstruction => 'Instruction';

  @override
  String get dqInstructionDetails => 'Instruction Details';

  @override
  String get dqPrescription => 'Prescription';

  @override
  String get dqPrescriptionDetails => 'Prescription Details';

  @override
  String get dqLaboratoryInvestigation => 'Laboratory Investigation';

  @override
  String get dqPhysicalEntryConsumable => 'Physical Entry of Consumable Used';

  @override
  String get dqAddEntryConsumable => 'Add New Entry of Consumable Used';

  @override
  String get dqHistory => 'History';

  @override
  String get dqPrePostEventInvestigation => 'Pre-Post-Event Investigation';

  @override
  String get dqStartDialysis => 'Start Dialysis';

  @override
  String get dqStopDialysis => 'Stop Dialysis';

  @override
  String get dqAnalyze => 'Analyze';

  @override
  String get dqAddBarcodeNo => 'Add Barcode No.';

  @override
  String get dqInvalidInput => 'Invalid Input';

  @override
  String get dqSaveFailed => 'Save Failed';

  @override
  String get dqFailSaveMachineReading => 'Failed to save machine reading';

  @override
  String get dqProductShouldNotSame => 'Product should not be the same';

  @override
  String get dqPreDialysisTab => 'Pre-dialysis';

  @override
  String get dqPostDialysisTab => 'Post-dialysis';

  @override
  String get dqActionTaken => 'Action Taken';

  @override
  String get dqAvailableQuantity => 'Available Quantity';

  @override
  String get dqBarcodeNo => 'Barcode No';

  @override
  String get dqBatchNo => 'Batch No';

  @override
  String get dqConsumedQuantity => 'Consumed Quantity';

  @override
  String get dqDialysisIncidentType => 'Dialysis Incident Type';

  @override
  String get dqDialysisIncidentSubType => 'Dialysis Incident sub Type';

  @override
  String get dqDuration => 'Duration';

  @override
  String get dqEventDescription => 'Event Description';

  @override
  String get dqExpiryDate => 'Expiry Date';

  @override
  String get dqOrderId => 'Order Id';

  @override
  String get dqProductName => 'Product Name';

  @override
  String get dqQuantity => 'Quantity';

  @override
  String get dqTestId => 'Test ID';

  @override
  String get dqTestName => 'Test Name';

  @override
  String get dqCounter => 'Counter';

  @override
  String get commonActive => 'Active';

  @override
  String get commonComments => 'Comments';

  @override
  String get commonReason => 'Reason';

  @override
  String get commonQuantity => 'Quantity';

  @override
  String get commonDays => 'Days';

  @override
  String get commonUnit => 'Unit';

  @override
  String get clinBloodGlucose => 'Blood Glucose';

  @override
  String get clinPastSurgicalHistory => 'Past Surgical History';

  @override
  String get clinMedicationMethod => 'Medication Method';

  @override
  String get clinAlcoholConsumption => 'Alcohol Consumption';

  @override
  String get clinAlcoholCurrentStat => 'Alcohol Current Stat';

  @override
  String get clinAlcoholDuration => 'Alcohol Duration';

  @override
  String get clinDrugCurrentStat => 'Drug Current Stat';

  @override
  String get clinDrugDuration => 'Drug Duration';

  @override
  String get clinIllicitDrug => 'Illicit Drug';

  @override
  String get clinSmoking => 'Smoking';

  @override
  String get clinSmokingCurrentStat => 'Smoking Current Stat';

  @override
  String get clinSmokingDuration => 'Smoking Duration';

  @override
  String get clinTobaccoConsumption => 'Tobacco Consumption';

  @override
  String get clinTobaccoCurrentStat => 'Tobacco Current Stat';

  @override
  String get clinTobaccoDuration => 'Tobacco Duration';

  @override
  String get nephroClinicalNotes => 'Clinical Notes';

  @override
  String get nephroDiagnosisDescription => 'Diagnosis & Description';

  @override
  String get nephroDosage => 'Dosage';

  @override
  String get nephroFrequency => 'Frequency';

  @override
  String get nephroRoute => 'Route';

  @override
  String get nephroPrep => 'Prep';

  @override
  String get nephroTemplate => 'Template';

  @override
  String get nephroIcd10Code => 'ICD10 Code';

  @override
  String get nephroInstructions => 'Instructions';

  @override
  String get nephroInstructionEnglish => 'Instruction in English';

  @override
  String get nephroInstructionMarathi => 'Instruction in Marathi';

  @override
  String get nephroInstructionHindi => 'Instruction in Hindi';

  @override
  String get nephroOtherLanguage1 => 'Other Language 1';

  @override
  String get nephroOtherLanguage2 => 'Other Language 2';

  @override
  String get nephroOtherLanguage3 => 'Other Language 3';

  @override
  String get nephroDiagnosisType => 'Diagnosis Type';

  @override
  String get nephroDiet => 'Diet';

  @override
  String get nephroSpecialInstructions => 'Special Instructions';

  @override
  String get nephroTreatmentPlan => 'Treatment Plan';

  @override
  String get nephroAddDetails => 'Add Details';

  @override
  String get nephroAddNewInstruction => 'Add New Instruction';

  @override
  String get nephroAddToTest => 'Add to Test';

  @override
  String get nephroViewReport => 'View Report';

  @override
  String get nephroChooseTest => 'Choose Test';

  @override
  String get nephroMedicineName => 'Medicine Name';

  @override
  String get nephroTestName => 'Test Name';

  @override
  String get nephroDiagnosis => 'Diagnosis';

  @override
  String get nephroClinicalHistory => 'Clinical History';

  @override
  String get nephroClinicalHistoryStatus => 'Clinical History Status';

  @override
  String get nephroInvestigationScheduling =>
      'Investigation Test Scheduling Details';

  @override
  String get nephroNoPrescriptions => 'No prescriptions found';

  @override
  String get nephroGeneralInfo => 'General Info';

  @override
  String get nephroOnExamination => 'ON EXAMINATION';

  @override
  String get nephroSystematicExaminations => 'SYSTEMATIC EXAMINATIONS';

  @override
  String get nephroSelectFileToUpload => 'Select File to Upload';

  @override
  String get nephroEnterComments => 'Enter Comments';

  @override
  String get nephroDeleteInstructionConfirm =>
      'Are you sure you want to delete this instruction?';

  @override
  String get nephroConfirmed => 'Confirmed';

  @override
  String get nephroProvisional => 'Provisional';

  @override
  String get nephroUrgent => 'Urgent';

  @override
  String get nephroBmi => 'BMI';

  @override
  String get nephroMachineNo => 'Machine No.';

  @override
  String get nephroNephrologistName => 'Nephrologist Name';

  @override
  String get nephroRegistrationDate => 'Registration Date';

  @override
  String get nephroPatientMobileNo => 'Patient Mobile No';

  @override
  String get nephroRelativeName => 'Relative Name';

  @override
  String get nephroAssignedToTechnician => 'Assigned To Technician';

  @override
  String get nephroClinicalConditionSaved => 'Clinical Condition Saved';

  @override
  String get nephroDocumentDeleted => 'Document Deleted';

  @override
  String get nephroEnterTest => 'Enter Test';

  @override
  String get nephroSelectCheckbox => 'Please select checkbox';

  @override
  String get nephroRecordUpdated => 'Record Updated Successfully';

  @override
  String get nephroTestAdded => 'Test Added';

  @override
  String get nephroTestAddFail => 'Test Adding Failed';

  @override
  String get nephroDiagnosisDeleted => 'Diagnosis Deleted Successfully';

  @override
  String get nephroErrorSavingDiet => 'Error saving diet';

  @override
  String get nephroFailedSaveDiet => 'Failed to save diet';

  @override
  String get nephroRecordsDeleted => 'Records Deleted Successfully';

  @override
  String get nephroUnauthorized => 'Unauthorized request';

  @override
  String get nephroAddTestsPackages => 'Add Tests/Packages';

  @override
  String get nephroSelectPackage => 'Select Package';

  @override
  String nephroUploadError(Object error) {
    return 'Upload error: $error';
  }

  @override
  String get commonApprove => 'Approve';

  @override
  String get commonGenerate => 'Generate';

  @override
  String get dischTermsConditions => 'Terms & Conditions';

  @override
  String get dischDischarge => 'Discharge';

  @override
  String get dischSessionEndPatientList => 'Session End Patient List';

  @override
  String get dischApprovalStatus => 'Approval Status';

  @override
  String get dischDialysisDate => 'Dialysis Date';

  @override
  String get machMachineCounter => 'Machine Counter';

  @override
  String get machMachineFilter => 'Machine Filter';

  @override
  String get machAddMachineCounter => 'Add Machine Counter';

  @override
  String get machMachineName => 'Machine Name';

  @override
  String get billInvoiceApprovalSecondLevel => 'INVOICE APPROVAL (2nd LEVEL)';

  @override
  String get billInvoiceGeneration => 'INVOICE Generation';

  @override
  String get billFilterInvoice => 'Filter Invoice';

  @override
  String get billServiceCertificate => 'Service Certificate';

  @override
  String get billViewServiceCertificate => 'View Service Certificate';

  @override
  String get billServiceCertificateDetails => 'Service Certificate\'s Details';

  @override
  String get billMonth => 'Month';

  @override
  String get billYear => 'Year';

  @override
  String get bookChooseSlot => 'Choose Slot';

  @override
  String get bookSelectInstitute => 'Select Institute';

  @override
  String get bookBookingFailed => 'Booking failed';

  @override
  String get bookHivPositive => 'HIV+';

  @override
  String get bookHepatitisCPositive => 'Hepatitis C+';

  @override
  String get bookNegative => 'Negative';

  @override
  String get photoTakePhoto => 'Take Photo';

  @override
  String get photoCapturePhoto => 'Capture Photo';

  @override
  String get photoDataSaved => 'Data saved successfully';

  @override
  String photoUploadFailed(Object reason) {
    return 'Upload failed: $reason';
  }

  @override
  String get cctvCameraDetails => 'CCTV Camera Details';

  @override
  String get cctvCamera => 'CCTV Camera';

  @override
  String get uploadDocuments => 'Upload Documents';

  @override
  String get uploadNoDocument => 'No document available';

  @override
  String get uploadUploading => 'Uploading...';

  @override
  String get uploadCropPhoto => 'Crop Photo';

  @override
  String get uploadFeedback => 'Feedback';

  @override
  String get uploadHdChart => 'HD Chart';

  @override
  String get uploadTreatmentDate => 'Treatment Date';

  @override
  String uploadUploadedOn(Object dateTime) {
    return 'Uploaded on: $dateTime';
  }

  @override
  String get roDisinfectionDetails => 'RO Disinfection Details';

  @override
  String get roLogSheet => 'RO Log Sheet';

  @override
  String get roAddLogSheet => 'Add RO Log Sheet';

  @override
  String get roDailyLogSheet => 'Daily RO Log Sheet';

  @override
  String get roMachineIssueLogs => 'RO Machine Issue Logs';

  @override
  String get roBackwash => 'Backwash';

  @override
  String get roRinse => 'Rinse';

  @override
  String get roCallAttendedBy => 'Call Attended By';

  @override
  String get roCheckedBy => 'Checked By';

  @override
  String get roCorrectionAction => 'Correction Action';

  @override
  String get roDifference => 'Difference';

  @override
  String get roDoneBy => 'Done By';

  @override
  String get roImageName => 'Image Name';

  @override
  String get roInformationDate => 'Information Date';

  @override
  String get roInformedBy => 'Informed By';

  @override
  String get roInformedTo => 'Informed To';

  @override
  String get roInspectionDate => 'Inspection Date';

  @override
  String get roIssueDate => 'Issue Date';

  @override
  String get roIssueDescription => 'Issue Description';

  @override
  String get roNextInspectionDate => 'Next Inspection Date';

  @override
  String get roProblemResolved => 'Problem Resolved';

  @override
  String get roRange => 'Range';

  @override
  String get roSpecialNo => 'Please enter special no.';

  @override
  String get roTypeOfDisinfection => 'Type of Disinfection Used';

  @override
  String get roImageUpload => 'Image Upload';

  @override
  String get roSoftenerRegistration => 'Softener Registration';

  @override
  String get roLooplineTds => 'Loopline TDS (ppm)';

  @override
  String get roPostCarbonChlorine => 'Post Carbon Filter Chlorine (ppm)';

  @override
  String get roPostMembraneTds => 'Post Membrane TDS (ppm)';

  @override
  String get roPostMixbedTds => 'Post Mixbed TDS (ppm)';

  @override
  String get roPostSoftenerHardness => 'Post Softener Hardness (ppm)';

  @override
  String get roPostSoftenerTds => 'Post Softener TDS (ppm)';

  @override
  String get roProductPermeateFlow => 'Product / Permeate Flow (lph)';

  @override
  String get roRawWaterTdsPpm => 'Raw Water TDS (ppm)';

  @override
  String get roRejectFlowLph => 'Reject Flow (lph)';

  @override
  String get roCarbonFilterPressure => 'Carbon Filter Pressure (PSI)';

  @override
  String get roRoWaterTds => 'RO Water TDS (PPM)';

  @override
  String get roRawWaterTds => 'Raw Water TDS (PPM)';

  @override
  String get roReturnLoopPressure => 'Return Loop Pressure (PSI)';

  @override
  String get roSoftenerPressure => 'Softener Pressure (PSI)';

  @override
  String get roPre => 'Pre';

  @override
  String get roPost => 'Post';

  @override
  String get roPump => 'Pump';

  @override
  String get roWater => 'Water';

  @override
  String get roSand => 'Sand';

  @override
  String get roSandFilter => 'Sand Filter';

  @override
  String get roCarbon => 'Carbon';

  @override
  String get roCarbonFilter => 'Carbon Filter';

  @override
  String get roSoftner => 'Softener';

  @override
  String get roRawWaterPump => 'Raw Water Pump';

  @override
  String get roTransferPump => 'Transfer Pump';

  @override
  String get roUvLamp => 'UV Lamp';

  @override
  String get roSaveFailed => 'Save Failed';

  @override
  String get roSavedSuccessfully => 'Saved Successfully';

  @override
  String get phtPatientHealthTrends => 'Patient Health Trends';

  @override
  String get phtHaemoglobinTracking => 'Haemoglobin Tracking Report';

  @override
  String get phtInvestigationResultChart =>
      'Patient Dialysis Investigation Result Chart';

  @override
  String get phtVitalChart => 'Patient Dialysis Vital Chart';

  @override
  String get phtPatientVitalChart => 'Patient Vital Chart';

  @override
  String get phtGenerateReport => 'Generate Report';

  @override
  String get phtShowRecord => 'Show Record';

  @override
  String get phtShowReport => 'Show Report';

  @override
  String get phtVitalParameters => 'Vital Parameters';

  @override
  String get phtValuesByDate => 'Values By Date';

  @override
  String get phtSelectDateRange => 'Select Date Range';

  @override
  String get phtSearchPatient => 'Search Patient';

  @override
  String get phtSelectDateRangeTap => 'Select a date range and tap';

  @override
  String get phtNoVitalData => 'No Vital Data Available';

  @override
  String get phtNoChartData => 'No chart data available';

  @override
  String get phtNoValidDataPoints => 'No valid data points to display';

  @override
  String get phtDataNotFound => 'Data Not Found';

  @override
  String phtLatestValue(Object value) {
    return 'Latest Value: $value';
  }

  @override
  String phtLatest(Object value) {
    return 'Latest: $value';
  }

  @override
  String get phtSearchHint => 'Search by patient name or id';

  @override
  String get dqPreDialysis => 'Pre Dialysis';

  @override
  String get dqPostDialysis => 'Post Dialysis';

  @override
  String get dqDialysisEvent => 'Dialysis Event';

  @override
  String get dqInvestigation => 'Investigation';

  @override
  String get dqConsumableEntry => 'Consumable Entry';

  @override
  String get roMachineLogSheet => 'RO Machine Log Sheet';

  @override
  String get phtMenuVitalChart => 'Dialysis Vital Chart';

  @override
  String get phtMenuInvestChart => 'Dialysis Investigation Result Chart';

  @override
  String get colParticulars => 'Particulars';

  @override
  String get colReport => 'Report';

  @override
  String get colDrugs => 'Drugs';

  @override
  String get colFreq => 'Freq';

  @override
  String get colPackageName => 'Package Name';

  @override
  String get colClinicalHistoryDate => 'Clinical History Date';

  @override
  String get colInstructionName => 'Instruction Name';

  @override
  String get colComorbidities => 'Comorbidities';

  @override
  String get colYesNo => 'Yes/No';

  @override
  String get nephroAddClinicalCondition => 'Add Clinical Condition';

  @override
  String get nephroEditClinicalCondition => 'Edit Clinical Condition';

  @override
  String get nephroConsultantName => 'Consultant Name';

  @override
  String get nephroEvent => 'Event';

  @override
  String get nephroChoosePackages => 'Choose Packages';

  @override
  String get nephroDeleteTest => 'Delete Test';

  @override
  String get nephroDeleteTestConfirm =>
      'Are you sure you want to delete this test?';

  @override
  String get nephroTestAlreadyAssigned =>
      'This test is already assigned to the patient';

  @override
  String get nephroAddPrescription => 'Add Prescription';

  @override
  String get nephroEditPrescription => 'Edit Prescription';

  @override
  String get nephroMorning => 'Morning';

  @override
  String get nephroAfternoon => 'Afternoon';

  @override
  String get nephroEvening => 'Evening';

  @override
  String get nephroNight => 'Night';

  @override
  String get nephroStrength => 'Strength';

  @override
  String get nephroDose => 'Dose';

  @override
  String get nephroPrescribedBy => 'Prescribed by';

  @override
  String get nephroAddDiet => 'Add Diet';

  @override
  String get nephroEditDiet => 'Edit Diet';

  @override
  String get nephroIndividualInstructions => 'Individual Instructions';

  @override
  String get nephroDeleteInstruction => 'Delete Instruction';

  @override
  String get nephroSaveInstructions => 'Save Instructions';

  @override
  String get schedDialysisCenter => 'Dialysis Center';

  @override
  String get schedState => 'State';

  @override
  String schedApprovalInProcess(String type) {
    return 'Approval from $type is in process';
  }

  @override
  String get schedFrequencyScheduleMismatch =>
      'Please schedule according to the selected frequency';

  @override
  String get schedSelectDateAndSlot => 'Please select date and slot';

  @override
  String get schedAlreadyBooked => 'Already Booked';

  @override
  String schedAppointmentAlreadyGiven(String date) {
    return 'Appointment already given on $date';
  }

  @override
  String get schedSlotNotAvailable => 'Slot Not Available';

  @override
  String schedOnThisDate(String date) {
    return 'On this date $date';
  }

  @override
  String get schedScheduleConfirmed => 'Schedule Confirmed';

  @override
  String get schedScheduleConfirmedMsg =>
      'Your schedule has been successfully confirmed.';

  @override
  String get schedAddSchedularFailed => 'Add Schedular Failed';

  @override
  String get schedViewLabInvest => 'View Lab Invest';

  @override
  String get schedAppointmentCancelled => 'Appointment Cancelled';

  @override
  String get schedAppointmentCancelledMsg =>
      'Appointment Cancelled Successfully';

  @override
  String get schedCancelAppointmentConfirm =>
      'Are you sure? Do you want to cancel the appointment?';

  @override
  String get clinFinalUfv => 'Final UFV';

  @override
  String get clinVenousPressure => 'Venous Pressure';

  @override
  String get clinBloodFlowQb => 'Blood Flow (QB)';

  @override
  String get clinDialysateFlowQd => 'Dialysate Flow (QD)';

  @override
  String get clinRrfUrineVolume => 'RRF Urine Volume (ml/Day)';

  @override
  String get clinPercentOfFbv => '% of FBV';

  @override
  String get commonNoConsultationDetails =>
      'No consultation details available.';

  @override
  String get commonChooseFile => 'Choose File';

  @override
  String get schedOxygenSupplyAvailable =>
      'Enough Oxygen Supply Available At The Bed';

  @override
  String get schedFuelAvailableGenset =>
      'Enough Fuel Available for GenSet at the Hospital';

  @override
  String get schedIronSucrose => 'Iron Sucrose';

  @override
  String get schedCurrentSessionUnderScheme =>
      'Current Dialysis Session Under The Scheme';

  @override
  String get schedLastSessionUnderScheme =>
      'Last Dialysis Session Under The Scheme';

  @override
  String get schedReasonNotRegisteredMjpjay =>
      'Reason for not registered on MJPJAY';

  @override
  String schedPendingSession(String count) {
    return 'Pending Session $count';
  }

  @override
  String schedEffectiveDatePendingSession(String date, String count) {
    return 'Effective Date $date and Pending Session $count';
  }

  @override
  String get bookConfirmBookAppointment =>
      'Are you sure?\nDo you want to book appointment';

  @override
  String get bookSelectBed => 'Please Select Bed';

  @override
  String get schedDieticianConsultationDone => 'Dietician Consultation Done';

  @override
  String get schedNephrologistComment => 'Nephrologist\'s Comment';

  @override
  String get schedPatientAbsent => 'Patient Absent';

  @override
  String get dqLastDialysisSession => 'Last dialysis session';

  @override
  String get clinAccessType => 'Access Type';

  @override
  String get clinExpectedFiberBundleVolume => 'Expected Fiber Bundle Volume';

  @override
  String get clinDialyzerBarcodeNo => 'Dialyzer Barcode No';

  @override
  String get clinTubeBarcodeNo => 'Tube Barcode No';

  @override
  String get clinTubeReuseNo => 'Tube Reuse No';

  @override
  String get clinBloodTubeRemark => 'Blood Tube Remark';

  @override
  String get clinNewBloodTubing => 'New Blood Tubing';

  @override
  String get clinPulseBeatsMin => 'Pulse\n(Beats/min)';

  @override
  String get clinOxygenLevelPercent => 'Oxygen Level (%)';

  @override
  String get clinRespiratoryRateBreathsMin => 'Respiratory Rate (Breaths/min)';

  @override
  String get commonBottom => 'Bottom';

  @override
  String get commonTop => 'Top';

  @override
  String get dqViewHistory => 'View History';

  @override
  String get dqDiscardedRemarksWarning =>
      'Kindly enter discarded remarks before using new dialyser and blood tubing';

  @override
  String get dqDialysisHistory => 'Dialysis History';

  @override
  String get dqTubeHistory => 'Tube History';

  @override
  String get clinCurrentWgtDiff => 'Current Wgt Diff';

  @override
  String get clinTotalHeparinUsed => 'Total Heparin Used';

  @override
  String get clinFinalKtv => 'Final KT/V';

  @override
  String get clinActualFiberBundleVolume => 'Actual Fiber Bundle Volume';

  @override
  String get clinPercentageFiberBundle => 'Percentage Fiber Bundle';

  @override
  String get clinLastHgb => 'Last Hgb (Hemoglobin):';

  @override
  String get clinIronPreparation => 'Iron Preparation';

  @override
  String get clinIronDose => 'Iron Dose';

  @override
  String get clinIronFrequency => 'Iron Frequency';

  @override
  String get clinIronRoute => 'Iron Route';

  @override
  String get clinIronStartDate => 'Iron Start Date';

  @override
  String get clinIronProtocolUsed => 'Iron Protocol Used';

  @override
  String get clinFerritinLevel => 'Ferritin Level';

  @override
  String get clinBloodTransfusionPost => 'Blood Transfusion (Post Dialysis)';

  @override
  String get clinVolumeMl => 'Volume (mL)';

  @override
  String get clinDialysisDurationRemark => 'Dialysis Duration Remark';

  @override
  String get clinDialysisDurationDescription => 'Dialysis Duration Description';

  @override
  String get clinEpoBrandName => 'EPO Brand Name';

  @override
  String get clinEpoFrequency => 'EPO Frequency';

  @override
  String get clinEpoRoute => 'EPO Route';

  @override
  String get clinEpoStartDate => 'EPO Start Date';

  @override
  String get clinEpoIndication => 'EPO Indication';

  @override
  String get dqHdTreatmentCount => 'Hd Treatment Count';

  @override
  String get clinPreDialysisWeightKgs => 'Pre-Dialysis Weight (kgs)';

  @override
  String get clinPostDialysisWeightKgs => 'Post Dialysis Weight (kgs)';

  @override
  String get clinIntradialyticWeightKgs => 'Intradialytic Weight (kgs)';

  @override
  String get clinDryWeightKgs => 'Dry Weight (kgs)';

  @override
  String get clinWeightLoss => 'Weight Loss';

  @override
  String get clinUfTarget => 'UF Target (Ltrs)';

  @override
  String get clinUfTargetAchieved => 'UF Target Achieved (Ltrs)';

  @override
  String get clinAirDetectorLineClamp => 'Air Detector / Line Clamp';

  @override
  String get clinAlarmLimitSet => 'Alarm Limit Set';

  @override
  String get clinHeparinPumpOn => 'Heparin Pump on';

  @override
  String get clinDialysateFlowMlMin => 'Dialysate Flow (ml/min)';

  @override
  String get clinPulseBpm => 'Pulse (bpm)';

  @override
  String get clinInjectionEpoIron => 'Injection EPO / Iron';

  @override
  String get clinDialysateTempC => 'Dialysate Temp (°C)';

  @override
  String get clinRespiratoryRateRpm => 'Respiratory Rate (rpm)';

  @override
  String get clinConcentrateNa => 'Concentrate Na+ (mmol / L)';

  @override
  String get clinTemperatureF => 'Temperature (°F)';

  @override
  String get clinPtTemperatureF => 'Pt. Temperature (°F)';

  @override
  String get clinConductivityMho => 'Conductivity (mho)';

  @override
  String get clinHdStartedBy => 'HD Started By';

  @override
  String get clinHdCompletedBy => 'HD Completed By';

  @override
  String get dischDietician => 'Dietician';

  @override
  String get dischTermsVerified =>
      'I have verified all dialysis stages and patient details';

  @override
  String get roMachineName => 'RO Machine Name';

  @override
  String get commonUploadImage => 'Upload Image';

  @override
  String get roAddDisinfectionDetails => 'Add RO Disinfection Details';

  @override
  String get roEditDisinfectionDetails => 'Edit RO Disinfection Details';

  @override
  String get roNextInspectionBeforeError =>
      'Next Inspection Date should not be before Inspection Date';

  @override
  String get roAddMachineIssueLog => 'Add RO Machine Issue Logs';

  @override
  String get roEditMachineIssueLog => 'Edit RO Machine Issue Logs';

  @override
  String get roSandFilterPressure => 'Sand Filter Pressure';

  @override
  String get commonInactive => 'Inactive';

  @override
  String get roSandFilterPressurePsi => 'Sand Filter Pressure (PSI)';

  @override
  String get roSoftenerAvailable => 'Softener Available';

  @override
  String get roHardnessPostSoftenerPpm =>
      'Hardness of Post Softener Water (PPM)';

  @override
  String get roBeforeRegenerationHardnessPpm =>
      'Before Regeneration Hardness (PPM)';

  @override
  String get roAfterRegenerationHardnessPpm =>
      'After Regeneration Hardness (PPM)';

  @override
  String get roPreMembranePressure => 'Pre Membrane Pressure';

  @override
  String get roRejectPressure => 'Reject Pressure';

  @override
  String get roPermeateFlowLph => 'Permeate Flow (LPH)';

  @override
  String get roCarbonChlorideWaterConductivity =>
      'Carbon Chloride and Water Conductivity';

  @override
  String get roPostCarbonChloridePpm => 'Post Carbon Chloride (PPM)';

  @override
  String get roRoWaterConductivity => 'RO Water Conductivity';

  @override
  String get roHighPressurePump => 'High Pressure Pump';

  @override
  String get roUfMicronFilter => 'UF/Micron Filter';

  @override
  String get roDosingSystem => 'Dosing System';

  @override
  String roValueLessThan(String value) {
    return 'Value must be less than $value';
  }

  @override
  String roValueGreaterThan(String value) {
    return 'Value must be greater than $value';
  }

  @override
  String roValueBetween(String min, String max) {
    return 'Value must be between $min and $max';
  }

  @override
  String get roEnterValidNumber => 'Please enter a valid number';

  @override
  String get roMachine => 'RO Machine';

  @override
  String get roAddDailyLogSheet => 'Add Daily RO Log Sheet';

  @override
  String get roEditDailyLogSheet => 'Edit Daily RO Log Sheet';

  @override
  String get commonParameter => 'Parameter';

  @override
  String get commonUnits => 'Units';

  @override
  String get commonValues => 'Values';

  @override
  String get roRawWaterTdsLabel => 'Raw Water TDS';

  @override
  String get roPostSoftenerTdsLabel => 'Post Softener TDS';

  @override
  String get roPostMembraneTdsLabel => 'Post Membrane TDS';

  @override
  String get roPostMixbedTdsLabel => 'Post Mixbed TDS';

  @override
  String get roLooplineTdsLabel => 'Loopline TDS';

  @override
  String get roPostSoftenerHardnessLabel => 'Post Softener Hardness';

  @override
  String get roPostCarbonFilterChlorineLabel => 'Post Carbon Filter Chlorine';

  @override
  String get roRejectFlowLabel => 'Reject Flow';

  @override
  String get roProductPermeateFlowLabel => 'Product / Permeate Flow';

  @override
  String get machMachineSerialNo => 'Machine Serial No.';

  @override
  String get uploadFeedbackForm => 'FeedBack Form';

  @override
  String get machTodaysReadingHours => 'Today\'s Reading (Hours)';

  @override
  String get machLastReadingHours => 'Last Reading (Hours)';
}

/// The translations for English, as used in France (`en_FR`).
class AppLocalizationsEnFr extends AppLocalizationsEn {
  AppLocalizationsEnFr() : super('en_FR');

  @override
  String get appTitle => 'MahaDialysis';

  @override
  String get languageLabel => 'Language / Langue';

  @override
  String get languageEnglish => 'English / Anglais';

  @override
  String get languageFrench => 'French / Français';

  @override
  String get changeLanguage => 'Change language / Changer de langue';

  @override
  String get languageTooltip => 'Change language / Changer de langue';

  @override
  String get commonSave => 'Save / Enregistrer';

  @override
  String get commonSubmit => 'Submit / Valider';

  @override
  String get commonCancel => 'Cancel / Annuler';

  @override
  String get commonClose => 'Close / Fermer';

  @override
  String get commonConfirm => 'Confirm / Confirmer';

  @override
  String get commonNext => 'Next / Suivant';

  @override
  String get commonPrevious => 'Previous / Précédent';

  @override
  String get commonBack => 'Back / Retour';

  @override
  String get commonEdit => 'Edit / Modifier';

  @override
  String get commonDelete => 'Delete / Supprimer';

  @override
  String get commonAdd => 'Add / Ajouter';

  @override
  String get commonUpdate => 'Update / Mettre à jour';

  @override
  String get commonView => 'View / Voir';

  @override
  String get commonSearch => 'Search / Rechercher';

  @override
  String get commonClear => 'Clear / Effacer';

  @override
  String get commonReset => 'Reset / Réinitialiser';

  @override
  String get commonApply => 'Apply / Appliquer';

  @override
  String get commonRefresh => 'Refresh / Actualiser';

  @override
  String get commonRetry => 'Retry / Réessayer';

  @override
  String get commonProceed => 'Proceed / Continuer';

  @override
  String get commonGoBack => 'Go Back / Retour';

  @override
  String get commonDone => 'Done / Terminé';

  @override
  String get commonSelect => 'Select / Sélectionner';

  @override
  String get commonUpload => 'Upload / Téléverser';

  @override
  String get commonDownload => 'Download / Télécharger';

  @override
  String get commonYes => 'Yes / Oui';

  @override
  String get commonNo => 'No / Non';

  @override
  String get commonOk => 'OK';

  @override
  String get commonLoading => 'Loading… / Chargement…';

  @override
  String get commonNoData => 'No data / Aucune donnée';

  @override
  String get commonNoDataFound => 'No data found / Aucune donnée trouvée';

  @override
  String get commonNoRecordsFound =>
      'No records found / Aucun enregistrement trouvé';

  @override
  String get commonSomethingWentWrong =>
      'Something went wrong / Une erreur s\'est produite';

  @override
  String get commonSuccess => 'Success / Succès';

  @override
  String get commonError => 'Error / Erreur';

  @override
  String get commonWarning => 'Warning / Avertissement';

  @override
  String get commonNote => 'Note / Remarque';

  @override
  String get commonPleaseSelect => 'Please select / Veuillez sélectionner';

  @override
  String get commonPleaseWait => 'Please wait… / Veuillez patienter…';

  @override
  String get commonSessionExpired =>
      'Session expired. Please log in again. / Session expirée. Veuillez vous reconnecter.';

  @override
  String get commonNoInternet =>
      'No internet connection / Pas de connexion Internet';

  @override
  String get commonCheckConnection =>
      'Please check your connection and try again / Veuillez vérifier votre connexion et réessayer';

  @override
  String get noInternetHeadline => 'Oh No / Oh non';

  @override
  String get noInternetMessage =>
      'No internet connection found. / Aucune connexion Internet détectée.';

  @override
  String get noInternetHint =>
      'Check your connection or try again. / Vérifiez votre connexion ou réessayez.';

  @override
  String get commonRequiredField =>
      'This field is required / Ce champ est obligatoire';

  @override
  String fieldRequired(String field) {
    return '$field is required / $field est obligatoire';
  }

  @override
  String fieldInvalid(String field) {
    return 'Please enter a valid $field / Veuillez saisir un(e) $field valide';
  }

  @override
  String get validationInvalidEmail =>
      'Please enter a valid email / Veuillez saisir une adresse e-mail valide';

  @override
  String get validationInvalidPan =>
      'Please enter a valid PAN / Veuillez saisir un PAN valide';

  @override
  String validationDigits(int count) {
    return 'Please enter a valid $count-digit number / Veuillez saisir un nombre valide de $count chiffres';
  }

  @override
  String validationMinDigits(int count) {
    return 'Please enter $count digits / Veuillez saisir $count chiffres';
  }

  @override
  String validationMaxLength(int max) {
    return 'Maximum $max characters allowed / Maximum $max caractères autorisés';
  }

  @override
  String charactersRemaining(int count) {
    return '$count characters remaining / $count caractères restants';
  }

  @override
  String get validationHeightFormat =>
      'Please enter height as e.g. 5\'8 / Veuillez saisir la taille, p. ex. 5\'8';

  @override
  String get validationInvalidNumber =>
      'Enter a valid number / Saisissez un nombre valide';

  @override
  String validationMaxLitres(String field, String max) {
    return '$field should not be greater than $max ltrs / $field ne doit pas dépasser $max L';
  }

  @override
  String get validationDateFormat =>
      'Please enter the date in the format dd/MM/yyyy / Veuillez saisir la date au format jj/MM/aaaa';

  @override
  String get validationInvalidDate =>
      'Invalid date. Please check the format / Date invalide. Veuillez vérifier le format';

  @override
  String get unitFahrenheit => 'Fahrenheit';

  @override
  String get unitCelsius => 'Celsius';

  @override
  String get commonDate => 'Date';

  @override
  String get commonTime => 'Time / Heure';

  @override
  String get selectTime => 'Select Time / Sélectionner l\'heure';

  @override
  String get commonLogout => 'Logout / Déconnexion';

  @override
  String get drawerDashboard => 'Dashboard / Tableau de bord';

  @override
  String get drawerRegistration => 'Registration / Enregistrement';

  @override
  String get drawerDialysisScheduler =>
      'Dialysis Scheduler / Planificateur de dialyse';

  @override
  String get drawerDialysisQueue =>
      'Dialysis Queue / File d\'attente de dialyse';

  @override
  String get drawerSessionEnd => 'Session End / Fin de séance';

  @override
  String get drawerRoMaintenance => 'RO Maintenance / Maintenance RO';

  @override
  String get drawerMachineStatus => 'Machine Status / État des machines';

  @override
  String get drawerNephrologistDesk =>
      'Nephrologist Desk / Bureau du néphrologue';

  @override
  String get drawerDoctorDesk => 'Doctor Desk / Bureau du médecin';

  @override
  String get drawerApplicationApproval =>
      'Application Approval / Approbation des demandes';

  @override
  String get drawerApplicationScrutiny =>
      'Application Scrutiny / Examen des demandes';

  @override
  String get drawerUploadDocuments =>
      'Upload Documents / Téléverser des documents';

  @override
  String get drawerBilling => 'Billing / Facturation';

  @override
  String get drawerInvoiceApprovalSecondLevel =>
      'Invoice Approval (2nd Level) / Approbation de facture (2e niveau)';

  @override
  String get drawerInvoiceGeneration =>
      'Invoice Generation / Génération de factures';

  @override
  String drawerVersion(String version) {
    return 'Version: $version';
  }

  @override
  String get loginTitle => 'Login / Connexion';

  @override
  String get loginButton => 'Login / Se connecter';

  @override
  String get loginUsername => 'Username / Nom d\'utilisateur';

  @override
  String get loginPassword => 'Password / Mot de passe';

  @override
  String get loginForgotPassword => 'Forgot Password? / Mot de passe oublié ?';

  @override
  String get loginCaptchaHint =>
      'Enter the captcha as shown above / Saisissez le code affiché ci-dessus';

  @override
  String get loginIndiaOnlyMessage =>
      'This app is only available in the Indian region / Cette application n\'est disponible que dans la région indienne';

  @override
  String get loginSuccessful => 'Login successful / Connexion réussie';

  @override
  String loginRunningEnv(String env) {
    return 'Running in $env environment / Exécution dans l\'environnement $env';
  }

  @override
  String loginUnknownRole(String role) {
    return 'Unknown user role: $role / Rôle d\'utilisateur inconnu : $role';
  }

  @override
  String get loginInvalidUser => 'Invalid User / Utilisateur invalide';

  @override
  String get logoutConfirm =>
      'Are you sure you want to logout? / Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get otpVerifyTitle => 'Verify OTP / Vérifier le code OTP';

  @override
  String get otpSentTo =>
      'OTP has been sent to registered mobile number: / Le code OTP a été envoyé au numéro de mobile enregistré :';

  @override
  String get otpYourNumber =>
      'your registered number / votre numéro enregistré';

  @override
  String get otpValidLimited =>
      'This OTP is valid for a limited time / Ce code OTP n\'est valable que pour une durée limitée';

  @override
  String get otpCanResendNow =>
      'Didn\'t get it? You can resend now. / Pas reçu ? Vous pouvez le renvoyer maintenant.';

  @override
  String get otpDidntReceive =>
      'Didn\'t receive the code? / Vous n\'avez pas reçu le code ?';

  @override
  String get otpResend => 'Resend OTP / Renvoyer le code OTP';

  @override
  String otpResendIn(String time) {
    return 'Resend in $time / Renvoyer dans $time';
  }

  @override
  String otpEnterDigits(int count) {
    return 'Please enter the $count-digit OTP / Veuillez saisir le code OTP à $count chiffres';
  }

  @override
  String get otpResent => 'OTP resent / Code OTP renvoyé';

  @override
  String get otpInvalidOrExpired =>
      'Invalid or Expired OTP / Code OTP invalide ou expiré';

  @override
  String get otpResendFailed =>
      'Could not resend OTP. Please login again. / Impossible de renvoyer le code OTP. Veuillez vous reconnecter.';

  @override
  String get commonFrom => 'From / Du';

  @override
  String get commonTo => 'To / Au';

  @override
  String get commonStatus => 'Status / Statut';

  @override
  String get commonActions => 'Actions';

  @override
  String get commonAll => 'All / Tout';

  @override
  String get commonCompleted => 'Completed / Terminé';

  @override
  String get commonName => 'Name / Nom';

  @override
  String get commonAge => 'Age / Âge';

  @override
  String get commonGender => 'Gender / Sexe';

  @override
  String get commonMobileNo => 'Mobile No / N° de portable';

  @override
  String get commonAddress => 'Address / Adresse';

  @override
  String get commonRemarks => 'Remarks / Remarques';

  @override
  String get colSrNo => 'Sr. No / N°';

  @override
  String get colPatientId => 'Patient ID / N° patient';

  @override
  String get colPatientName => 'Patient Name / Nom du patient';

  @override
  String get colAbhaNo => 'ABHA No / N° ABHA';

  @override
  String get colDistrictName => 'District Name / District';

  @override
  String get colInstituteName => 'Institute Name / Établissement';

  @override
  String get colMachineCount => 'Machine Count / Nombre de machines';

  @override
  String get colCommencementDate =>
      'Commencement Date / Date de mise en service';

  @override
  String get colPatientRegistered =>
      'Patients Registered / Patients enregistrés';

  @override
  String get colSessionDone => 'Sessions Done / Séances effectuées';

  @override
  String get colScheme => 'Scheme / Régime';

  @override
  String get colSessionCount => 'Session Count / Nombre de séances';

  @override
  String get colViewPatient => 'View Patient / Voir le patient';

  @override
  String get colUnitName => 'Unit Name / Nom de l\'unité';

  @override
  String get colTotal => 'Total';

  @override
  String get colTotalCount => 'Total Count / Nombre total';

  @override
  String get colTotalPatientRegister =>
      'Total Patient Register / Total patients enregistrés';

  @override
  String get colType => 'Type';

  @override
  String get colCount => 'Count / Nombre';

  @override
  String get colEventName => 'Event Name / Nom de l\'événement';

  @override
  String get colEventCount => 'Event Count / Nombre d\'événements';

  @override
  String get colTreatmentId => 'Treatment ID / N° de traitement';

  @override
  String get colSchemeName => 'Scheme Name / Nom du régime';

  @override
  String get colViralLoadStatus =>
      'Viral Load Status / Statut de charge virale';

  @override
  String get colInvoiceAmount => 'Invoice Amount / Montant de la facture';

  @override
  String get colMonthYear => 'Month-Year / Mois-Année';

  @override
  String get colMjpjayCount => 'MJPJAY Count / Nombre MJPJAY';

  @override
  String get colNonMjpjayCount => 'Non-MJPJAY Count / Nombre hors MJPJAY';

  @override
  String get colTicketTypeDataCorrection =>
      'Ticket Types\nData Correction / Types de ticket\nCorrection de données';

  @override
  String get colTicketTypeNewRequirement =>
      'Ticket Types\nNew Requirement / Types de ticket\nNouvelle exigence';

  @override
  String get colTicketTypeOperatorIssue =>
      'Ticket Types\nOperator Issue / Types de ticket\nProblème opérateur';

  @override
  String get colTicketTypeSoftwareServices =>
      'Ticket Types\nSoftware Services / Types de ticket\nServices logiciels';

  @override
  String get colTicketTypeBug =>
      'Ticket Types\nBug / Types de ticket\nAnomalie';

  @override
  String get colTicketTypeEnhancement =>
      'Ticket Types\nEnhancement / Types de ticket\nAmélioration';

  @override
  String get colComplaintTypeDenialOfService =>
      'Complaint Types\nDenial of Service / Types de plainte\nRefus de service';

  @override
  String get colComplaintTypeMoneyTaken =>
      'Complaint Types\nMoney Taken Against Treat / Types de plainte\nArgent perçu pour le traitement';

  @override
  String get colTestTypePending =>
      'Test Types\nPending / Types de test\nEn attente';

  @override
  String get colTestTypeComplete =>
      'Test Types\nComplete / Types de test\nTerminé';

  @override
  String get dashShowData => 'Show Data / Afficher les données';

  @override
  String get dashPending => 'Pending / En attente';

  @override
  String get dashComplete => 'Complete / Terminé';

  @override
  String get dashTotalPending => 'Total Pending / Total en attente';

  @override
  String get dashTotalComplete => 'Total Complete / Total terminé';

  @override
  String get dashSchemeMjpjay => 'MJPJAY';

  @override
  String get dashSchemeNonMjpjay => 'Non-MJPJAY / Hors MJPJAY';

  @override
  String get dashToday => 'Today / Aujourd\'hui';

  @override
  String get dashFromDate => 'From Date / Date de début';

  @override
  String get dashToDate => 'To Date / Date de fin';

  @override
  String get dashSelectDate => 'Select Date / Sélectionner une date';

  @override
  String get dashCurrentDate => 'Current Date / Date du jour';

  @override
  String get dashCurrentDay => 'Current Day / Jour en cours';

  @override
  String get dashTillDate => 'Till Date / À ce jour';

  @override
  String get dashDateWise => 'Date Wise / Par date';

  @override
  String get dashWorking => 'Working / En service';

  @override
  String get dashSchemePerformance =>
      'Scheme Performance / Performance du régime';

  @override
  String get dashPatientRegistration =>
      'Patient Registration / Enregistrement des patients';

  @override
  String get dashPatientAddedList =>
      'Patient Added List / Liste des patients ajoutés';

  @override
  String get dashAbhaRegistration => 'ABHA Registration / Enregistrement ABHA';

  @override
  String get dashDialysisSessions => 'Dialysis Sessions / Séances de dialyse';

  @override
  String get dashDialysisSession => 'Dialysis Session / Séance de dialyse';

  @override
  String get dashDialysisCancelled => 'Dialysis Cancelled / Dialyses annulées';

  @override
  String get dashDialysisCancel => 'Dialysis Cancel / Annulation de dialyse';

  @override
  String get dashTotalDialysisCancelled =>
      'Total Dialysis Cancelled / Total des dialyses annulées';

  @override
  String get dashOnlineComplaints => 'Online Complaints / Plaintes en ligne';

  @override
  String get dashTotalOnlineComplaints =>
      'Total Online Complaints / Total des plaintes en ligne';

  @override
  String get dashOnlineTickets => 'Online Tickets / Tickets en ligne';

  @override
  String get dashFeedbackTitle => 'Feedback / Retour d\'information';

  @override
  String get dashDateWiseFeedback => 'Date Wise Feedback / Retours par date';

  @override
  String get dashLabTestAssigned =>
      'Laboratory Test Assigned / Tests de laboratoire assignés';

  @override
  String get dashDateWiseLabTest =>
      'Date Wise Laboratory Test Assigned / Tests de laboratoire assignés par date';

  @override
  String get dashTotalLabTestAssigned =>
      'Total Laboratory Test Assigned / Total des tests de laboratoire assignés';

  @override
  String get dashEventOccurred => 'Event Occurred / Événements survenus';

  @override
  String get dashDateWiseEvents => 'Date Wise Events / Événements par date';

  @override
  String get dashTotalAdverseEvent =>
      'Total Adverse Event / Total des événements indésirables';

  @override
  String get dashComplaintDashboardDown =>
      'Dashboard Down / Tableau de bord hors service';

  @override
  String get dashComplaintMachineNotWorking =>
      'Machine Not Working / Machine en panne';

  @override
  String get dashComplaintDenialOfServices =>
      'Denial of Services / Refus de services';

  @override
  String get dashComplaintMoneyTaken =>
      'Money taken against treatment / Argent perçu pour le traitement';

  @override
  String get dashTicketDataCorrection =>
      'Data Correction / Correction de données';

  @override
  String get dashTicketNewRequirement => 'New Requirement / Nouvelle exigence';

  @override
  String get dashTicketOperatorIssue => 'Operator Issue / Problème opérateur';

  @override
  String get dashTicketSoftwareServices =>
      'Software Services / Services logiciels';

  @override
  String get dashTicketBug => 'Bug / Anomalie';

  @override
  String get dashTicketEnhancement => 'Enhancement / Amélioration';

  @override
  String get dashCentralDashboard =>
      'Central Dashboard / Tableau de bord central';

  @override
  String get dashTotalFunctionalUnit =>
      'Total Functional Unit / Total des unités fonctionnelles';

  @override
  String get dashTotalProjectedCenter =>
      'Total Projected Center / Total des centres prévus';

  @override
  String get dashFunctionalCenter => 'Functional Center / Centre fonctionnel';

  @override
  String get dashTotalDialysisPatient =>
      'Total Dialysis Patient / Total des patients dialysés';

  @override
  String get dashTotalPatient => 'Total Patient / Total des patients';

  @override
  String get dashTotalPatientRegistration =>
      'Total Patient Registration / Total des enregistrements de patients';

  @override
  String get dashTotalAbhaPatient =>
      'Total ABHA Patient / Total des patients ABHA';

  @override
  String get dashTotalAbhaRegistration =>
      'Total ABHA Registration / Total des enregistrements ABHA';

  @override
  String get dashTotalDialysisSessions =>
      'Total Dialysis Sessions / Total des séances de dialyse';

  @override
  String get dashTotalMachines => 'Total Machines / Total des machines';

  @override
  String get dashAdverseEvents => 'Adverse Events / Événements indésirables';

  @override
  String get dashAdverseEvent => 'Adverse Event / Événement indésirable';

  @override
  String get dashTickets => 'Tickets';

  @override
  String get dashTotalTickets => 'Total Tickets / Total des tickets';

  @override
  String get dashTotalFeedback => 'Total Feedback / Total des retours';

  @override
  String get dashTotalInvoiceAmount =>
      'Total Invoice Amount / Montant total des factures';

  @override
  String get dashCurrentMonth => 'Current Month / Mois en cours';

  @override
  String get dashTotalPayment => 'Total Payment / Paiement total';

  @override
  String get dashDialysisPerformance =>
      'Dialysis Performance / Performance de dialyse';

  @override
  String get dashClusterDistrictDashboard =>
      'Cluster District Dashboard / Tableau de bord du district';

  @override
  String get dashClusterDivisionDashboard =>
      'Cluster Division Dashboard / Tableau de bord de la division';

  @override
  String get dashCurrentDatePatientRegistered =>
      'Current Date Patient Registered / Patients enregistrés à la date du jour';

  @override
  String get dashDateWisePatientRegistered =>
      'Date Wise Patient Registered Count / Nombre de patients enregistrés par date';

  @override
  String get dashCurrentDateAbhaRegistration =>
      'Current Date ABHA Registration / Enregistrements ABHA à la date du jour';

  @override
  String get dashDateWiseAbhaPatient =>
      'Date Wise ABHA Patient Count / Nombre de patients ABHA par date';

  @override
  String get dashCurrentDateDialysisSession =>
      'Current Date Dialysis Session / Séances de dialyse à la date du jour';

  @override
  String get dashDateWiseDialysisSession =>
      'Date Wise Dialysis Session Count / Nombre de séances de dialyse par date';

  @override
  String get dashCurrentDateDialysisCancelled =>
      'Current Date Dialysis Cancelled / Dialyses annulées à la date du jour';

  @override
  String get dashDateWiseDialysisCancel =>
      'Date Wise Dialysis Cancel Count / Nombre de dialyses annulées par date';

  @override
  String get dashCurrentDateLabTest =>
      'Current Date Laboratory Test Assigned / Tests de laboratoire assignés à la date du jour';

  @override
  String get dashDateWiseTestAssign =>
      'Date Wise Test Assign Count / Nombre de tests assignés par date';

  @override
  String get dashCurrentDateAdverseEvent =>
      'Current Date Adverse Event / Événements indésirables à la date du jour';

  @override
  String get dashDateWiseAdverseEvent =>
      'Date Wise Adverse Event Count / Nombre d\'événements indésirables par date';

  @override
  String get dashCurrentDateFeedback =>
      'Current Date Feedback / Retours à la date du jour';

  @override
  String get dashMisDashboard => 'MIS Dashboard / Tableau de bord MIS';

  @override
  String get misFunctionalInstitute =>
      'Functional Institute / Établissements fonctionnels';

  @override
  String get misNumberOfPatients => 'Number of Patients / Nombre de patients';

  @override
  String get misDialysisUnderMjpjay =>
      'Dialysis Treatment Under MJPJAY / Traitements de dialyse sous MJPJAY';

  @override
  String get misDialysisUnderNonMjpjay =>
      'Dialysis Treatment Under Non MJPJAY / Traitements de dialyse hors MJPJAY';

  @override
  String get misSeroPositive =>
      'Sero Positive Patients / Patients séropositifs';

  @override
  String get misSeroNegative =>
      'Sero Negative Patients / Patients séronégatifs';

  @override
  String get misLabTestsSentToMahaLabs =>
      'Number of Laboratory Test sent to MAHA LABS / Nombre de tests de laboratoire envoyés à MAHA LABS';

  @override
  String get dashTotalDialysis => 'Total Dialysis / Total dialyses';

  @override
  String get dashPatientVerification =>
      'Patient Verification / Vérification des patients';

  @override
  String get dashTotalEventOccurred =>
      'Total Event Occurred / Total des événements survenus';

  @override
  String get dashTotalActiveMachines =>
      'Total Active Machines / Total des machines actives';

  @override
  String get dashTotalOnlineTickets =>
      'Total Online Tickets / Total des tickets en ligne';

  @override
  String get scrutinyApproval => 'Scrutiny Approval / Approbation du contrôle';

  @override
  String get commonSearchBy => 'Search By / Rechercher par';

  @override
  String get searchHintAppNoDateIdName =>
      'Application no, date, patient id, name / N° de demande, date, ID patient, nom';

  @override
  String get commonNoDataFoundDescription =>
      'We are unable to find the data you are looking for. / Nous ne trouvons pas les données que vous recherchez.';

  @override
  String get patientDetailsTitle => 'Patient Details / Détails du patient';

  @override
  String get viewApplication => 'View Application / Voir la demande';

  @override
  String get tabApplicationDetails =>
      'Application Details / Détails de la demande';

  @override
  String get tabServiceDescription =>
      'Service Description / Description du service';

  @override
  String get colApplicationNo => 'Application No / N° de demande';

  @override
  String get colApplicationDate => 'Application Date / Date de la demande';

  @override
  String get colApplicationNumber => 'Application Number / Numéro de demande';

  @override
  String get colApplicantName => 'Applicant Name / Nom du demandeur';

  @override
  String get colServiceName => 'Service Name / Nom du service';

  @override
  String get colBloodGroup => 'Blood Group / Groupe sanguin';

  @override
  String get colHeight => 'Height / Taille';

  @override
  String get colWeight => 'Weight / Poids';

  @override
  String get colDateOfRegistration =>
      'Date Of Registration / Date d\'enregistrement';

  @override
  String get colNephrologistName => 'Nephrologist Name / Nom du néphrologue';

  @override
  String get colRelativeName => 'Relative Name / Nom du proche';

  @override
  String get colRelativeContact => 'Relative Contact / Contact du proche';

  @override
  String get colAbhaNumber => 'ABHA Number / Numéro ABHA';

  @override
  String get colTreatmentUnderScheme =>
      'Treatment Under Scheme / Traitement dans le cadre du régime';

  @override
  String get nephroOngoingDialysisSession =>
      'Ongoing Dialysis Session / Séance de dialyse en cours';

  @override
  String get nephroAnswer => 'Answer / Réponse';

  @override
  String get nephroAction => 'Action';

  @override
  String get nephroDescription => 'Description';

  @override
  String get nephroRemark => 'Remark / Remarque';

  @override
  String get nephroEnterHint => 'Enter / Saisir';

  @override
  String get nephroApprove => 'Approve / Approuver';

  @override
  String get nephroReject => 'Reject / Rejeter';

  @override
  String get nephroSendBack => 'Send Back / Renvoyer';

  @override
  String get nephroLevel1 => 'Level 1 / Niveau 1';

  @override
  String get nephroLevel2 => 'Level 2 / Niveau 2';

  @override
  String get nephroFillMandatory =>
      'Please fill mandatory field / Veuillez remplir les champs obligatoires';

  @override
  String get chartMjpjayCounts => 'MJPJAY Counts / Nombre MJPJAY';

  @override
  String get chartNonMjpjayCounts => 'Non-MJPJAY Counts / Nombre hors MJPJAY';

  @override
  String get commonInfo => 'Info';

  @override
  String get commonDocument => 'Document';

  @override
  String get regNewRegistration => 'New Registration / Nouvel enregistrement';

  @override
  String get regEditPatientDetails =>
      'Edit Patient Details / Modifier les détails du patient';

  @override
  String get regViewPatientDetails =>
      'View Patient Details / Voir les détails du patient';

  @override
  String get tabPersonalInfo => 'Personal Info / Infos personnelles';

  @override
  String get tabDemographicInfo => 'Demographic Info / Infos démographiques';

  @override
  String get tabHistoryOfDialysis =>
      'History Of Dialysis / Historique de dialyse';

  @override
  String get tabUploadDocument => 'Upload Document / Téléverser un document';

  @override
  String get regPatientInformation =>
      'Patient Information / Informations sur le patient';

  @override
  String get regPermanentAddress => 'Permanent Address / Adresse permanente';

  @override
  String get regResidentialAddress =>
      'Residential Address / Adresse résidentielle';

  @override
  String get regSocioEcoStatus => 'Socio-Eco Status / Statut socio-économique';

  @override
  String get regEmergencyRelativeInfo =>
      'Emergency Relative Info / Coordonnées du proche en cas d\'urgence';

  @override
  String get regSameAsResidential =>
      'Per. Address Is Same As Res. Address / L\'adresse permanente est identique à l\'adresse résidentielle';

  @override
  String get regFirstTimeDialysis =>
      'First Time Dialysis? / Première dialyse ?';

  @override
  String get regPatientName => 'Patient Name / Nom du patient';

  @override
  String get regPrefix => 'Prefix / Civilité';

  @override
  String get regFirstName => 'First Name / Prénom';

  @override
  String get regMiddleName => 'Middle Name / Deuxième prénom';

  @override
  String get regLastName => 'Last Name / Nom';

  @override
  String get regDob => 'DOB / Date de naissance';

  @override
  String get regEmailId => 'Email Id / Adresse e-mail';

  @override
  String get regContactNo => 'Contact No / N° de contact';

  @override
  String get regContactNumber => 'Contact Number / Numéro de contact';

  @override
  String get regHeightFt => 'Height (In Ft.) / Taille (en pieds)';

  @override
  String get regHeightCm => 'Height (In cm.) / Taille (en cm)';

  @override
  String get regWeight => 'Weight (Kg-Grams) / Poids (kg-g)';

  @override
  String get regMaritalStatus => 'Marital Status / État civil';

  @override
  String get regReligion => 'Religion';

  @override
  String get regEducation => 'Education / Niveau d\'études';

  @override
  String get regOccupation => 'Occupation / Profession';

  @override
  String get regMonthlyIncome => 'Monthly Income / Revenu mensuel';

  @override
  String get regNationality => 'Nationality / Nationalité';

  @override
  String get regCountry => 'Country / Pays';

  @override
  String get regAbhaId => 'ABHA ID / Identifiant ABHA';

  @override
  String get regAbhaNo => 'ABHA NO / N° ABHA';

  @override
  String get regAbhaAddress => 'ABHA Address / Adresse ABHA';

  @override
  String get regIdProof => 'Id Proof / Pièce d\'identité';

  @override
  String get regIdentificationNumber =>
      'Identification Number / Numéro d\'identification';

  @override
  String get regSchemeAdopted => 'Scheme Adopted / Régime adopté';

  @override
  String get regMjpjayEnrollmentNo =>
      'MJPJAY Enrollment No / N° d\'inscription MJPJAY';

  @override
  String get regViralMarkerStatus =>
      'Viral Marker Status / Statut des marqueurs viraux';

  @override
  String get regAddress => 'Address / Adresse';

  @override
  String get regPinCode => 'Pin Code / Code postal';

  @override
  String get regState => 'State / État';

  @override
  String get regDistrict => 'District';

  @override
  String get regDivision => 'Division';

  @override
  String get regTaluka => 'Taluka';

  @override
  String get regTown => 'Town / Ville';

  @override
  String get regReferredBy => 'Referred By / Référé par';

  @override
  String get regReferenceByName => 'Reference By Name / Nom du référent';

  @override
  String get regReferredContactNumber =>
      'Referred Contact Number / Numéro de contact du référent';

  @override
  String get regNephrologistName => 'Nephrologist Name / Nom du néphrologue';

  @override
  String get regNephrologistContactNo =>
      'Nephrologist Contact No / N° de contact du néphrologue';

  @override
  String get regRelation => 'Relation / Lien de parenté';

  @override
  String get regRelativeName => 'Relative Name / Nom du proche';

  @override
  String get regDialysisMode => 'Dialysis Mode / Mode de dialyse';

  @override
  String get regDialysisFreqWeek =>
      'Dialysis Frequency in Week / Fréquence de dialyse par semaine';

  @override
  String get regFirstDialysisSessionDate =>
      'First Dialysis Session Date / Date de la première séance de dialyse';

  @override
  String get regLastDialysisSessionDate =>
      'Last Dialysis Session Date / Date de la dernière séance de dialyse';

  @override
  String get regLastDialysisHospitalName =>
      'Last Dialysis Hospital Name / Nom du dernier hôpital de dialyse';

  @override
  String get regHintSelect => 'Select / Sélectionner';

  @override
  String get regHintSelectTitle => 'Select Title / Sélectionner la civilité';

  @override
  String get regHintEnter => 'Enter / Saisir';

  @override
  String get regHintEnterName => 'Enter name / Saisir le nom';

  @override
  String get regHintEnterFirstName => 'Enter first name / Saisir le prénom';

  @override
  String get regHintEnterMiddleName =>
      'Enter middle name / Saisir le deuxième prénom';

  @override
  String get regHintEnterLastName => 'Enter last name / Saisir le nom';

  @override
  String get regHintEnterAddress => 'Enter address / Saisir l\'adresse';

  @override
  String get regHintEnterPinCode => 'Enter pin code / Saisir le code postal';

  @override
  String get regHintEnterContactNumber =>
      'Enter contact number / Saisir le numéro de contact';

  @override
  String get regHintEnterEmail =>
      'Enter Email address / Saisir l\'adresse e-mail';

  @override
  String get regHintEnterNumber => 'Enter number / Saisir le numéro';

  @override
  String get regHintFeetInches =>
      'Enter In Feet and Inches / Saisir en pieds et pouces';

  @override
  String get regUploadDocument => 'Upload Document / Téléverser un document';

  @override
  String get regBrowseChooseFiles =>
      'Browse and choose the files you want to upload / Parcourez et choisissez les fichiers à téléverser';

  @override
  String get regMaxFileSize =>
      'Max File Size : 10 MB / Taille max. du fichier : 10 Mo';

  @override
  String get regSupportedFormats =>
      'Supported Formats : JPEG, PNG, PDF / Formats pris en charge : JPEG, PNG, PDF';

  @override
  String get regSaveNext => 'Save & Next / Enregistrer et continuer';

  @override
  String get regCompleteDemographicFirst =>
      'Please complete Demographic Information first / Veuillez d\'abord compléter les informations démographiques';

  @override
  String get regCompleteHistoryFirst =>
      'Please complete History of Dialysis first / Veuillez d\'abord compléter l\'historique de dialyse';

  @override
  String get regCompletePersonalFirst =>
      'Please complete Personal Information first / Veuillez d\'abord compléter les informations personnelles';

  @override
  String get regFillMandatory =>
      'Please fill mandatory details / Veuillez renseigner les champs obligatoires';

  @override
  String get regSelectDocument =>
      'Please select document / Veuillez sélectionner un document';

  @override
  String get regUploadRequiredDocuments =>
      'Please upload Required Documents / Veuillez téléverser les documents requis';

  @override
  String get regUpdatedSuccessfully =>
      'Updated Successfully / Mise à jour réussie';

  @override
  String get regMobileExists =>
      'Mobile number already exists / Ce numéro de mobile existe déjà';

  @override
  String get regUploadFailed => 'Upload failed / Échec du téléversement';

  @override
  String get regUploadPhotoSize =>
      'Upload photo below 500KB / Téléversez une photo de moins de 500 Ko';

  @override
  String regPleaseNotePatientId(String id) {
    return 'Please note Patient Id $id / Veuillez noter l\'identifiant patient $id';
  }

  @override
  String get regPrintReport => 'Print Report? / Imprimer le rapport ?';

  @override
  String get regRegistrationCompleted =>
      'Registration Completed Successfully / Enregistrement terminé avec succès';

  @override
  String get regRegisteredPatients =>
      'Registered Patients / Patients enregistrés';

  @override
  String get regSelectScheme => 'Select Scheme / Sélectionner le régime';

  @override
  String get regSearchPatientHint =>
      'Patient Id, name, mobile no etc. / N° patient, nom, n° de mobile, etc.';

  @override
  String get regDialysisCenter => 'Dialysis Center / Centre de dialyse';

  @override
  String get regPatientAge => 'Patient Age / Âge du patient';

  @override
  String get patientCardRefBy => 'Ref. By / Réf. par';

  @override
  String get commonValue => 'Value / Valeur';

  @override
  String get commonPrint => 'Print / Imprimer';

  @override
  String get commonProcessing => 'Processing / Traitement en cours';

  @override
  String get commonStart => 'Start / Démarrer';

  @override
  String get patientCardDob => 'Date Of Birth / Date de naissance';

  @override
  String get schedAddSchedular =>
      'Add Dialysis Scheduler / Ajouter une planification de dialyse';

  @override
  String get schedBookAppointment => 'Book Appointment / Prendre rendez-vous';

  @override
  String get schedVisitorEntry => 'Visitor Entry / Entrée du visiteur';

  @override
  String get schedPatientHistory => 'Patient History / Historique du patient';

  @override
  String get schedDialysisScheduleChart =>
      'Dialysis Schedule Chart / Tableau de planification des dialyses';

  @override
  String get schedDialysisPatientList =>
      'Dialysis Patient List / Liste des patients dialysés';

  @override
  String get schedCaseHistory => 'Case History / Antécédents médicaux';

  @override
  String get schedDialysisDetails => 'Dialysis Details / Détails de la dialyse';

  @override
  String get schedPatientDocuments =>
      'Patient Documents / Documents du patient';

  @override
  String get schedSearchPatient => 'Search Patient / Rechercher un patient';

  @override
  String get schedSlot => 'Slot / Créneau';

  @override
  String get schedSlotTime => 'Slot Time / Heure du créneau';

  @override
  String get schedBedsAllocated => 'Beds Allocated / Lits attribués';

  @override
  String get schedBedNo => 'Bed No. / N° de lit';

  @override
  String get schedMachineName => 'Machine Name / Nom de la machine';

  @override
  String get schedAppointmentDate => 'Appointment Date / Date du rendez-vous';

  @override
  String get schedVisitDate => 'Visit Date / Date de la visite';

  @override
  String get schedVisitTime => 'Visit Time / Heure de la visite';

  @override
  String get schedIpNumber => 'IP Number / Numéro d\'hospitalisation';

  @override
  String get schedMjpjayCaseNumber =>
      'MJPJAY Case Number / Numéro de dossier MJPJAY';

  @override
  String get schedMjpjayClaimNumber =>
      'MJPJAY Claim Number / Numéro de demande MJPJAY';

  @override
  String get schedMjpjayEnrollmentId =>
      'MJPJAY Enrollment Id / Identifiant d\'inscription MJPJAY';

  @override
  String get schedPreAuthApprovalDate =>
      'Pre Auth Approval Date / Date d\'approbation de la pré-autorisation';

  @override
  String get schedPreAuthNumber =>
      'Pre Auth Number / Numéro de pré-autorisation';

  @override
  String get schedDocumentName => 'Document Name: / Nom du document :';

  @override
  String get schedNoDocuments =>
      'No documents available / Aucun document disponible';

  @override
  String get schedDataSaved =>
      'Data Saved Successfully / Données enregistrées avec succès';

  @override
  String get schedDataSaveFailed =>
      'Data Save Failed / Échec de l\'enregistrement des données';

  @override
  String get schedDischargeSummary => 'Discharge Summary / Résumé de sortie';

  @override
  String get schedSessionEndReport =>
      'Session End Report / Rapport de fin de séance';

  @override
  String get schedHbsagPositive => 'HBsAg Positive / AgHBs positif';

  @override
  String get schedHcvPositive => 'HCV Positive / VHC positif';

  @override
  String get schedHivPositive => 'HIV Positive / VIH positif';

  @override
  String get schedHhhNegative => 'HHH Negative / HHH négatif';

  @override
  String get clinAccessSite => 'Access Site / Site d\'accès';

  @override
  String get clinActualFbv => 'Actual FBV / VFB réel';

  @override
  String get clinBloodPressure => 'Blood Pressure / Tension artérielle';

  @override
  String get clinBloodTubingBarcode =>
      'Blood Tubing Barcode No./Sr. No / Code-barres/N° de série de la tubulure sanguine';

  @override
  String get clinBloodTubingReuseNo =>
      'Blood Tubing Reuse No / N° de réutilisation de la tubulure sanguine';

  @override
  String get clinCaseNarration => 'Case Narration / Description du cas';

  @override
  String get clinDialyserType => 'Dialyser Type / Type de dialyseur';

  @override
  String get clinDialyzerType => 'Dialyzer Type / Type de dialyseur';

  @override
  String get clinDialysisDuration => 'Dialysis Duration / Durée de la dialyse';

  @override
  String get clinDialysisStartDateTime =>
      'Dialysis Start Date and Time / Date et heure de début de la dialyse';

  @override
  String get clinDialysisStopDateTime =>
      'Dialysis Stop Date and Time / Date et heure de fin de la dialyse';

  @override
  String get clinDialysisType => 'Dialysis Type / Type de dialyse';

  @override
  String get clinDialyzerBarcode =>
      'Dialyzer Barcode No./Sr. No / Code-barres/N° de série du dialyseur';

  @override
  String get clinDialyzerDiscarded => 'Dialyzer Discarded / Dialyseur jeté';

  @override
  String get clinDialyzerRemark =>
      'Dialyzer Remark / Remarque sur le dialyseur';

  @override
  String get clinDialyzerReuseNo =>
      'Dialyzer Reuse No / N° de réutilisation du dialyseur';

  @override
  String get clinDryWeight => 'Dry Weight / Poids sec';

  @override
  String get clinHeparin => 'Heparin / Héparine';

  @override
  String get clinInterdialyticGain =>
      'Interdialytic Gain / Prise interdialytique';

  @override
  String get clinOxygenLevel => 'Oxygen Level / Niveau d\'oxygène';

  @override
  String get clinPostDialysisInjection =>
      'Post Dialysis Injection/Medicine / Injection/médicament post-dialyse';

  @override
  String get clinPostDialysisInvestigation =>
      'Post Dialysis Investigation / Examens post-dialyse';

  @override
  String get clinPostDialysisWeight =>
      'Post Dialysis Weight / Poids post-dialyse';

  @override
  String get clinPreDialysisInvestigation =>
      'Pre Dialysis Investigation / Examens pré-dialyse';

  @override
  String get clinPreDialysisVitals =>
      'Pre Dialysis Vitals / Constantes pré-dialyse';

  @override
  String get clinPreDialysisWeight => 'Pre Dialysis Weight / Poids pré-dialyse';

  @override
  String get clinPreHdCondition => 'Pre HD Condition / État pré-HD';

  @override
  String get clinPulse => 'Pulse / Pouls';

  @override
  String get clinRespiratoryRate => 'Respiratory Rate / Fréquence respiratoire';

  @override
  String get clinSpecialDialysis => 'Special Dialysis / Dialyse spéciale';

  @override
  String get clinTemperature => 'Temperature / Température';

  @override
  String get clinBloodTubingRemark =>
      'Blood Tubing Remark / Remarque sur la tubulure sanguine';

  @override
  String get clinCurrentSessionWeightDiff =>
      'Current Dialysis Session Weight Difference / Différence de poids de la séance de dialyse en cours';

  @override
  String get clinKtv => 'kt/v';

  @override
  String get clinUfAchieved => 'UF Achieved / UF atteinte';

  @override
  String get clinUfr => 'UFR / TUF';

  @override
  String get clinTmp => 'TMP / PTM';

  @override
  String get clinVp => 'VP / PV';

  @override
  String get clinAp => 'AP / PA';

  @override
  String get clinBfr => 'BFR / DSP';

  @override
  String get clinCbv => 'CBV / VSC';

  @override
  String get clinCond => 'Cond';

  @override
  String get clinTsat => 'TSAT (%)';

  @override
  String get clinEpoDose => 'EPO Dose / Dose d\'EPO';

  @override
  String get clinEpoAdministered => 'EPO Administered / EPO administrée';

  @override
  String get clinBolusDose => 'Bolus Dose / Dose de bolus';

  @override
  String get clinInfusionDose => 'Infusion Dose / Dose de perfusion';

  @override
  String get clinBpMmhg => 'BP(mmHg) / TA (mmHg)';

  @override
  String get clinBloodPressureMmhg =>
      'Blood Pressure\n(mmHg) / Pression artérielle\n(mmHg)';

  @override
  String get clinPreDialysisDate => 'Pre Dialysis Date / Date pré-dialyse';

  @override
  String get clinDiscardedRemarks =>
      'Discarded Remarks / Remarques sur le rejet';

  @override
  String get clinNewDialyzer => 'New Dialyzer / Nouveau dialyseur';

  @override
  String get dqHdChart => 'HD Chart / Fiche HD';

  @override
  String get dqHdChartList => 'HD Chart List / Liste des fiches HD';

  @override
  String get dqPreDialysisDetails =>
      'Pre Dialysis Details / Détails pré-dialyse';

  @override
  String get dqPostDialysisDetails =>
      'Post Dialysis Details / Détails post-dialyse';

  @override
  String get dqEditPreDialysisDetails =>
      'Edit Pre Dialysis Details / Modifier les détails pré-dialyse';

  @override
  String get dqPreDialysisPatientList =>
      'Pre Dialysis Patient List / Liste des patients pré-dialyse';

  @override
  String get dqPostDialysisPatientList =>
      'Post Dialysis Patient List / Liste des patients post-dialyse';

  @override
  String get dqDialysisEventDetails =>
      'Dialysis Event Details / Détails de l\'événement de dialyse';

  @override
  String get dqEventQueuedPatientList =>
      'Event Queued Patient List / Liste des patients en file d\'attente d\'événement';

  @override
  String get dqInvestigationQueue =>
      'Investigation Queue / File d\'attente des examens';

  @override
  String get dqAllTest => 'All Test / Tous les tests';

  @override
  String get dqTrendAnalysis => 'Trend Analysis / Analyse des tendances';

  @override
  String get dqWeightTrendAnalysis =>
      'Weight Trend Analysis / Analyse des tendances du poids';

  @override
  String get dqTemperatureTrendAnalysis =>
      'Temperature Trend Analysis / Analyse des tendances de la température';

  @override
  String get dqCoverSheet => 'Cover Sheet / Feuille de couverture';

  @override
  String get dqSafetyChecks => 'Safety Checks / Contrôles de sécurité';

  @override
  String get dqClinicalHistory => 'Clinical History / Antécédents cliniques';

  @override
  String get dqClinicalCondition => 'Clinical Condition / État clinique';

  @override
  String get dqDiagnosticInv => 'Diagnostic Inv / Examens diagnostiques';

  @override
  String get dqDiet => 'Diet / Régime alimentaire';

  @override
  String get dqDietDetails => 'Diet Details / Détails du régime alimentaire';

  @override
  String get dqInstruction => 'Instruction / Consigne';

  @override
  String get dqInstructionDetails =>
      'Instruction Details / Détails de la consigne';

  @override
  String get dqPrescription => 'Prescription';

  @override
  String get dqPrescriptionDetails =>
      'Prescription Details / Détails de la prescription';

  @override
  String get dqLaboratoryInvestigation =>
      'Laboratory Investigation / Examens de laboratoire';

  @override
  String get dqPhysicalEntryConsumable =>
      'Physical Entry of Consumable Used / Saisie physique des consommables utilisés';

  @override
  String get dqAddEntryConsumable =>
      'Add New Entry of Consumable Used / Ajouter une entrée de consommable utilisé';

  @override
  String get dqHistory => 'History / Historique';

  @override
  String get dqPrePostEventInvestigation =>
      'Pre-Post-Event Investigation / Examens pré/post-événement';

  @override
  String get dqStartDialysis => 'Start Dialysis / Démarrer la dialyse';

  @override
  String get dqStopDialysis => 'Stop Dialysis / Arrêter la dialyse';

  @override
  String get dqAnalyze => 'Analyze / Analyser';

  @override
  String get dqAddBarcodeNo => 'Add Barcode No. / Ajouter un code-barres';

  @override
  String get dqInvalidInput => 'Invalid Input / Saisie invalide';

  @override
  String get dqSaveFailed => 'Save Failed / Échec de l\'enregistrement';

  @override
  String get dqFailSaveMachineReading =>
      'Failed to save machine reading / Échec de l\'enregistrement du relevé de la machine';

  @override
  String get dqProductShouldNotSame =>
      'Product should not be the same / Le produit ne doit pas être le même';

  @override
  String get dqPreDialysisTab => 'Pre-dialysis / Pré-dialyse';

  @override
  String get dqPostDialysisTab => 'Post-dialysis / Post-dialyse';

  @override
  String get dqActionTaken => 'Action Taken / Mesure prise';

  @override
  String get dqAvailableQuantity => 'Available Quantity / Quantité disponible';

  @override
  String get dqBarcodeNo => 'Barcode No / N° de code-barres';

  @override
  String get dqBatchNo => 'Batch No / N° de lot';

  @override
  String get dqConsumedQuantity => 'Consumed Quantity / Quantité consommée';

  @override
  String get dqDialysisIncidentType =>
      'Dialysis Incident Type / Type d\'incident de dialyse';

  @override
  String get dqDialysisIncidentSubType =>
      'Dialysis Incident sub Type / Sous-type d\'incident de dialyse';

  @override
  String get dqDuration => 'Duration / Durée';

  @override
  String get dqEventDescription =>
      'Event Description / Description de l\'événement';

  @override
  String get dqExpiryDate => 'Expiry Date / Date d\'expiration';

  @override
  String get dqOrderId => 'Order Id / N° de commande';

  @override
  String get dqProductName => 'Product Name / Nom du produit';

  @override
  String get dqQuantity => 'Quantity / Quantité';

  @override
  String get dqTestId => 'Test ID / N° de test';

  @override
  String get dqTestName => 'Test Name / Nom du test';

  @override
  String get dqCounter => 'Counter / Compteur';

  @override
  String get commonActive => 'Active / Actif';

  @override
  String get commonComments => 'Comments / Commentaires';

  @override
  String get commonReason => 'Reason / Motif';

  @override
  String get commonQuantity => 'Quantity / Quantité';

  @override
  String get commonDays => 'Days / Jours';

  @override
  String get commonUnit => 'Unit / Unité';

  @override
  String get clinBloodGlucose => 'Blood Glucose / Glycémie';

  @override
  String get clinPastSurgicalHistory =>
      'Past Surgical History / Antécédents chirurgicaux';

  @override
  String get clinMedicationMethod =>
      'Medication Method / Mode d\'administration';

  @override
  String get clinAlcoholConsumption =>
      'Alcohol Consumption / Consommation d\'alcool';

  @override
  String get clinAlcoholCurrentStat =>
      'Alcohol Current Stat / Statut actuel (alcool)';

  @override
  String get clinAlcoholDuration => 'Alcohol Duration / Durée (alcool)';

  @override
  String get clinDrugCurrentStat =>
      'Drug Current Stat / Statut actuel (drogue)';

  @override
  String get clinDrugDuration => 'Drug Duration / Durée (drogue)';

  @override
  String get clinIllicitDrug => 'Illicit Drug / Drogue illicite';

  @override
  String get clinSmoking => 'Smoking / Tabagisme';

  @override
  String get clinSmokingCurrentStat =>
      'Smoking Current Stat / Statut actuel (tabac)';

  @override
  String get clinSmokingDuration => 'Smoking Duration / Durée (tabac)';

  @override
  String get clinTobaccoConsumption =>
      'Tobacco Consumption / Consommation de tabac';

  @override
  String get clinTobaccoCurrentStat =>
      'Tobacco Current Stat / Statut actuel (tabac)';

  @override
  String get clinTobaccoDuration => 'Tobacco Duration / Durée (tabac)';

  @override
  String get nephroClinicalNotes => 'Clinical Notes / Notes cliniques';

  @override
  String get nephroDiagnosisDescription =>
      'Diagnosis & Description / Diagnostic et description';

  @override
  String get nephroDosage => 'Dosage / Posologie';

  @override
  String get nephroFrequency => 'Frequency / Fréquence';

  @override
  String get nephroRoute => 'Route / Voie d\'administration';

  @override
  String get nephroPrep => 'Prep / Préparation';

  @override
  String get nephroTemplate => 'Template / Modèle';

  @override
  String get nephroIcd10Code => 'ICD10 Code / Code CIM-10';

  @override
  String get nephroInstructions => 'Instructions / Consignes';

  @override
  String get nephroInstructionEnglish =>
      'Instruction in English / Consigne en anglais';

  @override
  String get nephroInstructionMarathi =>
      'Instruction in Marathi / Consigne en marathi';

  @override
  String get nephroInstructionHindi =>
      'Instruction in Hindi / Consigne en hindi';

  @override
  String get nephroOtherLanguage1 => 'Other Language 1 / Autre langue 1';

  @override
  String get nephroOtherLanguage2 => 'Other Language 2 / Autre langue 2';

  @override
  String get nephroOtherLanguage3 => 'Other Language 3 / Autre langue 3';

  @override
  String get nephroDiagnosisType => 'Diagnosis Type / Type de diagnostic';

  @override
  String get nephroDiet => 'Diet / Régime alimentaire';

  @override
  String get nephroSpecialInstructions =>
      'Special Instructions / Consignes particulières';

  @override
  String get nephroTreatmentPlan => 'Treatment Plan / Plan de traitement';

  @override
  String get nephroAddDetails => 'Add Details / Ajouter des détails';

  @override
  String get nephroAddNewInstruction =>
      'Add New Instruction / Ajouter une nouvelle consigne';

  @override
  String get nephroAddToTest => 'Add to Test / Ajouter au test';

  @override
  String get nephroViewReport => 'View Report / Voir le rapport';

  @override
  String get nephroChooseTest => 'Choose Test / Choisir un test';

  @override
  String get nephroMedicineName => 'Medicine Name / Nom du médicament';

  @override
  String get nephroTestName => 'Test Name / Nom du test';

  @override
  String get nephroDiagnosis => 'Diagnosis / Diagnostic';

  @override
  String get nephroClinicalHistory =>
      'Clinical History / Antécédents cliniques';

  @override
  String get nephroClinicalHistoryStatus =>
      'Clinical History Status / Statut des antécédents cliniques';

  @override
  String get nephroInvestigationScheduling =>
      'Investigation Test Scheduling Details / Détails de planification des examens';

  @override
  String get nephroNoPrescriptions =>
      'No prescriptions found / Aucune prescription trouvée';

  @override
  String get nephroGeneralInfo => 'General Info / Informations générales';

  @override
  String get nephroOnExamination => 'ON EXAMINATION / À L\'EXAMEN';

  @override
  String get nephroSystematicExaminations =>
      'SYSTEMATIC EXAMINATIONS / EXAMENS SYSTÉMATIQUES';

  @override
  String get nephroSelectFileToUpload =>
      'Select File to Upload / Sélectionner un fichier à téléverser';

  @override
  String get nephroEnterComments => 'Enter Comments / Saisir des commentaires';

  @override
  String get nephroDeleteInstructionConfirm =>
      'Are you sure you want to delete this instruction? / Êtes-vous sûr de vouloir supprimer cette consigne ?';

  @override
  String get nephroConfirmed => 'Confirmed / Confirmé';

  @override
  String get nephroProvisional => 'Provisional / Provisoire';

  @override
  String get nephroUrgent => 'Urgent';

  @override
  String get nephroBmi => 'BMI / IMC';

  @override
  String get nephroMachineNo => 'Machine No. / N° de machine';

  @override
  String get nephroNephrologistName => 'Nephrologist Name / Nom du néphrologue';

  @override
  String get nephroRegistrationDate =>
      'Registration Date / Date d\'enregistrement';

  @override
  String get nephroPatientMobileNo =>
      'Patient Mobile No / N° de mobile du patient';

  @override
  String get nephroRelativeName => 'Relative Name / Nom du proche';

  @override
  String get nephroAssignedToTechnician =>
      'Assigned To Technician / Attribué au technicien';

  @override
  String get nephroClinicalConditionSaved =>
      'Clinical Condition Saved / État clinique enregistré';

  @override
  String get nephroDocumentDeleted => 'Document Deleted / Document supprimé';

  @override
  String get nephroEnterTest => 'Enter Test / Saisir un test';

  @override
  String get nephroSelectCheckbox =>
      'Please select checkbox / Veuillez cocher une case';

  @override
  String get nephroRecordUpdated =>
      'Record Updated Successfully / Enregistrement mis à jour avec succès';

  @override
  String get nephroTestAdded => 'Test Added / Test ajouté';

  @override
  String get nephroTestAddFail =>
      'Test Adding Failed / Échec de l\'ajout du test';

  @override
  String get nephroDiagnosisDeleted =>
      'Diagnosis Deleted Successfully / Diagnostic supprimé avec succès';

  @override
  String get nephroErrorSavingDiet =>
      'Error saving diet / Erreur lors de l\'enregistrement du régime';

  @override
  String get nephroFailedSaveDiet =>
      'Failed to save diet / Échec de l\'enregistrement du régime';

  @override
  String get nephroRecordsDeleted =>
      'Records Deleted Successfully / Enregistrements supprimés avec succès';

  @override
  String get nephroUnauthorized =>
      'Unauthorized request / Requête non autorisée';

  @override
  String get nephroAddTestsPackages =>
      'Add Tests/Packages / Ajouter des tests/forfaits';

  @override
  String get nephroSelectPackage => 'Select Package / Sélectionner un forfait';

  @override
  String nephroUploadError(Object error) {
    return 'Upload error: $error / Erreur de téléversement : $error';
  }

  @override
  String get commonApprove => 'Approve / Approuver';

  @override
  String get commonGenerate => 'Generate / Générer';

  @override
  String get dischTermsConditions =>
      'Terms & Conditions / Conditions générales';

  @override
  String get dischDischarge => 'Discharge / Sortie';

  @override
  String get dischSessionEndPatientList =>
      'Session End Patient List / Liste des patients en fin de séance';

  @override
  String get dischApprovalStatus => 'Approval Status / Statut d\'approbation';

  @override
  String get dischDialysisDate => 'Dialysis Date / Date de dialyse';

  @override
  String get machMachineCounter => 'Machine Counter / Compteur de machine';

  @override
  String get machMachineFilter => 'Machine Filter / Filtre de machine';

  @override
  String get machAddMachineCounter =>
      'Add Machine Counter / Ajouter un compteur de machine';

  @override
  String get machMachineName => 'Machine Name / Nom de la machine';

  @override
  String get billInvoiceApprovalSecondLevel =>
      'INVOICE APPROVAL (2nd LEVEL) / APPROBATION DE FACTURE (2e NIVEAU)';

  @override
  String get billInvoiceGeneration =>
      'INVOICE Generation / Génération de factures';

  @override
  String get billFilterInvoice => 'Filter Invoice / Filtrer les factures';

  @override
  String get billServiceCertificate =>
      'Service Certificate / Certificat de service';

  @override
  String get billViewServiceCertificate =>
      'View Service Certificate / Voir le certificat de service';

  @override
  String get billServiceCertificateDetails =>
      'Service Certificate\'s Details / Détails du certificat de service';

  @override
  String get billMonth => 'Month / Mois';

  @override
  String get billYear => 'Year / Année';

  @override
  String get bookChooseSlot => 'Choose Slot / Choisir un créneau';

  @override
  String get bookSelectInstitute =>
      'Select Institute / Sélectionner un établissement';

  @override
  String get bookBookingFailed => 'Booking failed / Échec de la réservation';

  @override
  String get bookHivPositive => 'HIV+ / VIH+';

  @override
  String get bookHepatitisCPositive => 'Hepatitis C+ / Hépatite C+';

  @override
  String get bookNegative => 'Negative / Négatif';

  @override
  String get photoTakePhoto => 'Take Photo / Prendre une photo';

  @override
  String get photoCapturePhoto => 'Capture Photo / Capturer une photo';

  @override
  String get photoDataSaved =>
      'Data saved successfully / Données enregistrées avec succès';

  @override
  String photoUploadFailed(Object reason) {
    return 'Upload failed: $reason / Échec du téléversement : $reason';
  }

  @override
  String get cctvCameraDetails =>
      'CCTV Camera Details / Détails de la caméra CCTV';

  @override
  String get cctvCamera => 'CCTV Camera / Caméra CCTV';

  @override
  String get uploadDocuments => 'Upload Documents / Téléverser des documents';

  @override
  String get uploadNoDocument =>
      'No document available / Aucun document disponible';

  @override
  String get uploadUploading => 'Uploading... / Téléversement…';

  @override
  String get uploadCropPhoto => 'Crop Photo / Recadrer la photo';

  @override
  String get uploadFeedback => 'Feedback / Retour d\'information';

  @override
  String get uploadHdChart => 'HD Chart / Fiche HD';

  @override
  String get uploadTreatmentDate => 'Treatment Date / Date de traitement';

  @override
  String uploadUploadedOn(Object dateTime) {
    return 'Uploaded on: $dateTime / Téléversé le : $dateTime';
  }

  @override
  String get roDisinfectionDetails =>
      'RO Disinfection Details / Détails de désinfection RO';

  @override
  String get roLogSheet => 'RO Log Sheet / Feuille de relevé RO';

  @override
  String get roAddLogSheet =>
      'Add RO Log Sheet / Ajouter une feuille de relevé RO';

  @override
  String get roDailyLogSheet =>
      'Daily RO Log Sheet / Feuille de relevé RO quotidienne';

  @override
  String get roMachineIssueLogs =>
      'RO Machine Issue Logs / Journaux des incidents de machine RO';

  @override
  String get roBackwash => 'Backwash / Contre-lavage';

  @override
  String get roRinse => 'Rinse / Rinçage';

  @override
  String get roCallAttendedBy => 'Call Attended By / Appel traité par';

  @override
  String get roCheckedBy => 'Checked By / Vérifié par';

  @override
  String get roCorrectionAction => 'Correction Action / Mesure corrective';

  @override
  String get roDifference => 'Difference / Différence';

  @override
  String get roDoneBy => 'Done By / Effectué par';

  @override
  String get roImageName => 'Image Name / Nom de l\'image';

  @override
  String get roInformationDate => 'Information Date / Date d\'information';

  @override
  String get roInformedBy => 'Informed By / Informé par';

  @override
  String get roInformedTo => 'Informed To / Informé à';

  @override
  String get roInspectionDate => 'Inspection Date / Date d\'inspection';

  @override
  String get roIssueDate => 'Issue Date / Date de l\'incident';

  @override
  String get roIssueDescription =>
      'Issue Description / Description de l\'incident';

  @override
  String get roNextInspectionDate =>
      'Next Inspection Date / Date de la prochaine inspection';

  @override
  String get roProblemResolved => 'Problem Resolved / Problème résolu';

  @override
  String get roRange => 'Range / Plage';

  @override
  String get roSpecialNo =>
      'Please enter special no. / Veuillez saisir le n° spécial';

  @override
  String get roTypeOfDisinfection =>
      'Type of Disinfection Used / Type de désinfection utilisé';

  @override
  String get roImageUpload => 'Image Upload / Téléversement d\'image';

  @override
  String get roSoftenerRegistration =>
      'Softener Registration / Enregistrement de l\'adoucisseur';

  @override
  String get roLooplineTds => 'Loopline TDS (ppm) / TDS boucle (ppm)';

  @override
  String get roPostCarbonChlorine =>
      'Post Carbon Filter Chlorine (ppm) / Chlore post-filtre à charbon (ppm)';

  @override
  String get roPostMembraneTds =>
      'Post Membrane TDS (ppm) / TDS post-membrane (ppm)';

  @override
  String get roPostMixbedTds =>
      'Post Mixbed TDS (ppm) / TDS post-lit mixte (ppm)';

  @override
  String get roPostSoftenerHardness =>
      'Post Softener Hardness (ppm) / Dureté post-adoucisseur (ppm)';

  @override
  String get roPostSoftenerTds =>
      'Post Softener TDS (ppm) / TDS post-adoucisseur (ppm)';

  @override
  String get roProductPermeateFlow =>
      'Product / Permeate Flow (lph) / Débit produit/perméat (l/h)';

  @override
  String get roRawWaterTdsPpm => 'Raw Water TDS (ppm) / TDS eau brute (ppm)';

  @override
  String get roRejectFlowLph => 'Reject Flow (lph) / Débit de rejet (l/h)';

  @override
  String get roCarbonFilterPressure =>
      'Carbon Filter Pressure (PSI) / Pression du filtre à charbon (PSI)';

  @override
  String get roRoWaterTds => 'RO Water TDS (PPM) / TDS eau RO (PPM)';

  @override
  String get roRawWaterTds => 'Raw Water TDS (PPM) / TDS eau brute (PPM)';

  @override
  String get roReturnLoopPressure =>
      'Return Loop Pressure (PSI) / Pression de la boucle de retour (PSI)';

  @override
  String get roSoftenerPressure =>
      'Softener Pressure (PSI) / Pression de l\'adoucisseur (PSI)';

  @override
  String get roPre => 'Pre / Avant';

  @override
  String get roPost => 'Post / Après';

  @override
  String get roPump => 'Pump / Pompe';

  @override
  String get roWater => 'Water / Eau';

  @override
  String get roSand => 'Sand / Sable';

  @override
  String get roSandFilter => 'Sand Filter / Filtre à sable';

  @override
  String get roCarbon => 'Carbon / Charbon';

  @override
  String get roCarbonFilter => 'Carbon Filter / Filtre à charbon';

  @override
  String get roSoftner => 'Softener / Adoucisseur';

  @override
  String get roRawWaterPump => 'Raw Water Pump / Pompe d\'eau brute';

  @override
  String get roTransferPump => 'Transfer Pump / Pompe de transfert';

  @override
  String get roUvLamp => 'UV Lamp / Lampe UV';

  @override
  String get roSaveFailed => 'Save Failed / Échec de l\'enregistrement';

  @override
  String get roSavedSuccessfully =>
      'Saved Successfully / Enregistré avec succès';

  @override
  String get phtPatientHealthTrends =>
      'Patient Health Trends / Tendances de santé du patient';

  @override
  String get phtHaemoglobinTracking =>
      'Haemoglobin Tracking Report / Rapport de suivi de l\'hémoglobine';

  @override
  String get phtInvestigationResultChart =>
      'Patient Dialysis Investigation Result Chart / Graphique des résultats d\'examens de dialyse du patient';

  @override
  String get phtVitalChart =>
      'Patient Dialysis Vital Chart / Graphique des constantes de dialyse du patient';

  @override
  String get phtPatientVitalChart =>
      'Patient Vital Chart / Graphique des constantes du patient';

  @override
  String get phtGenerateReport => 'Generate Report / Générer le rapport';

  @override
  String get phtShowRecord => 'Show Record / Afficher l\'enregistrement';

  @override
  String get phtShowReport => 'Show Report / Afficher le rapport';

  @override
  String get phtVitalParameters => 'Vital Parameters / Paramètres vitaux';

  @override
  String get phtValuesByDate => 'Values By Date / Valeurs par date';

  @override
  String get phtSelectDateRange =>
      'Select Date Range / Sélectionner une plage de dates';

  @override
  String get phtSearchPatient => 'Search Patient / Rechercher un patient';

  @override
  String get phtSelectDateRangeTap =>
      'Select a date range and tap / Sélectionnez une plage de dates et appuyez';

  @override
  String get phtNoVitalData =>
      'No Vital Data Available / Aucune donnée vitale disponible';

  @override
  String get phtNoChartData =>
      'No chart data available / Aucune donnée de graphique disponible';

  @override
  String get phtNoValidDataPoints =>
      'No valid data points to display / Aucun point de données valide à afficher';

  @override
  String get phtDataNotFound => 'Data Not Found / Données introuvables';

  @override
  String phtLatestValue(Object value) {
    return 'Latest Value: $value / Dernière valeur : $value';
  }

  @override
  String phtLatest(Object value) {
    return 'Latest: $value / Dernière : $value';
  }

  @override
  String get phtSearchHint =>
      'Search by patient name or id / Rechercher par nom ou identifiant du patient';

  @override
  String get dqPreDialysis => 'Pre Dialysis / Pré-dialyse';

  @override
  String get dqPostDialysis => 'Post Dialysis / Post-dialyse';

  @override
  String get dqDialysisEvent => 'Dialysis Event / Événement de dialyse';

  @override
  String get dqInvestigation => 'Investigation / Examen';

  @override
  String get dqConsumableEntry => 'Consumable Entry / Saisie des consommables';

  @override
  String get roMachineLogSheet =>
      'RO Machine Log Sheet / Feuille de relevé de machine RO';

  @override
  String get phtMenuVitalChart =>
      'Dialysis Vital Chart / Graphique des constantes de dialyse';

  @override
  String get phtMenuInvestChart =>
      'Dialysis Investigation Result Chart / Graphique des résultats d\'examens de dialyse';

  @override
  String get colParticulars => 'Particulars / Détails';

  @override
  String get colReport => 'Report / Rapport';

  @override
  String get colDrugs => 'Drugs / Médicaments';

  @override
  String get colFreq => 'Freq / Fréq.';

  @override
  String get colPackageName => 'Package Name / Nom du forfait';

  @override
  String get colClinicalHistoryDate =>
      'Clinical History Date / Date des antécédents cliniques';

  @override
  String get colInstructionName => 'Instruction Name / Nom de la consigne';

  @override
  String get colComorbidities => 'Comorbidities / Comorbidités';

  @override
  String get colYesNo => 'Yes/No / Oui/Non';

  @override
  String get nephroAddClinicalCondition =>
      'Add Clinical Condition / Ajouter un état clinique';

  @override
  String get nephroEditClinicalCondition =>
      'Edit Clinical Condition / Modifier l\'état clinique';

  @override
  String get nephroConsultantName => 'Consultant Name / Nom du consultant';

  @override
  String get nephroEvent => 'Event / Événement';

  @override
  String get nephroChoosePackages => 'Choose Packages / Choisir des forfaits';

  @override
  String get nephroDeleteTest => 'Delete Test / Supprimer le test';

  @override
  String get nephroDeleteTestConfirm =>
      'Are you sure you want to delete this test? / Êtes-vous sûr de vouloir supprimer ce test ?';

  @override
  String get nephroTestAlreadyAssigned =>
      'This test is already assigned to the patient / Ce test est déjà attribué au patient';

  @override
  String get nephroAddPrescription =>
      'Add Prescription / Ajouter une prescription';

  @override
  String get nephroEditPrescription =>
      'Edit Prescription / Modifier la prescription';

  @override
  String get nephroMorning => 'Morning / Matin';

  @override
  String get nephroAfternoon => 'Afternoon / Après-midi';

  @override
  String get nephroEvening => 'Evening / Soir';

  @override
  String get nephroNight => 'Night / Nuit';

  @override
  String get nephroStrength => 'Strength / Concentration';

  @override
  String get nephroDose => 'Dose';

  @override
  String get nephroPrescribedBy => 'Prescribed by / Prescrit par';

  @override
  String get nephroAddDiet => 'Add Diet / Ajouter un régime alimentaire';

  @override
  String get nephroEditDiet => 'Edit Diet / Modifier le régime alimentaire';

  @override
  String get nephroIndividualInstructions =>
      'Individual Instructions / Consignes individuelles';

  @override
  String get nephroDeleteInstruction =>
      'Delete Instruction / Supprimer la consigne';

  @override
  String get nephroSaveInstructions =>
      'Save Instructions / Enregistrer les consignes';

  @override
  String get schedDialysisCenter => 'Dialysis Center / Centre de dialyse';

  @override
  String get schedState => 'State / État';

  @override
  String schedApprovalInProcess(String type) {
    return 'Approval from $type is in process / L\'approbation de $type est en cours';
  }

  @override
  String get schedFrequencyScheduleMismatch =>
      'Please schedule according to the selected frequency / Veuillez planifier selon la fréquence sélectionnée';

  @override
  String get schedSelectDateAndSlot =>
      'Please select date and slot / Veuillez sélectionner la date et le créneau';

  @override
  String get schedAlreadyBooked => 'Already Booked / Déjà réservé';

  @override
  String schedAppointmentAlreadyGiven(String date) {
    return 'Appointment already given on $date / Rendez-vous déjà attribué le $date';
  }

  @override
  String get schedSlotNotAvailable =>
      'Slot Not Available / Créneau non disponible';

  @override
  String schedOnThisDate(String date) {
    return 'On this date $date / À cette date $date';
  }

  @override
  String get schedScheduleConfirmed =>
      'Schedule Confirmed / Planification confirmée';

  @override
  String get schedScheduleConfirmedMsg =>
      'Your schedule has been successfully confirmed. / Votre planification a été confirmée avec succès.';

  @override
  String get schedAddSchedularFailed =>
      'Add Schedular Failed / Échec de l\'ajout de la planification';

  @override
  String get schedViewLabInvest =>
      'View Lab Invest / Voir l\'examen de laboratoire';

  @override
  String get schedAppointmentCancelled =>
      'Appointment Cancelled / Rendez-vous annulé';

  @override
  String get schedAppointmentCancelledMsg =>
      'Appointment Cancelled Successfully / Rendez-vous annulé avec succès';

  @override
  String get schedCancelAppointmentConfirm =>
      'Are you sure? Do you want to cancel the appointment? / Êtes-vous sûr ? Voulez-vous annuler le rendez-vous ?';

  @override
  String get clinFinalUfv => 'Final UFV / UFV final';

  @override
  String get clinVenousPressure => 'Venous Pressure / Pression veineuse';

  @override
  String get clinBloodFlowQb => 'Blood Flow (QB) / Débit sanguin (QB)';

  @override
  String get clinDialysateFlowQd =>
      'Dialysate Flow (QD) / Débit du dialysat (QD)';

  @override
  String get clinRrfUrineVolume =>
      'RRF Urine Volume (ml/Day) / Volume urinaire RRF (ml/jour)';

  @override
  String get clinPercentOfFbv => '% of FBV / % du VFB';

  @override
  String get commonNoConsultationDetails =>
      'No consultation details available. / Aucun détail de consultation disponible.';

  @override
  String get commonChooseFile => 'Choose File / Choisir un fichier';

  @override
  String get schedOxygenSupplyAvailable =>
      'Enough Oxygen Supply Available At The Bed / Alimentation en oxygène suffisante disponible au lit';

  @override
  String get schedFuelAvailableGenset =>
      'Enough Fuel Available for GenSet at the Hospital / Carburant suffisant disponible pour le groupe électrogène de l\'hôpital';

  @override
  String get schedIronSucrose => 'Iron Sucrose / Fer saccharose';

  @override
  String get schedCurrentSessionUnderScheme =>
      'Current Dialysis Session Under The Scheme / Séance de dialyse actuelle dans le cadre du régime';

  @override
  String get schedLastSessionUnderScheme =>
      'Last Dialysis Session Under The Scheme / Dernière séance de dialyse dans le cadre du régime';

  @override
  String get schedReasonNotRegisteredMjpjay =>
      'Reason for not registered on MJPJAY / Motif de non-inscription à MJPJAY';

  @override
  String schedPendingSession(String count) {
    return 'Pending Session $count / Séance en attente $count';
  }

  @override
  String schedEffectiveDatePendingSession(String date, String count) {
    return 'Effective Date $date and Pending Session $count / Date d\'effet $date et séance en attente $count';
  }

  @override
  String get bookConfirmBookAppointment =>
      'Are you sure?\nDo you want to book appointment / Êtes-vous sûr ?\nVoulez-vous prendre le rendez-vous ?';

  @override
  String get bookSelectBed =>
      'Please Select Bed / Veuillez sélectionner un lit';

  @override
  String get schedDieticianConsultationDone =>
      'Dietician Consultation Done / Consultation diététique effectuée';

  @override
  String get schedNephrologistComment =>
      'Nephrologist\'s Comment / Commentaire du néphrologue';

  @override
  String get schedPatientAbsent => 'Patient Absent';

  @override
  String get dqLastDialysisSession =>
      'Last dialysis session / Dernière séance de dialyse';

  @override
  String get clinAccessType => 'Access Type / Type d\'accès';

  @override
  String get clinExpectedFiberBundleVolume =>
      'Expected Fiber Bundle Volume / Volume attendu du faisceau de fibres';

  @override
  String get clinDialyzerBarcodeNo =>
      'Dialyzer Barcode No / N° de code-barres du dialyseur';

  @override
  String get clinTubeBarcodeNo => 'Tube Barcode No / N° de code-barres du tube';

  @override
  String get clinTubeReuseNo => 'Tube Reuse No / N° de réutilisation du tube';

  @override
  String get clinBloodTubeRemark =>
      'Blood Tube Remark / Remarque sur la tubulure sanguine';

  @override
  String get clinNewBloodTubing =>
      'New Blood Tubing / Nouvelle tubulure sanguine';

  @override
  String get clinPulseBeatsMin =>
      'Pulse\n(Beats/min) / Pouls\n(battements/min)';

  @override
  String get clinOxygenLevelPercent =>
      'Oxygen Level (%) / Niveau d\'oxygène (%)';

  @override
  String get clinRespiratoryRateBreathsMin =>
      'Respiratory Rate (Breaths/min) / Fréquence respiratoire (resp./min)';

  @override
  String get commonBottom => 'Bottom / Bas';

  @override
  String get commonTop => 'Top / Haut';

  @override
  String get dqViewHistory => 'View History / Voir l\'historique';

  @override
  String get dqDiscardedRemarksWarning =>
      'Kindly enter discarded remarks before using new dialyser and blood tubing / Veuillez saisir les remarques sur le matériel écarté avant d\'utiliser un nouveau dialyseur et une nouvelle tubulure sanguine';

  @override
  String get dqDialysisHistory => 'Dialysis History / Historique de dialyse';

  @override
  String get dqTubeHistory => 'Tube History / Historique de la tubulure';

  @override
  String get clinCurrentWgtDiff => 'Current Wgt Diff / Diff. poids actuel';

  @override
  String get clinTotalHeparinUsed =>
      'Total Heparin Used / Total d\'héparine utilisée';

  @override
  String get clinFinalKtv => 'Final KT/V / KT/V final';

  @override
  String get clinActualFiberBundleVolume =>
      'Actual Fiber Bundle Volume / Volume réel du faisceau de fibres';

  @override
  String get clinPercentageFiberBundle =>
      'Percentage Fiber Bundle / Pourcentage du faisceau de fibres';

  @override
  String get clinLastHgb =>
      'Last Hgb (Hemoglobin): / Dernière Hgb (hémoglobine) :';

  @override
  String get clinIronPreparation => 'Iron Preparation / Préparation de fer';

  @override
  String get clinIronDose => 'Iron Dose / Dose de fer';

  @override
  String get clinIronFrequency => 'Iron Frequency / Fréquence du fer';

  @override
  String get clinIronRoute => 'Iron Route / Voie d\'administration du fer';

  @override
  String get clinIronStartDate => 'Iron Start Date / Date de début du fer';

  @override
  String get clinIronProtocolUsed =>
      'Iron Protocol Used / Protocole de fer utilisé';

  @override
  String get clinFerritinLevel => 'Ferritin Level / Taux de ferritine';

  @override
  String get clinBloodTransfusionPost =>
      'Blood Transfusion (Post Dialysis) / Transfusion sanguine (post-dialyse)';

  @override
  String get clinVolumeMl => 'Volume (mL)';

  @override
  String get clinDialysisDurationRemark =>
      'Dialysis Duration Remark / Remarque sur la durée de dialyse';

  @override
  String get clinDialysisDurationDescription =>
      'Dialysis Duration Description / Description de la durée de dialyse';

  @override
  String get clinEpoBrandName => 'EPO Brand Name / Nom de marque de l\'EPO';

  @override
  String get clinEpoFrequency => 'EPO Frequency / Fréquence de l\'EPO';

  @override
  String get clinEpoRoute => 'EPO Route / Voie d\'administration de l\'EPO';

  @override
  String get clinEpoStartDate => 'EPO Start Date / Date de début de l\'EPO';

  @override
  String get clinEpoIndication => 'EPO Indication / Indication de l\'EPO';

  @override
  String get dqHdTreatmentCount =>
      'Hd Treatment Count / Nombre de traitements HD';

  @override
  String get clinPreDialysisWeightKgs =>
      'Pre-Dialysis Weight (kgs) / Poids pré-dialyse (kg)';

  @override
  String get clinPostDialysisWeightKgs =>
      'Post Dialysis Weight (kgs) / Poids post-dialyse (kg)';

  @override
  String get clinIntradialyticWeightKgs =>
      'Intradialytic Weight (kgs) / Poids intradialytique (kg)';

  @override
  String get clinDryWeightKgs => 'Dry Weight (kgs) / Poids sec (kg)';

  @override
  String get clinWeightLoss => 'Weight Loss / Perte de poids';

  @override
  String get clinUfTarget => 'UF Target (Ltrs) / Objectif UF (L)';

  @override
  String get clinUfTargetAchieved =>
      'UF Target Achieved (Ltrs) / Objectif UF atteint (L)';

  @override
  String get clinAirDetectorLineClamp =>
      'Air Detector / Line Clamp / Détecteur d\'air / clamp de ligne';

  @override
  String get clinAlarmLimitSet => 'Alarm Limit Set / Limite d\'alarme réglée';

  @override
  String get clinHeparinPumpOn => 'Heparin Pump on / Pompe à héparine activée';

  @override
  String get clinDialysateFlowMlMin =>
      'Dialysate Flow (ml/min) / Débit du dialysat (ml/min)';

  @override
  String get clinPulseBpm => 'Pulse (bpm) / Pouls (bpm)';

  @override
  String get clinInjectionEpoIron =>
      'Injection EPO / Iron / Injection EPO / fer';

  @override
  String get clinDialysateTempC =>
      'Dialysate Temp (°C) / Temp. du dialysat (°C)';

  @override
  String get clinRespiratoryRateRpm =>
      'Respiratory Rate (rpm) / Fréquence respiratoire (rpm)';

  @override
  String get clinConcentrateNa =>
      'Concentrate Na+ (mmol / L) / Concentré Na+ (mmol/L)';

  @override
  String get clinTemperatureF => 'Temperature (°F) / Température (°F)';

  @override
  String get clinPtTemperatureF => 'Pt. Temperature (°F) / Temp. patient (°F)';

  @override
  String get clinConductivityMho => 'Conductivity (mho) / Conductivité (mho)';

  @override
  String get clinHdStartedBy => 'HD Started By / HD commencée par';

  @override
  String get clinHdCompletedBy => 'HD Completed By / HD terminée par';

  @override
  String get dischDietician => 'Dietician / Diététicien';

  @override
  String get dischTermsVerified =>
      'I have verified all dialysis stages and patient details / J\'ai vérifié tous les stades de dialyse et les détails du patient';

  @override
  String get roMachineName => 'RO Machine Name / Nom de la machine RO';

  @override
  String get commonUploadImage => 'Upload Image / Téléverser une image';

  @override
  String get roAddDisinfectionDetails =>
      'Add RO Disinfection Details / Ajouter les détails de désinfection RO';

  @override
  String get roEditDisinfectionDetails =>
      'Edit RO Disinfection Details / Modifier les détails de désinfection RO';

  @override
  String get roNextInspectionBeforeError =>
      'Next Inspection Date should not be before Inspection Date / La date de la prochaine inspection ne doit pas être antérieure à la date d\'inspection';

  @override
  String get roAddMachineIssueLog =>
      'Add RO Machine Issue Logs / Ajouter un journal des incidents de machine RO';

  @override
  String get roEditMachineIssueLog =>
      'Edit RO Machine Issue Logs / Modifier le journal des incidents de machine RO';

  @override
  String get roSandFilterPressure =>
      'Sand Filter Pressure / Pression du filtre à sable';

  @override
  String get commonInactive => 'Inactive / Inactif';

  @override
  String get roSandFilterPressurePsi =>
      'Sand Filter Pressure (PSI) / Pression du filtre à sable (PSI)';

  @override
  String get roSoftenerAvailable =>
      'Softener Available / Adoucisseur disponible';

  @override
  String get roHardnessPostSoftenerPpm =>
      'Hardness of Post Softener Water (PPM) / Dureté de l\'eau après adoucisseur (PPM)';

  @override
  String get roBeforeRegenerationHardnessPpm =>
      'Before Regeneration Hardness (PPM) / Dureté avant régénération (PPM)';

  @override
  String get roAfterRegenerationHardnessPpm =>
      'After Regeneration Hardness (PPM) / Dureté après régénération (PPM)';

  @override
  String get roPreMembranePressure =>
      'Pre Membrane Pressure / Pression pré-membrane';

  @override
  String get roRejectPressure => 'Reject Pressure / Pression de rejet';

  @override
  String get roPermeateFlowLph =>
      'Permeate Flow (LPH) / Débit du perméat (LPH)';

  @override
  String get roCarbonChlorideWaterConductivity =>
      'Carbon Chloride and Water Conductivity / Chlore du carbone et conductivité de l\'eau';

  @override
  String get roPostCarbonChloridePpm =>
      'Post Carbon Chloride (PPM) / Chlore après carbone (PPM)';

  @override
  String get roRoWaterConductivity =>
      'RO Water Conductivity / Conductivité eau RO';

  @override
  String get roHighPressurePump => 'High Pressure Pump / Pompe haute pression';

  @override
  String get roUfMicronFilter => 'UF/Micron Filter / Filtre UF/micron';

  @override
  String get roDosingSystem => 'Dosing System / Système de dosage';

  @override
  String roValueLessThan(String value) {
    return 'Value must be less than $value / La valeur doit être inférieure à $value';
  }

  @override
  String roValueGreaterThan(String value) {
    return 'Value must be greater than $value / La valeur doit être supérieure à $value';
  }

  @override
  String roValueBetween(String min, String max) {
    return 'Value must be between $min and $max / La valeur doit être comprise entre $min et $max';
  }

  @override
  String get roEnterValidNumber =>
      'Please enter a valid number / Veuillez saisir un nombre valide';

  @override
  String get roMachine => 'RO Machine / Machine RO';

  @override
  String get roAddDailyLogSheet =>
      'Add Daily RO Log Sheet / Ajouter une feuille de relevé RO quotidienne';

  @override
  String get roEditDailyLogSheet =>
      'Edit Daily RO Log Sheet / Modifier la feuille de relevé RO quotidienne';

  @override
  String get commonParameter => 'Parameter / Paramètre';

  @override
  String get commonUnits => 'Units / Unités';

  @override
  String get commonValues => 'Values / Valeurs';

  @override
  String get roRawWaterTdsLabel => 'Raw Water TDS / TDS eau brute';

  @override
  String get roPostSoftenerTdsLabel =>
      'Post Softener TDS / TDS post-adoucisseur';

  @override
  String get roPostMembraneTdsLabel => 'Post Membrane TDS / TDS post-membrane';

  @override
  String get roPostMixbedTdsLabel => 'Post Mixbed TDS / TDS post-lit mixte';

  @override
  String get roLooplineTdsLabel => 'Loopline TDS / TDS boucle';

  @override
  String get roPostSoftenerHardnessLabel =>
      'Post Softener Hardness / Dureté post-adoucisseur';

  @override
  String get roPostCarbonFilterChlorineLabel =>
      'Post Carbon Filter Chlorine / Chlore post-filtre à charbon';

  @override
  String get roRejectFlowLabel => 'Reject Flow / Débit de rejet';

  @override
  String get roProductPermeateFlowLabel =>
      'Product / Permeate Flow / Débit produit / perméat';

  @override
  String get machMachineSerialNo =>
      'Machine Serial No. / N° de série de la machine';

  @override
  String get uploadFeedbackForm => 'FeedBack Form / Formulaire de retour';

  @override
  String get machTodaysReadingHours =>
      'Today\'s Reading (Hours) / Relevé du jour (heures)';

  @override
  String get machLastReadingHours =>
      'Last Reading (Hours) / Dernier relevé (heures)';
}
