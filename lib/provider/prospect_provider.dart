import 'package:awas_ace/repositories/prospect_repositories.dart';
import 'package:awas_ace/widgets/model/prospectmodel.dart';
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
