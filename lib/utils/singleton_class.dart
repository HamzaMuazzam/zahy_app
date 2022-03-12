class MyUser {
  static final MyUser _users = MyUser._internal();
  factory MyUser() {
    return _users;
  }

  MyUser._internal();
}
