import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import '../models/item_model.dart';
import '../models/trailer_model.dart';
import 'package:inject/inject.dart';
import '../models/state.dart';

class MovieApiProvider {
  final Client client;
  final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  @provide
  MovieApiProvider(this.client);

  Future<State> fetchMovieList() async {
    Response response;
    if(_apiKey != 'api-key') {
      response = await client.get("$_baseUrl/popular?api_key=$_apiKey");
    }else{
      return State<String>.error('Please add your API key');
    }
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return State<ItemModel>.success(ItemModel.fromJson(json.decode(response.body)));
    } else {
      // If that call was not successful, throw an error.
      return State<String>.error(response.statusCode.toString());
    }
  }

  Future<State> fetchTrailer(int movieId) async {
    final response =
    await client.get("$_baseUrl/$movieId/videos?api_key=$_apiKey");

    if (response.statusCode == 200) {
      return State<TrailerModel>.success(TrailerModel.fromJson(json.decode(response.body)));
    } else {
      return State<String>.error(response.statusCode.toString());
    }
  }
}
/// api-key = 47ad55bbbaa5a526b5386fd95d0c8545
/// As you can see I am not creating the Client object inside the MovieApiProvider class.
/// @provide is used to help the DI framework to find out where all the dependencies
/// are required and generate code accordingly.
///