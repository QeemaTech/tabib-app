plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.tabib_app"
    compileSdk = 37
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.qeema.tabeeb"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    packaging {
        jniLibs {
            // Basic video/voice calls only. These Agora extensions are never loaded.
            excludes += listOf(
                "**/libagora_lip_sync_extension.so",
                "**/libagora_clear_vision_extension.so",
                "**/libagora_spatial_audio_extension.so",
                "**/libagora_ai_noise_suppression_extension.so",
                "**/libagora_face_capture_extension.so",
                "**/libagora_segmentation_extension.so",
                "**/libagora_ai_echo_cancellation_extension.so",
                "**/libagora_audio_beauty_extension.so",
                "**/libagora_content_inspect_extension.so",
                "**/libagora_video_quality_analyzer_extension.so",
                "**/libagora_video_av1_encoder_extension.so",
                "**/libagora_face_detection_extension.so",
                "**/libagora_screen_capture_extension.so",
            )
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
    }
}

// abiFilters does not strip prebuilt .so files from Agora/Flutter.
// Drop emulator ABIs from release only so debug on x86_64 emulators still works.
androidComponents {
    onVariants(selector().withBuildType("release")) { variant ->
        variant.packaging.jniLibs.excludes.add("lib/x86_64/**")
        variant.packaging.jniLibs.excludes.add("lib/x86/**")
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

flutter {
    source = "../.."
}
