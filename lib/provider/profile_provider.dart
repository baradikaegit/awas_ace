import 'package:awas_ace/repositories/profile_repositories.dart';
import 'package:awas_ace/widgets/model/profilemodel.dart';
import 'package:awas_ace/widgets/model/profileteammodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider =
    Provider(<IProfileRepository>(ref) => ProfileRepositories());

//list get profile
final getProfile = FutureProvider.autoDispose<ListProfileResponse>((ref) async {
  final repositoryGetProfile = ref.watch(profileRepositoryProvider);
  return repositoryGetProfile.fecthListDataGetProfile();
});

//list get profile team
final getProfileTeam =
    FutureProvider.autoDispose<ListProfileTeamResponse>((ref) async {
  final repositoryGetProfileTeam = ref.watch(profileRepositoryProvider);
  return repositoryGetProfileTeam.fecthListDataGetProfileTeam();
});

//update profile
class UpdateProfileFormNotifier extends ChangeNotifier {
  UpdateProfileFormNotifier(this.ref) : super();

  final ProviderElementBase ref;

  Future<UpdateProfileResponse> onUpdateProfile(ListUpdateProfile up) async {
    final repositoryupdateprofile = ref.read(profileRepositoryProvider);
    late UpdateProfileResponse resp;

    resp = await repositoryupdateprofile.updateProfile(up);
    return resp;
  }
}

final updateProfileFormProvider =
    ChangeNotifierProvider.autoDispose<UpdateProfileFormNotifier>((ref) {
  return UpdateProfileFormNotifier(ref as ProviderElementBase);
});
