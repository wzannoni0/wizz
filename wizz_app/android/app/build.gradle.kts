plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.wizz.chat"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.wizz.chat"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    val ksProps = java.util.Properties()
    val ksFile = rootProject.file("key.properties")
    if (ksFile.exists()) ksProps.load(ksFile.inputStream())
    fun ksProp(env: String, file: String): String? =
        System.getenv(env) ?: ksProps.getProperty(file)
    val ksPath = ksProp("ANDROID_KEYSTORE_FILE", "storeFile")
    val hasReleaseKey = !ksPath.isNullOrBlank()

    signingConfigs {
        create("release") {
            if (hasReleaseKey) {
                storeFile = file(ksPath!!)
                storePassword = ksProp("ANDROID_KEYSTORE_PASSWORD", "storePassword")
                keyAlias = ksProp("ANDROID_KEY_ALIAS", "keyAlias")
                keyPassword = ksProp("ANDROID_KEY_PASSWORD", "keyPassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (hasReleaseKey) signingConfigs.getByName("release")
                            else signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
