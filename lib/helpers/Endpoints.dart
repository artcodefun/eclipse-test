/// Stores constant paths
class Endpoints{

  /// Storage endpoints
  static const userSavePath ="users";
  static const postSavePath ="posts";
  static const albumSavePath ="albums";
  static const commentSavePath ="comments";
  static const photoSavePath ="photos";

  /// LocalFiles endpoints
  static const imagesFilePath ="images/";
  static const defaultImageFileExt =".png";
  static String getImageFilePath(String savePath, int id)=>imagesFilePath+savePath+"/$id$defaultImageFileExt";

  /// API endpoints
  static const baseUrl = "https://jsonplaceholder.typicode.com/";
  static const userApiPath ="users/";
  static const postApiPath ="posts/";
  static const albumApiPath ="albums/";
  static const commentApiPath ="comments/";
  static const photoApiPath ="photos/";

}