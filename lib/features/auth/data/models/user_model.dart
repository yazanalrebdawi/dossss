class UserModel {
  final int? id;
  final String email;
  final String fullName;
  final String nickName;
  final String dateOfBirth;
  final String phone;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.nickName,
    required this.dateOfBirth,
    required this.phone,
    required this.profileImage,
  });

  UserModel copyWith({
    int? id,
    String? email,
    String? fullName,
    String? nickName,
    String? dateOfBirth,
    String? phone,
    String? gender,
    String? profileImage,
  }) =>
      UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        nickName: nickName ?? this.nickName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        phone: phone ?? this.phone,

        profileImage: profileImage ?? this.profileImage,
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'full_name': fullName,
      'nick_name': nickName,
      'date_of_birth': dateOfBirth,
      'phone': phone,
      'profile_picture': profileImage
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ,
      email: map['email'] as String,
      fullName: map['full_name'] as String,
      nickName: map['nick_name'] as String,
      dateOfBirth: map['date_of_birth'],
      phone: map['phone'] as String,
      profileImage: map['profile_picture'],
    );
  }
}
