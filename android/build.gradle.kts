plugins {
    id("com.android.library")
    id("org.jetbrains.kotlin.android")
    // Apply Flutter plugin to add embedding dependencies
    id("dev.flutter.flutter-gradle-plugin")
}

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(21))
    }
}

kotlin {
    jvmToolchain(21)
}

group = "com.logger.logging_to_logcat"
version = "1.0-SNAPSHOT"

android {
    namespace = "com.logger.logging_to_logcat"

    compileSdk = 34

    defaultConfig {
        minSdk = 19
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_21
        targetCompatibility = JavaVersion.VERSION_21
    }

    kotlinOptions {
        jvmTarget = "21"
    }
    sourceSets["main"].java.srcDirs("src/main/kotlin")
}

repositories {
    google()
    mavenCentral()
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.9.20")
}
