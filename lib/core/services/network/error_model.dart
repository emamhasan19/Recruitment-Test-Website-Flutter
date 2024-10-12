class ErrorModel {
  ErrorModel({
    required this.statusCode,
    required this.success,
    required this.message,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
    );
  }
  int statusCode;
  bool success;
  String message;
}

class ErrorMessage {
  ErrorMessage({
    required this.path,
    required this.message,
  });

  factory ErrorMessage.fromJson(Map<String, dynamic> json) => ErrorMessage(
        path: json['path'],
        message: json['message'],
      );
  String path;
  String message;
}
