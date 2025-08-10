<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Yt-DlpGuiGrabber - Frontend</title>
</head>
<body>
  <h1>🎬 Yt-DlpGuiGrabber (Frontend)</h1>

  <p><strong>Yt-DlpGuiGrabber</strong> is a lightweight, beginner-friendly GUI client for <code>yt-dlp</code>, built with Flutter. It allows users to download videos and audio files from YouTube and many other platforms — no command line knowledge needed!</p>

  <h2>✨ Features</h2>
  <ul>
    <li>✅ Clean and intuitive interface — no setup or coding knowledge required</li>
    <li>📺 Download videos or audio (MP3, MP4, WebM) by simply pasting a URL</li>
    <li>🎧 Audio-only mode (perfect for music and podcasts)</li>
    <li>📁 Choose your output directory and format</li>
    <li>🚀 Built on top of the powerful <code>yt-dlp</code> engine</li>
    <li>🌐 Supports downloading entire playlists and channels</li>
    <li>🔄 Regular updates and seamless yt-dlp integration</li>
  </ul>

  <h2>🧠 Who’s It For?</h2>
  <ul>
    <li>People who find yt-dlp too complex but want similar capabilities</li>
    <li>Casual users, students, or anyone needing a simple media downloader</li>
    <li>Non-technical users who prefer GUI over command-line tools</li>
  </ul>

  <h2>🚫 Music Tagging Notice</h2>
  <p><strong>Note:</strong> The <em>music tagging</em> feature (which would auto-fill title, artist, album art, etc.) is currently not working and most likely won’t function in production builds. This is due to missing Flutter plugin support for low-level audio metadata manipulation on all platforms.</p>

  <h2>🔧 Tech Stack</h2>
  <ul>
    <li>Language: Dart</li>
    <li>GUI Framework: Flutter</li>
    <li>External Tool: <code>yt-dlp</code> (CLI)</li>
  </ul>

  <h2>🚀 Getting Started</h2>
  <ol>
    <li>Clone this repository</li>
    <li>Install Flutter SDK and dependencies</li>
    <li>Run the app using <code>flutter run</code></li>
    <li>Make sure your backend (FastAPI + yt-dlp) is running</li>
  </ol>

  <h2>📦 Backend</h2>
  <p>This frontend expects a FastAPI backend server that handles yt-dlp processing. You can find the backend project in a separate repository.</p>

  <h2>📜 License</h2>
  <p>MIT License</p>
</body>
</html>
