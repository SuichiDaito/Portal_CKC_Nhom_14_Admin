 // Future<List<dynamic>> getApi() async {
  //   // comments: Response<List<Comment>>
  //   final List<dynamic> list;
  //   final response = await CallApi.postServices.getComments();
  //   if (response.statusCode == 200) {
  //     final jsonData = response.body;
  //     list = jsonData.map((comment) => Comment.fromJson(comment)).toList();
  //     return list;
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  // }