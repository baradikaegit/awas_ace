import 'package:awas_ace/repositories/svckendaraan_repositories.dart';
import 'package:awas_ace/widgets/model/svccountmodel.dart';
import 'package:awas_ace/widgets/model/svckendaraandetailmodel.dart';
import 'package:awas_ace/widgets/model/svckendaraanmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final svcKendaraanRepositoryProvider =
    Provider(<ISvcKendaraanRepository>(ref) => SvckendaraanRepositories());

//list svc kendaraan
final svckendaraanpelanggan =
    FutureProvider.autoDispose<ListSvcKendaraanResponse>((ref) async {
  final repositorySvcKendaraanPelanggan =
      ref.watch(svcKendaraanRepositoryProvider);
  return repositorySvcKendaraanPelanggan.fecthListDataSvcKendaraanPelanggan();
});

//list body repair GR
final bodyRepairGR =
    FutureProvider.autoDispose<ListSvcKendaraanResponse>((ref) async {
  final repositoryBodyRepairGR = ref.watch(svcKendaraanRepositoryProvider);
  return repositoryBodyRepairGR.fecthListDataBodyRepairGR();
});

//list body repair Sales
final bodyRepairSls =
    FutureProvider.autoDispose<ListSvcKendaraanResponse>((ref) async {
  final repositoryBodyRepairSls = ref.watch(svcKendaraanRepositoryProvider);
  return repositoryBodyRepairSls.fecthListDataBodyRepairSls();
});

//list svc kendaraan detail
final svcKendaraanDetail = FutureProvider.autoDispose
    .family<ListSvcKendaraanDetailResponse, String>((ref, linkObj) async {
  final repositorySvcKendaraanDetail =
      ref.watch(svcKendaraanRepositoryProvider);
  return repositorySvcKendaraanDetail.fecthListDataSvcKendaraanDetail(linkObj);
});

//update svc kendaraan
class UpdateReminderFormNotifier extends ChangeNotifier {
  UpdateReminderFormNotifier(this.ref) : super();

  final ProviderElementBase ref;

  Future<UpdateSvcKendaraanResponse> onUpdateSvcKendaraan(
      ListSvcKendaraanUpdate updateSvcKendaraan) async {
    final repositorysvckendaraan = ref.read(svcKendaraanRepositoryProvider);
    late UpdateSvcKendaraanResponse resp;

    resp =
        await repositorysvckendaraan.updateNewSvcKendaraan(updateSvcKendaraan);
    return resp;
  }
}

final updateSvcKendaraanFormProviderDetail =
    ChangeNotifierProvider.autoDispose<UpdateReminderFormNotifier>((ref) {
  return UpdateReminderFormNotifier(ref as ProviderElementBase);
});

//list svc count
final svcCount = FutureProvider.autoDispose<ListSVCCountResponse>((ref) async {
  final repositorySvcCount = ref.watch(svcKendaraanRepositoryProvider);
  return repositorySvcCount.fecthListDataCount();
});
