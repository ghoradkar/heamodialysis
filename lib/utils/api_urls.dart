class ApiConstants {
  ///Replica
  // static String ipPort = "http://210.89.42.115:9999";

  //test
  // static String ipPort = "http://210.89.42.122:8080";

  ///dev
  // static String ipPort = "http://210.89.42.115:8080";

  // static String ip = "$ipPort/$commonPath1/";
  // static String commonPath1 = "Hemodialysis-Apis";
  // static String commonPath2 = "/cluster-dashborad/";
  //
  // static String oldBaseUrl = ipPort.contains('http://210.89.42.122:8080')
  //     ? "$ipPort/HAEMODIALYSIS/restApi"
  //     : "$ipPort/HAEMODIALYSIS-Replica/restApi";
  //
  // static String baseUrl = "$ipPort/$commonPath1/api/mobile";
  // static String baseUrl1 = "$ipPort/$commonPath1/hemodialysis-api";
  // static String baseUrl4 = "$ipPort/$commonPath1/dashborad";
  // // static String baseUrl5 = "$ipPort/$commonPath3";
  // static String baseUrlMIS = "$ipPort/$commonPath1/misDashboard";
  // static String baseUrlCluster = "$ipPort/$commonPath1/cluster-dashborad";
  // static String baseUrlNeph = "$ipPort/$commonPath1/nephroDashboard";
  // static String imageBaseUrl = "$ipPort/HAEMODIALYSIS/Images/";
  // static String imageBaseUrl1 = "$ipPort/HAEMODIALYSIS/Uploaded_RO/";
  // static String documentImageBaseUrl = "$ipPort/HAEMODIALYSIS-Replica/Images/";

// ///Production
static String ipPort = "https://api.mahadialysis.in/Mahadialysis-Apis/api/mobile";
static String ip = "https://api.mahadialysis.in/Mahadialysis-Apis/";
static String ip1 = "https://app.mahadialysis.in";
static String commonPath1 = "Hemodialysis-Apis";
// static String commonPath3 = "Mahadialysis";
  static String documentImageBaseUrl = "https://app.mahadialysis.in/Mahadialysis/";

static String oldBaseUrl = "$ip1/Mahadialysis/restApi";

static String baseUrl = ipPort;
static String baseUrl1 = "$ip/hemodialysis-api";
static String baseUrl4 = "$ip/dashborad";
// static String baseUrl5 = "http://103.104.73.130:8080/$commonPath3";

static String baseUrlNeph = "$ip/nephroDashboard";

static String baseUrl6 = "$ip1/Mahadialysis/restApi";
static String baseUrlCluster = "$ip/cluster-dashborad/";

static String imageBaseUrl = "$ip1/Mahadialysis/Images/";
static String imageBaseUrl1 = "$ipPort/HAEMODIALYSIS/Uploaded_RO/";
static String baseUrlMIS = "$ip/misDashboard";
}

