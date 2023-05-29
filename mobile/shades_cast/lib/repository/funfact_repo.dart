import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shades_cast/Infrustructure_layer/api_clients/funfact_api_client.dart';
import 'package:shades_cast/domain_layer/funfact.dart';

import 'database/podcast_database.dart';

abstract class FunfactRepository {
  Future<Funfact> getFunfact();
}

class FunfactRepositoryImpl extends FunfactRepository {
  final PodcastDatabase _database;
  final FunfactApiClient _apiClient;
  FunfactRepositoryImpl(this._database, this._apiClient);
  @override
  Future<Funfact> getFunfact() async {
    print('in funfact repo');
    // final funfact = await _database.getFunfact();

    // if (funfact != null) {
    //   return funfact;
    // }
    final remoteFunfacts = await _apiClient.getFunfact();
    print('funfact gotten');
    print(remoteFunfacts);
    Funfact newFunfact = Funfact(title: 'title', body: 'body');
    if (remoteFunfacts.length > 0) {
      final fact = remoteFunfacts[0];
      print(fact);
      newFunfact = Funfact.fromMap(fact);
    }
    // await _database.saveFunfact(newFunfact);
    print('funfact processed');
    return newFunfact;
  }
}
