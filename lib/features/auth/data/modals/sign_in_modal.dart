class SignInModal{
  final String email;
  final String password;

  SignInModal({required this.email, required this.password});
  Map<String,dynamic> toJson(){
    return{
      'email':email,
      'password':password
    };
  }
}