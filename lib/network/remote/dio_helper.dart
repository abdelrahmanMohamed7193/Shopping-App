import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio;
  static init() {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/'  ,
          receiveDataWhenStatusError:true  ,

        )
    ) ;
  }
  static Future<Response> getData({
    required String methodUrl ,
     Map<String,dynamic>? query,
    String lang = "en" ,
    String? token  ,
  }) async {
    dio.options.headers= {
      'Content-Type':'application/json' ,
      "lang":lang,
      "Authorization":token,
    };
    return await dio.get(
      methodUrl ,
      queryParameters: query ,
    ) ;
  }

  static Future<Response> postData({
    required String methodUrl ,
     Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String lang ="en",
    String? token,
  })async{
    dio.options.headers=
       {
         'Content-Type':'application/json' ,
         "lang":lang,
        "Authorization":token?? "" ,
      };
   return await  dio.post(
    methodUrl,
      queryParameters: query ,
      data: data ,
    ) ;


}


  static Future<Response> putData({
    required String methodUrl ,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String lang ="en",
    String? token,
  })async{
    dio.options.headers=
    {
      'Content-Type':'application/json' ,
      "lang":lang,
      "Authorization":token?? "" ,
    };
    return await  dio.put(
      methodUrl,
      queryParameters: query ,
      data: data ,
    ) ;


  }
}