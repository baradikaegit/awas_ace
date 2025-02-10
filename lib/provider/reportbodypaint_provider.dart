import 'package:awas_ace/repositories/reportbodypaint_repositories.dart';
import 'package:awas_ace/widgets/model/reportbpprospekbpuegrmodel.dart';
import 'package:awas_ace/widgets/model/reportbpprospeksabpmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportBodyPaintRepositoryProvider = Provider(
  <IReportBodyPaintRepository>(ref) => ReportBodyPaintRepositories(),
);

//list report prospek sa BP
final reportProspekSaBP = FutureProvider.autoDispose
    .family<ListRptBodyPaintProspekSaBPResponse, String>(
  (ref, linkPageObj) async {
    final repositoryProspekSaBP = ref.watch(reportBodyPaintRepositoryProvider);
    return repositoryProspekSaBP.fecthListDataProspekSaBP(linkPageObj);
  },
);

//list report prospek sa BP
final reportProspekSaBPBySAName = FutureProvider.autoDispose
    .family<ListRptBodyPaintProspekSaBPResponse, String>(
  (ref, linkPageObj) async {
    final repositoryProspekSaBPBySAName =
        ref.watch(reportBodyPaintRepositoryProvider);
    return repositoryProspekSaBPBySAName
        .fecthListDataProspekSaBPBySAName(linkPageObj);
  },
);

//list report prospek bp to ue gr
final reportProspekBPtoUeGR = FutureProvider.autoDispose
    .family<ListRptBodyPaintProspekBPUeGRResponse, String>(
  (ref, linkPageObj) async {
    final repositoryProspekBPtoUeGR =
        ref.watch(reportBodyPaintRepositoryProvider);
    return repositoryProspekBPtoUeGR.fecthListDataProspekBPtoUeGR(linkPageObj);
  },
);

//list report prospek bp to ue gr by sa name
final reportProspekBPtoUeGRBySAName = FutureProvider.autoDispose
    .family<ListRptBodyPaintProspekBPUeGRResponse, String>(
  (ref, linkPageObj) async {
    final repositoryProspekBPtoUeGRBySAName =
        ref.watch(reportBodyPaintRepositoryProvider);
    return repositoryProspekBPtoUeGRBySAName
        .fecthListDataProspekBPtoUeGRBySAName(linkPageObj);
  },
);
