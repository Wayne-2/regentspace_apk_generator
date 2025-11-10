import 'package:flutter_riverpod/legacy.dart';
import 'package:vtutemplate/model/userdata.dart';

class UserProfileNotifier extends StateNotifier<UserProfile?> {
  UserProfileNotifier() : super(null);

  void setUser(UserProfile user) => state = user;

  void clearUser() => state = null;
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile?>((ref) {
  return UserProfileNotifier();
});
