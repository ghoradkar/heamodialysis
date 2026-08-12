// // YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation
//
// import 'dart:convert';
//
// InstitudeWiseCctv institudeWiseCctvFromJson(String str) => InstitudeWiseCctv.fromJson(json.decode(str));
//
// String institudeWiseCctvToJson(InstitudeWiseCctv data) => json.encode(data.toJson());
//
// class InstitudeWiseCctv {
//     InstitudeWiseCctv({
//         required this.unitName,
//         required this.unitId,
//         required this.cctvUserId,
//         required this.cctvUserPassword,
//     });
//
//     String unitName;
//     String unitId;
//     String cctvUserId;
//     String cctvUserPassword;
//
//     factory InstitudeWiseCctv.fromJson(Map<dynamic, dynamic> json) => InstitudeWiseCctv(
//         unitName: json["unitName"],
//         unitId: json["unitId"],
//         cctvUserId: json["cctvUserId"],
//         cctvUserPassword: json["cctvUserPassword"],
//     );
//
//     Map<dynamic, dynamic> toJson() => {
//         "unitName": unitName,
//         "unitId": unitId,
//         "cctvUserId": cctvUserId,
//         "cctvUserPassword": cctvUserPassword,
//     };
// }
