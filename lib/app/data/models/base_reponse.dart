class AppBaseResponse {
  int? status;
  String? message;

  AppBaseResponse({
    this.status,
    this.message,
  });

  factory AppBaseResponse.fromJson(Map<String, dynamic> json) => AppBaseResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
