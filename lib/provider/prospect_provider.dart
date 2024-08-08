import 'package:awas_ace/repositories/prospect_repositories.dart';
import 'package:awas_ace/widgets/model/prospectmodel.dart';
import 'package:awas_ace/widgets/model/prospectuebp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final prospectRepositoryProvider =
    Provider(<IProspectRepository>(ref) => ProspectRepositories());

//add prospect
class ProspectFormNotifier extends ChangeNotifier {
  ProspectFormNotifier(this.ref) : super();
  // final ProviderRefBase ref;

  final ProviderElementBase ref;

  Future<ProspectResponse> onSubmitProspect(ListProspectData prospect) async {
    final repository = ref.read(prospectRepositoryProvider);
    late ProspectResponse resp;

    // if (prospect.branchBusinessID == prospect.branchBusinessID) {
    //create new user

    try {
      resp = await repository.createNewProspect(prospect);
    } catch (e) {
      print("kesalahan: $e");
    }
    // } else {
    //   //update existing user with userId;
    // }
    return resp;
  }
}

final prospectFormProvider =
    ChangeNotifierProvider.autoDispose<ProspectFormNotifier>((ref) {
  return ProspectFormNotifier(ref as ProviderElementBase);
});

//add prospect uebp
class ProspectUEBPFormNotifier extends ChangeNotifier {
  ProspectUEBPFormNotifier(this.ref) : super();

  final ProviderElementBase ref;

  Future<ProspectUEBPResponse> onSubmitProspectUEBP(
      ListEntryProspectUEBP uebp) async {
    final repositoryuebp = ref.read(prospectRepositoryProvider);
    late ProspectUEBPResponse resp;

    try {
      resp = await repositoryuebp.createNewProspectUEBP(uebp);
    } catch (e) {
      print("kesalahan: $e");
    }

    return resp;
  }
}

final prospectUEBPFormProvider =
    ChangeNotifierProvider.autoDispose<ProspectUEBPFormNotifier>((ref) {
  return ProspectUEBPFormNotifier(ref as ProviderElementBase);
});

//list prospect uebp
final prospectUEBPList = FutureProvider.autoDispose
    .family<ListProspectUEBP, String>((ref, objID) async {
  final repository = ref.watch(prospectRepositoryProvider);
  return repository.fecthListDataUEBP(objID);
});
