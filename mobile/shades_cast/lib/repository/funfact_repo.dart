import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shades_cast/Infrustructure_layer/api_clients/funfact_api_client.dart';
import 'package:shades_cast/domain_layer/funfact.dart';

import 'database/podcast_database.dart';

abstract class FunfactRepository {
  Future<Funfact> getFunfact();
}

class FunfactRepositoryImpl extends FunfactRepository {
  late final PodcastDatabase _database;
  late final FunfactApiClient _apiClient;
  @override
  Future<Funfact> getFunfact() async {
    final funfact = await _database.getFunfact();

    if (funfact != null) {
      return funfact;
    }
    final remoteFunfact = await _apiClient.getFunfact();
    Funfact newFunfact = Funfact.fromMap(remoteFunfact);
    await _database.saveFunfact(newFunfact);
    return newFunfact;
  }
}
