
/// Converts API response to [T] value
typedef ApiConverter<T> = T Function(dynamic);

/// Converts [T] value to a proper API request body
typedef ApiReverseConverter<T> = dynamic Function(T);

/// Manages all API related tasks
abstract class ApiHandler{

  /// Should be called before any other actions
  ///
  /// provide [baseUrl] as base address for API calls
  Future init(String baseUrl);

  /// Performs get Request
  Future<T> get<T>(String apiPath, Map<String, dynamic> query, ApiConverter<T> converter);

  /// Performs post Request
  Future post<T>(String apiPath, T data, ApiReverseConverter<T> converter);

  /// Performs put Request
  Future put<T>(String apiPath, T data, ApiReverseConverter<T> converter);

  /// Performs delete Request
  Future delete(String apiPath);

  /// Downloads file to the localPath
  Future download(String apiPath, String localPath);

}