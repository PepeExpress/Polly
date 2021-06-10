class ModelUser {
  ModelUser(
      {this.uid = '',
      required this.username,
      required this.imgIndex,
      this.points});
  String uid;
  String username;
  int imgIndex;
  int? points;
}
