enum APIMode { dev, test, replica, prod }

class ApiConstants {
  /// Change this single line to switch environment for the whole app:
  /// APIMode.dev / APIMode.test / APIMode.replica / APIMode.prod
  static APIMode apiMode = APIMode.replica;

  /// True only for the real backend. Used to warn testers when
  /// a build is accidentally pointed at dev/test/replica.
  static bool get isProd => apiMode == APIMode.prod;

  static String get environmentName => apiMode.name.toUpperCase();

  static String get ipPort {
    switch (apiMode) {
      case APIMode.dev:
        return "http://210.89.42.115:8080";
      case APIMode.test:
        return "http://210.89.42.122:8080";
      case APIMode.replica:
        return "http://210.89.42.115:9999";
      case APIMode.prod:
        return "https://api.mahadialysis.in/Mahadialysis-Apis/api/mobile";
    }
  }

  static const String commonPath1 = "Hemodialysis-Apis";
  static const String commonPath2 = "/cluster-dashborad/";

  static String get ip {
    switch (apiMode) {
      case APIMode.prod:
        return "https://api.mahadialysis.in/Mahadialysis-Apis/";
      case APIMode.dev:
      case APIMode.test:
      case APIMode.replica:
        return "$ipPort/$commonPath1/";
    }
  }

  static String get oldBaseUrl {
    switch (apiMode) {
      case APIMode.test:
        return "$ipPort/HAEMODIALYSIS/restApi";
      case APIMode.dev:
      case APIMode.replica:
        return "$ipPort/HAEMODIALYSIS-Replica/restApi";
      case APIMode.prod:
        return "https://app.mahadialysis.in/Mahadialysis/restApi";
    }
  }

  static String get baseUrl {
    switch (apiMode) {
      case APIMode.prod:
        return ipPort; // ipPort already includes /api/mobile in prod
      case APIMode.dev:
      case APIMode.test:
      case APIMode.replica:
        return "$ipPort/$commonPath1/api/mobile";
    }
  }

  static String get baseUrl1 {
    switch (apiMode) {
      case APIMode.prod:
        return "$ip/hemodialysis-api";
      case APIMode.dev:
      case APIMode.test:
      case APIMode.replica:
        return "$ipPort/$commonPath1/hemodialysis-api";
    }
  }

  static String get baseUrl4 {
    switch (apiMode) {
      case APIMode.prod:
        return "$ip/dashborad";
      case APIMode.dev:
      case APIMode.test:
      case APIMode.replica:
        return "$ipPort/$commonPath1/dashborad";
    }
  }

  static String get baseUrlMIS {
    switch (apiMode) {
      case APIMode.prod:
        return "$ip/misDashboard";
      case APIMode.dev:
      case APIMode.test:
      case APIMode.replica:
        return "$ipPort/$commonPath1/misDashboard";
    }
  }

  static String get baseUrlCluster {
    switch (apiMode) {
      case APIMode.prod:
        return "$ip/cluster-dashborad";
      case APIMode.dev:
      case APIMode.test:
      case APIMode.replica:
        return "$ipPort/$commonPath1/cluster-dashborad";
    }
  }

  static String get baseUrlNeph {
    switch (apiMode) {
      case APIMode.prod:
        return "$ip/nephroDashboard";
      case APIMode.dev:
      case APIMode.test:
      case APIMode.replica:
        return "$ipPort/$commonPath1/nephroDashboard";
    }
  }

  static String get imageBaseUrl {
    switch (apiMode) {
      case APIMode.prod:
        return "https://app.mahadialysis.in/Mahadialysis/Images/";
      case APIMode.dev:
      case APIMode.test:
      case APIMode.replica:
        return "$ipPort/HAEMODIALYSIS/Images/";
    }
  }

  static String get imageBaseUrl1 => "$ipPort/HAEMODIALYSIS/Uploaded_RO/";

  static String get documentImageBaseUrl {
    switch (apiMode) {
      case APIMode.prod:
        return "https://app.mahadialysis.in/Mahadialysis/";
      case APIMode.dev:
      case APIMode.test:
      case APIMode.replica:
        return "$ipPort/HAEMODIALYSIS-Replica/Images/";
    }
  }
}
