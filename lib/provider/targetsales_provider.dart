import 'package:awas_ace/repositories/targetsales_repositories.dart';
import 'package:awas_ace/widgets/model/targetsalesmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final targetSalesRepositoryProvider =
    Provider(<ITargetSalesRepository>(ref) => TargetSalesRepositories());

//list traget saless
final targetSalesList =
    FutureProvider.autoDispose<ListTargetSalesResponse>((ref) async {
  final repository = ref.watch(targetSalesRepositoryProvider);
  return repository.fecthListData();
});

//list traget saless sscode
final targetSSCodeList = FutureProvider.autoDispose
    .family<ListTargetSalesResponse, String>((ref, linkPageObj) async {
  final repositorysscode = ref.watch(targetSalesRepositoryProvider);
  return repositorysscode.fecthListDataSSCode(linkPageObj);
});

//add entry target sales
class TargeSalesFormNotifier extends ChangeNotifier {
  TargeSalesFormNotifier(this.ref) : super();

  final ProviderElementBase ref;

  Future<TargetSalesResponse> onSubmitTargetSales(
      ListEntryTargetSales targetsales) async {
    final repositorytargetsales = ref.read(targetSalesRepositoryProvider);
    late TargetSalesResponse resp;

    try {
      resp = await repositorytargetsales.createNewTargetSales(targetsales);
    } catch (e) {
      print("kesalahan: $e");
    }

    return resp;
  }
}

final targetSalesFormProvider =
    ChangeNotifierProvider.autoDispose<TargeSalesFormNotifier>((ref) {
  return TargeSalesFormNotifier(ref as ProviderElementBase);
});
