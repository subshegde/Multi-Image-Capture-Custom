# Multi Image Capture Demo

![Multi image capture](https://github.com/user-attachments/assets/da8415a5-414e-46a9-be53-75c744182335)


This Flutter app allows users to capture multiple images using the camera and display them in a staggered grid view. The app uses the camera and flutter_staggered_grid_view packages for capturing and displaying images in a custom layout.
Features

    Camera Integration: Capture images with the device's camera.
    Multi-image Capture: Capture multiple images and view them in a grid layout.
    Staggered Grid View: Display captured images using a staggered grid for better organization.
    Switch Camera: Option to switch between front and back cameras.
    Delete Images: Remove captured images from the list.

# Packages Used

    camera: For capturing images using the device's camera.
    flutter_staggered_grid_view: For displaying images in a staggered grid layout.

# Installation

    Clone the repository:

https://github.com/subshegde/Multi-Image-Capture-Custom.git

# Install dependencies:

flutter pub get

# Run the app:

    flutter run

# Usage

    Open Camera: Tap on the camera button in the floating action button to open the camera screen.
    Capture Image: Tap the camera icon to capture an image.
    Switch Camera: Tap the switch camera icon to toggle between front and back cameras.
    View Captured Images: After capturing images, they will be displayed in a staggered grid on the home screen.
    Delete Images: Tap the delete icon on each image to remove it from the list.

# Code Structure
1. camera.dart

Contains the CameraScreen widget where users can capture images using the camera.

    initState: Initializes the camera and prepares for capturing images.
    captureImage: Takes a picture using the camera.
    switchCamera: Switches between the front and back camera.
    Displays captured images and allows them to be removed.

2. home.dart

Contains the HomePage widget, which displays the captured images in a staggered grid view.

    openCamera: Navigates to the camera screen for image capture.
    removeImage: Removes an image from the captured list.
    Displays images in a grid layout and allows them to be deleted.

# Video

https://github.com/user-attachments/assets/2d76d6ad-2d28-400c-809f-b0833d911e3a

# Future Improvements

    Add more features like image editing (rotate, crop).
    Support for storing images to local storage or cloud.
    Add a feature for capturing images in different resolutions.
