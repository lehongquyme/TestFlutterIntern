import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory
//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//        maven { url = uri("https://storage.googleapis.com/download.flutter.io") }
//    }
//}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    // Đảm bảo app được evaluate trước
    project.evaluationDependsOn(":app")
}

// Task clean để xoá thư mục build
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
