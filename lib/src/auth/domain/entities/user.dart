import 'dart:convert';

import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.points,
    this.groupId = const [],
    this.enrolledCourseIds = const [],
    this.following = const [],
    this.followers = const [],
    this.profilePic,
    this.bio,
  });

  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          fullName: '',
          points: 0,
          groupId: const [],
          enrolledCourseIds: const [],
          following: const [],
          followers: const [],
          bio: '',
          profilePic: '',
        );

  factory LocalUser.fromMap(Map<String, dynamic> map) {
    return LocalUser(
      uid: map['uid'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      profilePic: map['profilePic'] as String?,
      bio: map['bio'] as String?,
      points: map['points'] as int,
      groupId: List<String>.from(map['groupId'] as List),
      enrolledCourseIds: List<String>.from(map['enrolledCourseIds'] as List),
      following: List<String>.from(map['following'] as List),
      followers: List<String>.from(map['followers'] as List),
    );
  }

  factory LocalUser.fromJson(String source) =>
      LocalUser.fromMap(json.decode(source) as Map<String, dynamic>);

  final String uid;
  final String email;
  final String fullName;
  final String? profilePic;
  final String? bio;
  final int points;
  final List<String> groupId;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> followers;

  LocalUser copyWith({
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
    return LocalUser(
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

  Map<String, dynamic> toMap() {
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

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'LocalUser(uid: $uid, email: $email, fullName: $fullName, '
        'bio: $bio, points: $points)';
  }

  @override
  List<Object> get props {
    return [uid, email];
  }
}
