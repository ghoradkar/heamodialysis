# --------------- Begin: ProGuard configuration for Gson ---------------
-keepattributes Signature
-keepattributes *Annotation*

-dontwarn sun.misc.**
# Replace with your actual model package (IMPORTANT)
-keep class com.yourapp.models.** { *; }

# Prevent ProGuard from stripping interface info used by @JsonAdapter
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Prevent R8 from nullifying @SerializedName fields
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# Retain generic signatures of TypeToken and its subclasses
-keep,allowobfuscation,allowshrinking class com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * extends com.google.gson.reflect.TypeToken

# --------------- Razorpay ---------------
-dontwarn com.razorpay.**
-keep class com.razorpay.** { *; }
-optimizations !method/inlining/
-keepclasseswithmembers class * {
    public void onPayment*(...);
}

# --------------- Stripe Push Provisioning ---------------
-dontwarn com.stripe.android.pushProvisioning.**

# --------------- Flutter / Dart ---------------
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**

# --------------- Firebase / Play Services (only if used) ---------------
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**
