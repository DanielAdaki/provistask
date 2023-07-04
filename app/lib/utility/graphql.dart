import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provitask_app/common/conexion_common.dart';

ValueNotifier<GraphQLClient> clientFor({
  String? subscriptionUri,
}) {
  final HttpLink httpLink = HttpLink(ConexionCommon.hostG);
  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer ${ConexionCommon.token}',
  );
  Link link = authLink.concat(httpLink);

  if (subscriptionUri != null) {
    final WebSocketLink websocketLink = WebSocketLink(
      subscriptionUri,
    );

    link = Link.split((request) => request.isSubscription, websocketLink, link);
  }

  return ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: link,
    ),
  );
}

GraphQLClient clientG() {
  final HttpLink httpLink = HttpLink(ConexionCommon.hostG);
  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer ${ConexionCommon.token}',
  );
  Link link = authLink.concat(httpLink);
  return GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: link,
  );
}
