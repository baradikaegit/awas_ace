import 'package:awas_ace/repositories/prospect_repositories.dart';
import 'package:awas_ace/widgets/model/grafikprospectsalesmodel.dart';
import 'package:awas_ace/widgets/model/prospectbengkeldetailmodel.dart';
import 'package:awas_ace/widgets/model/prospectbengkelmodel.dart';
import 'package:awas_ace/widgets/model/prospectmodel.dart';
import 'package:awas_ace/widgets/model/prospectuebpmodel.dart';
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

//list grafik prospect sales
final grafikProspectSales =
    FutureProvider.autoDispose<ListGrafikProspectSalesResponse>((ref) async {
  final repositoryGrafikPS = ref.watch(prospectRepositoryProvider);
  return repositoryGrafikPS.fecthListDataGrafikProspectSales();
});

//list prospect dari bengkel
final prospectDariBengkel =
    FutureProvider.autoDispose<ListProspectDariBengkelResponse>((ref) async {
  final repositoryProspectBengkel = ref.watch(prospectRepositoryProvider);
  return repositoryProspectBengkel.fecthListDataProspectBengkel();
});

//list prospect dari bengkel detail
final prospectDariBengkelDetail = FutureProvider.autoDispose
    .family<ListProspectDariBengkelDetailResponse, String>(
        (ref, linkObj) async {
  final repositoryProspectBengkelDetail = ref.watch(prospectRepositoryProvider);
  return repositoryProspectBengkelDetail
      .fecthListDataProspectBengkelDetail(linkObj);
});

//update prospect dari bengkel
class UpdateProspectBengkelFormNotifier extends ChangeNotifier {
  UpdateProspectBengkelFormNotifier(this.ref) : super();

  final ProviderElementBase ref;

  Future<UpdateProspectDariBengkelResponse> onUpdateProspectDariBengkel(
      ListProspectbengkelUpdate updateProspectDariBengkel) async {
    final repositoryprospectbengkel = ref.read(prospectRepositoryProvider);
    late UpdateProspectDariBengkelResponse resp;

    resp = await repositoryprospectbengkel
        .updateNewProspectBengkel(updateProspectDariBengkel);
    return resp;
  }
}

final updateProspectDariBengkelFormProviderDetail =
    ChangeNotifierProvider.autoDispose<UpdateProspectBengkelFormNotifier>(
        (ref) {
  return UpdateProspectBengkelFormNotifier(ref as ProviderElementBase);
});
