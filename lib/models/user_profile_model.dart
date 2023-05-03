class UserProfileModel {
  final String id;
  final String? avatarUrl;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? jobTitle;
  final String? userStatus;
  final String? website;

  UserProfileModel({
    required this.id,
    required this.avatarUrl,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.jobTitle,
    required this.userStatus,
    required this.website,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json['id'] as String? ?? '',
        avatarUrl: json['avatar_url'] as String?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        username: json['username'] as String?,
        jobTitle: json['job_title'] as String?,
        userStatus: json['user_status'] as String?,
        website: json['website'] as String?,
      );
}
