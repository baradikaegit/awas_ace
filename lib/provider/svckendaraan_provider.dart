import 'package:awas_ace/repositories/svckendaraan_repositories.dart';
import 'package:awas_ace/widgets/model/svckendaraanmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final svcKendaraanRepositoryProvider =
    Provider(<ISvcKendaraanRepository>(ref) => SvckendaraanRepositories());

//list stnk
final svckendaraanpelanggan =
    FutureProvider.autoDispose<ListSvcKendaraanResponse>((ref) async {
  final repositorySvcKendaraanPelanggan =
      ref.watch(svcKendaraanRepositoryProvider);
  return repositorySvcKendaraanPelanggan.fecthListDataSvcKendaraanPelanggan();
});
