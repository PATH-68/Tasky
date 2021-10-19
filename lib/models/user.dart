class BaseUser {
  final String? uid;

  BaseUser({this.uid});
}

class UserData {
  final String? uid;
  final String? nom;
  final String? prenom;
  final String? tel;

  UserData({this.uid, this.nom, this.prenom, this.tel});
}
