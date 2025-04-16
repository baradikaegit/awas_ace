import 'package:awas_ace/repositories/profile_repositories.dart';
import 'package:awas_ace/widgets/model/profilemodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider =
    Provider(<IProfileRepository>(ref) => ProfileRepositories());

//list get profile team
final getProfileTeam =
    FutureProvider.autoDispose<ListProfileResponse>((ref) async {
  final repositoryGetProfileTeam = ref.watch(profileRepositoryProvider);
  return repositoryGetProfileTeam.fecthListDataGetProfileTeam();
});
