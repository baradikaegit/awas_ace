import 'package:awas_ace/repositories/callin_repositories.dart';
import 'package:awas_ace/widgets/model/callinmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final callInRepositoryProvider =
    Provider(<ICallinRepository>(ref) => CallinRepositories());

final callInList = FutureProvider.autoDispose
    .family<ListReferensiResponse, String>((ref, callDate) async {
  final repository = ref.watch(callInRepositoryProvider);
  return repository.fetchListData(callDate);
});

//add call
class CallFormNotifier extends ChangeNotifier {
  CallFormNotifier(this.ref) : super();

  final ProviderElementBase ref;

  Future<CallResponse> onSubmitCall(ListEntryCallin call) async {
    final repositorycall = ref.read(callInRepositoryProvider);
    late CallResponse resp;

    // try {
    resp = await repositorycall.createNewCall(call);
    // } catch (e) {
    //   print("kesalahan: $e");
    // }
    return resp;
  }
}

final callFormProvider =
    ChangeNotifierProvider.autoDispose<CallFormNotifier>((ref) {
  return CallFormNotifier(ref as ProviderElementBase);
});

class CallFormNotifier2 extends ChangeNotifier {
  CallFormNotifier2(this.ref) : super();

  final ProviderElementBase ref;

  Future<CallResponse> onSubmitCallDetail(
      ListEntryCallinDetail callDetail) async {
    final repositorycall = ref.read(callInRepositoryProvider);
    late CallResponse resp;

    // try {
    resp = await repositorycall.createNewCallDetail(callDetail);
    // } catch (e) {
    //   print("kesalahan: $e");
    // }
    return resp;
  }
}

final callFormProviderDetail =
    ChangeNotifierProvider.autoDispose<CallFormNotifier2>((ref) {
  return CallFormNotifier2(ref as ProviderElementBase);
});

//update call
class UpdateCallFormNotifier extends ChangeNotifier {
  UpdateCallFormNotifier(this.ref) : super();

  final ProviderElementBase ref;

  Future<UpdateCallResponse> onUpdateCallDetail(
      ListUpdateCallin updateCallDetail) async {
    final repositorycall = ref.read(callInRepositoryProvider);
    late UpdateCallResponse resp;

    resp = await repositorycall.updateNewCallDetail(updateCallDetail);
    return resp;
  }
}

final updateCallFormProviderDetail =
    ChangeNotifierProvider.autoDispose<UpdateCallFormNotifier>((ref) {
  return UpdateCallFormNotifier(ref as ProviderElementBase);
});
