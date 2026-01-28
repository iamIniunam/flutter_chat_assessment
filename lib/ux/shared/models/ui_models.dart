enum AvatarType { add, image }

class StoryItem {
  final String label;
  final String? avatarUrl;

  StoryItem({
    required this.label,
    this.avatarUrl,
  });
}
