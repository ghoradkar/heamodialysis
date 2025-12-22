class DoneByData {
  DoneByData({
      this.userID, 
      this.fullName, 
      this.title, 
      this.fName, 
      this.mName, 
      this.lName, 
      this.userName, 
      this.userType, 
      this.password, 
      this.createdDate, 
      this.availability, 
      this.status, 
      this.usersList, 
      this.docId, 
      this.usersCount, 
      this.docName, 
      this.district, 
      this.lastLogedInDateTime, 
      this.lastLogedOutDateTime, 
      this.currentLogedInDateTime, 
      this.currentLogedOutDateTime, 
      this.softwareUsed, 
      this.dcTypeMasterID, 
      this.mulSelunit, 
      this.doctorTypeIdList, 
      this.mulDeptid, 
      this.mulServiceid, 
      this.adminServiceid, 
      this.empIdhr, 
      this.logedInStatus, 
      this.createdBy, 
      this.updatedBy,
      this.updatedDate, 
      this.deleted, 
      this.deletedBy, 
      this.deletedDate, 
      this.unitId, 
      this.signOne, 
      this.signOneDoctor, 
      this.signTwo, 
      this.signTwoDoctor, 
      this.allServicesFlag, 
      this.addUserSign, 
      this.emailId, 
      this.userid, 
      this.username,});

  DoneByData.fromJson(dynamic json) {
    userID = json['user_ID'];
    fullName = json['full_name'];
    title = json['title'];
    fName = json['f_name'];
    mName = json['m_name'];
    lName = json['l_name'];
    userName = json['user_Name'];
    userType = json['user_Type'];
    password = json['password'];
    createdDate = json['created_Date'];
    availability = json['availability'];
    status = json['status'];
    usersList = json['usersList'];
    docId = json['doc_id'];
    usersCount = json['usersCount'];
    docName = json['doc_name'];
    district = json['district'];
    lastLogedInDateTime = json['last_loged_in_date_time'];
    lastLogedOutDateTime = json['last_loged_out_date_time'];
    currentLogedInDateTime = json['current_loged_in_date_time'];
    currentLogedOutDateTime = json['current_loged_out_date_time'];
    softwareUsed = json['softwareUsed'];
    dcTypeMasterID = json['dcTypeMasterID'];
    mulSelunit = json['mulSelunit'];
    doctorTypeIdList = json['doctorTypeIdList'];
    mulDeptid = json['mulDeptid'];
    mulServiceid = json['mulServiceid'];
    adminServiceid = json['adminServiceid'];
    empIdhr = json['empIdhr'];
    logedInStatus = json['logedInStatus'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deleted = json['deleted'];
    deletedBy = json['deletedBy'];
    deletedDate = json['deletedDate'];
    unitId = json['unitId'];
    signOne = json['sign_one'];
    signOneDoctor = json['sign_one_doctor'];
    signTwo = json['sign_two'];
    signTwoDoctor = json['sign_two_doctor'];
    allServicesFlag = json['allServicesFlag'];
    addUserSign = json['addUserSign'];
    emailId = json['emailId'];
    userid = json['userid'];
    username = json['username'];
  }
  int? userID;
  dynamic fullName;
  dynamic title;
  dynamic fName;
  dynamic mName;
  dynamic lName;
  dynamic userName;
  dynamic userType;
  dynamic password;
  dynamic createdDate;
  dynamic availability;
  dynamic status;
  dynamic usersList;
  int? docId;
  dynamic usersCount;
  dynamic docName;
  dynamic district;
  dynamic lastLogedInDateTime;
  dynamic lastLogedOutDateTime;
  dynamic currentLogedInDateTime;
  dynamic currentLogedOutDateTime;
  dynamic softwareUsed;
  int? dcTypeMasterID;
  dynamic mulSelunit;
  dynamic doctorTypeIdList;
  dynamic mulDeptid;
  dynamic mulServiceid;
  dynamic adminServiceid;
  dynamic empIdhr;
  dynamic logedInStatus;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic updatedDate;
  String? deleted;
  dynamic deletedBy;
  dynamic deletedDate;
  dynamic unitId;
  dynamic signOne;
  dynamic signOneDoctor;
  dynamic signTwo;
  dynamic signTwoDoctor;
  dynamic allServicesFlag;
  dynamic addUserSign;
  dynamic emailId;
  int? userid;
  String? username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_ID'] = userID;
    map['full_name'] = fullName;
    map['title'] = title;
    map['f_name'] = fName;
    map['m_name'] = mName;
    map['l_name'] = lName;
    map['user_Name'] = userName;
    map['user_Type'] = userType;
    map['password'] = password;
    map['created_Date'] = createdDate;
    map['availability'] = availability;
    map['status'] = status;
    map['usersList'] = usersList;
    map['doc_id'] = docId;
    map['usersCount'] = usersCount;
    map['doc_name'] = docName;
    map['district'] = district;
    map['last_loged_in_date_time'] = lastLogedInDateTime;
    map['last_loged_out_date_time'] = lastLogedOutDateTime;
    map['current_loged_in_date_time'] = currentLogedInDateTime;
    map['current_loged_out_date_time'] = currentLogedOutDateTime;
    map['softwareUsed'] = softwareUsed;
    map['dcTypeMasterID'] = dcTypeMasterID;
    map['mulSelunit'] = mulSelunit;
    map['doctorTypeIdList'] = doctorTypeIdList;
    map['mulDeptid'] = mulDeptid;
    map['mulServiceid'] = mulServiceid;
    map['adminServiceid'] = adminServiceid;
    map['empIdhr'] = empIdhr;
    map['logedInStatus'] = logedInStatus;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deleted'] = deleted;
    map['deletedBy'] = deletedBy;
    map['deletedDate'] = deletedDate;
    map['unitId'] = unitId;
    map['sign_one'] = signOne;
    map['sign_one_doctor'] = signOneDoctor;
    map['sign_two'] = signTwo;
    map['sign_two_doctor'] = signTwoDoctor;
    map['allServicesFlag'] = allServicesFlag;
    map['addUserSign'] = addUserSign;
    map['emailId'] = emailId;
    map['userid'] = userid;
    map['username'] = username;
    return map;
  }

}