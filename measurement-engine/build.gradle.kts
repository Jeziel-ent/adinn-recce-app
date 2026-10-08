// Standalone Kotlin measurement engine. Deliberately free of Flutter (and any UI)
// dependencies so it can be unit-tested and reused independently of the app.
plugins {
    id("com.android.library")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.adinn.recce.measurement"
    compileSdk = 36

    defaultConfig {
        minSdk = 24 // ARCore minimum
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    sourceSets {
        getByName("main").java.srcDir("src/main/kotlin")
        getByName("test").java.srcDir("src/test/kotlin")
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

dependencies {
    // Spatial tracking (SLAM / VIO, camera pose, hit-testing, Depth API)
    implementation("com.google.ar:core:1.56.0")

    // Camera pipeline
    implementation("androidx.camera:camera-core:1.6.2")
    implementation("androidx.camera:camera-camera2:1.6.2")
    implementation("androidx.camera:camera-lifecycle:1.6.2")

    testImplementation("junit:junit:4.13.2")
}
