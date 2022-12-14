import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/typedefs/user_id.dart';
part 'user_info_model.freezed.dart';
part 'user_info_model.g.dart';
// class UserInfoModel extends MapView<String, String> {
//   UserInfoModel({
//     required UserId userId,
//     required String displayName,
//     required String? email,
//   }) : super({
//           FirestoreFieldName.userId: userId,
//           FirestoreFieldName.displayName: displayName,
//           FirestoreFieldName.email: email ?? '',
//         });
//   UserInfoModel.fromJson(Map<String, dynamic> json, {required UserId userId})
//       : this(
//           userId: userId,
//           displayName: json[FirestoreFieldName.displayName] ?? '',
//           email: json[FirestoreFieldName.email],
//         );
// }

@freezed
abstract class UserInfoModel with _$UserInfoModel {
  const factory UserInfoModel({
    @JsonKey(name: FirestoreFieldName.userId) required UserId userId,
    @JsonKey(name: FirestoreFieldName.displayName) required String displayName,
    @JsonKey(name: FirestoreFieldName.email) required String? email,
  }) = _UserInfoModel;
  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);
}
