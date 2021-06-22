class Message {
  String status;
  String message;

  Message(this.status, this.message);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(json['status'], json['message']);
  }
}
