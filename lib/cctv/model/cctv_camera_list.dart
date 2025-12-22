// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

CctvCameraList cctvCameraListFromJson(String str) =>
    CctvCameraList.fromJson(json.decode(str));

String cctvCameraListToJson(CctvCameraList data) => json.encode(data.toJson());

class CctvCameraList {
  CctvCameraList({
    required this.c,
  });

  String c;

  factory CctvCameraList.fromJson(Map<dynamic, dynamic> json) => CctvCameraList(
        c: json["c"],
      );

  Map<dynamic, dynamic> toJson() => {
        "c": c,
      };
}
