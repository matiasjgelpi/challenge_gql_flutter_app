import 'package:flutter/material.dart';
import 'package:challenge_gql_flutter_app/screens/country_detail_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountryList extends StatelessWidget {
  const CountryList({Key? key}) : super(key: key);

  final String getCountries = r"""
    query getCountries{
         countries {
              code
              name
              emoji
              capital    
         }  
    }
   """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List of Countries'), centerTitle: true),
      body: Query(
          options: QueryOptions(document: gql(getCountries)),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.hasException) {
              return Text(result.hasException.toString());
            }
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            List countries = result.data?["countries"];

            return ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];

                  return Card(
                    child: ListTile(
                      title: Text(country["name"]),
                      hoverColor: Colors.indigo,
                      subtitle:
                          Text('Capital: ${country["capital"] ?? 'unknown'}'),
                      leading: Text(country["emoji"]),
                      trailing: const Icon(Icons.arrow_forward_rounded),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CountryDetail(country["code"]))),
                    ),
                  );
                });
          }),
    );
  }
}
