# Testing Steps

## Start the Flutter Web Server
flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0

## Visit the web page from a mobile device
The web page will be available at http://<computer's IP address>:8080/#/

You can find your computer's IP address following these steps:

### Mac
1. Open Settings
2. Navigate to WiFi
3. Next to your current connect, click "Details"
4. The IP address will be listed at the bottom of the details screen


## Make Updates to your index.html File
Each time you make a change to the Flutter project's index.html file, you will need to stop the web server and rebuild your web project.

`flutter build web`

When this completes, you can re-run the web server and refresh the page on your mobile device