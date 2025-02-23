/// Defines the base path for all image assets in the application.
/// This approach helps maintain a structured and scalable asset management system.
const String IMAGE_PATH = "assets/images";

/// A utility class that provides constants for accessing image assets.
/// This avoids hardcoding image paths throughout the app and makes updates easier.
class ImageAssets {
  static const String dribbleImage = "$IMAGE_PATH/dribble.png"; // Dribbble logo
  static const String figmaImage = "$IMAGE_PATH/figma.png"; // Figma logo
  static const String playStationImage = "$IMAGE_PATH/playstation.png"; // PlayStation logo
  static const String spotifyImage = "$IMAGE_PATH/spotify.png"; // Spotify logo
  static const String youtubeImage = "$IMAGE_PATH/youtube.png"; // YouTube logo
  static const String hboImage = "$IMAGE_PATH/hbo.png"; // HBO Max logo
}
