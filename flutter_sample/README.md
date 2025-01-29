## iOS Camera Permission Setup

To enable camera functionality in this project, you need to add the necessary permissions in the `Info.plist` file. Follow these steps:

1. Open your Xcode project.
2. Navigate to the **Info.plist** file.
3. Add the following key-value pair to request camera access from users:

   ```xml
   <key>NSCameraUsageDescription</key>
   <string>This app requires access to the camera for capturing images and videos.</string>

Failing to include this permission will result in the app being unable to access the camera, leading to potential crashes or limited functionality.
