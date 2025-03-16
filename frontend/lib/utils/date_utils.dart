/// Formats a duration into a human-readable string in the format "Xh Ym"
String formatDuration(Duration duration) {
  return '${duration.inHours}h ${duration.inMinutes % 60}m';
}
