# Recruitment Test Website - Flutter

This repository contains the source code for a Recruitment Website built using Flutter. The project showcases the integration of JavaScript with Flutter, demonstrating advanced features such as screen recording, video recording, tab change detection, and continuous screenshot capture.

## Key Features

- Responsive Design: The web app adapts seamlessly to different screen sizes, ensuring a smooth experience across devices.
- Screen Recording & Video Recording: The app captures screen and webcam footage during quiz sessions, using JavaScript integrated via WebView.
- Tab Change Detection: The app detects when a user switches tabs and takes appropriate actions, such as pausing the quiz and stopping recordings.
- Continuous Screenshot Capture: Periodically takes screenshots during the quiz to monitor user activity, storing them securely in Firebase.
- Firebase Integration: For real-time data synchronization and storage and file uploads (screenshots, video recordings).

## Tech Stack

- Flutter: Used for building the frontend of the web application.
- JavaScript: Integrated within Flutter to handle screen recording, video recording, and tab change detection.
- Firebase: Provides real-time database, authentication, and file storage for the project.
- Dart: Core programming language used for Flutter development.

## JavaScript Integration

The app uses JavaScript for features such as screen recording and tab detection. JavaScript libraries like RecordRTC, html2canvas, and FileSaver.js are included to manage recordings and screenshots.

You can find the relevant JavaScript integration in the index.html file, where we handle:

- Screen Recording: Using getDisplayMedia to capture screen content.
- Video Recording: Accessing the webcam for video capture.
- Tab Visibility Detection: Listening for tab visibility changes to pause/resume the quiz and recordings.

## Future Enhancements

- Admin panel and user authenctication
- Notification System: Add push notifications for job status updates and application responses.
- AI Job Recommendations: Implement an AI-based recommendation system to suggest relevant jobs to users.
- Enhanced UI/UX: Further improve the user interface and user experience with animations and better transitions.

## How to Contribute

Feel free to submit pull requests or raise issues if you encounter bugs or have suggestions for improvements. Follow these steps to contribute:

1. Fork the repository.
2. Create a new feature branch (git checkout -b feature/your-feature).
3. Commit your changes (git commit -m 'Add some feature').
4. Push to the branch (git push origin feature/your-feature).
5. Create a pull request.

[Vist the Recruitment Test Website here](https://emamhasan19.github.io/)



