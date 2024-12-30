import 'package:education_app/core/core.dart';
import 'package:education_app/src/auth/domain/domain.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    required super.points,
    super.groupId,
    super.enrolledCourseIds,
    super.following,
    super.followers,
    super.profilePic,
    super.bio,
  });

  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          fullName: '',
          points: 0,
          profilePic: '',
          bio: '',
        );

  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          fullName: map['fullName'] as String,
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
          points: map['points'] as int,
          groupId: List<String>.from(map['groupId'] as List),
          enrolledCourseIds:
              List<String>.from(map['enrolledCourseIds'] as List),
          following: List<String>.from(map['following'] as List),
          followers: List<String>.from(map['followers'] as List),
        );

  @override
  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'profilePic': profilePic,
      'bio': bio,
      'points': points,
      'groupId': groupId,
      'enrolledCourseIds': enrolledCourseIds,
      'following': following,
      'followers': followers,
    };
  }

  @override
  LocalUserModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? profilePic,
    String? bio,
    int? points,
    List<String>? groupId,
    List<String>? enrolledCourseIds,
    List<String>? following,
    List<String>? followers,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      points: points ?? this.points,
      groupId: groupId ?? this.groupId,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }
}
