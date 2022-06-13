import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountryDetail extends StatelessWidget {
  final String country;
  CountryDetail(this.country);

  final String getCountry = r"""
    query getCountry($code:ID!) {
        country(code:$code){
        name
        currency
        capital
        native
        phone
        emoji
        languages {
        name
        }
        continent {
        name
        }
    } 
 }
   """;

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(getCountry), variables: {
          'code': country,
        }),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.hasException.toString());
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          var country = result.data?["country"];


          return Scaffold(
            appBar:
                AppBar(title: Text('${country["name"]}'), centerTitle: true),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${country["emoji"]}',
                      style: const TextStyle(fontSize: 125)),
                  Text(
                      '\nContinent: ${country["continent"]["name"]}'
                      '\nCapital: ${country["capital"]}'
                      '\nFirst Language: ${country["languages"][0]["name"]}'
                      '\nNative name: ${country["native"]}'
                      '\nCurrency: ${country["currency"]}'
                      '\nPhone prefix: ${country["phone"]}',

                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500)),


                ],
              ),
            ),
          );

        });
  }
}
