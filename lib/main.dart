import 'package:flutter/material.dart';
import 'package:challenge_gql_flutter_app/screens/country_list_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final HttpLink httpLink = HttpLink('https://countries.trevorblades.com/');

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'GraphQl Flutter Demo',
        theme: ThemeData(colorScheme: const ColorScheme.dark()),
        home: const CountryList(),
      ),
    );
  }
}
