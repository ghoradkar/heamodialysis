/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

// Some backend responses omit the '+' before the UTC offset, e.g.
// "2024-08-14 16:30:28.849556 05:30" instead of "...849556+05:30",
// which DateTime.parse rejects. Repair that case before parsing.
DateTime _parseDate(String value) {
    try {
        return DateTime.parse(value);
    } catch (_) {
        final match = RegExp(r'^(.*\d)\s+(\d{2}:\d{2})$').firstMatch(value.trim());
        if (match != null) {
            try {
                return DateTime.parse('${match.group(1)}+${match.group(2)}');
            } catch (_) {}
        }
        return DateTime.now();
    }
}

class LoginModel {
    LoginModel({
        required this.code,
        required this.dataDet,
        required this.status,
    });

    int code;
    DataDet dataDet;
    String status;

    factory LoginModel.fromJson(Map<dynamic, dynamic> json) => LoginModel(
        code: json["code"],
        dataDet: DataDet.fromJson(json["dataDet"]),
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "code": code,
        "dataDet": dataDet.toJson(),
        "status": status,
    };
}

class DataDet {
    DataDet({
        required this.lName,
        required this.mulSelunit,
        this.dataDetCreatedDate,
        this.availability,
        this.title,
        this.doctorTypeIdList,
        required this.unitId,
        required this.userType,
        this.softwareUsed,
        this.addUserSign,
        this.allServicesFlag,
        this.technicalUserFlag,
        this.docId,
        this.dcTypeMasterId,
        this.mulServiceid,
        required this.fullName,
        this.createdDate,
        this.deleted,
        required this.userName,
        required this.userId,
        required this.createdBy,
        this.district,
        required this.fName,
        this.status,
        this.mulDeptid,
    });

    String lName;
    String mulSelunit;
    DateTime? dataDetCreatedDate;
    String? availability;
    String? title;
    String? doctorTypeIdList;
    int unitId;
    String userType;
    String? softwareUsed;
    String? addUserSign;
    String? allServicesFlag;
    String? technicalUserFlag;
    int? docId;
    int? dcTypeMasterId;
    String? mulServiceid;
    String fullName;
    DateTime? createdDate;
    String? deleted;
    String userName;
    int userId;
    int createdBy;
    int? district;
    String fName;
    String? status;
    String? mulDeptid;

    factory DataDet.fromJson(Map<dynamic, dynamic> json) => DataDet(
        lName: json["l_name"],
        mulSelunit: json["mulSelunit"],
        dataDetCreatedDate: json["created_Date"] == null ? null : _parseDate(json["created_Date"]),
        availability: json["availability"],
        title: json["title"],
        doctorTypeIdList: json["doctorTypeIdList"],
        unitId: json["unitId"],
        userType: json["user_Type"],
        softwareUsed: json["softwareUsed"],
        addUserSign: json["addUserSign"],
        allServicesFlag: json["allServicesFlag"],
        technicalUserFlag: json["technicalUserFlag"],
        docId: json["doc_id"],
        dcTypeMasterId: json["dcTypeMasterID"],
        mulServiceid: json["mulServiceid"],
        fullName: json["full_name"],
        createdDate: json["createdDate"] == null ? null : _parseDate(json["createdDate"]),
        deleted: json["deleted"],
        userName: json["user_Name"],
        userId: json["user_ID"],
        createdBy: json["createdBy"],
        district: json["district"],
        fName: json["f_name"],
        status: json["status"],
        mulDeptid: json["mulDeptid"],
    );

    Map<dynamic, dynamic> toJson() => {
        "l_name": lName,
        "mulSelunit": mulSelunit,
        "created_Date": dataDetCreatedDate?.toIso8601String(),
        "availability": availability,
        "title": title,
        "doctorTypeIdList": doctorTypeIdList,
        "unitId": unitId,
        "user_Type": userType,
        "softwareUsed": softwareUsed,
        "addUserSign": addUserSign,
        "allServicesFlag": allServicesFlag,
        "technicalUserFlag": technicalUserFlag,
        "doc_id": docId,
        "dcTypeMasterID": dcTypeMasterId,
        "mulServiceid": mulServiceid,
        "full_name": fullName,
        "createdDate": createdDate?.toIso8601String(),
        "deleted": deleted,
        "user_Name": userName,
        "user_ID": userId,
        "createdBy": createdBy,
        "district": district,
        "f_name": fName,
        "status": status,
        "mulDeptid": mulDeptid,
    };
}
