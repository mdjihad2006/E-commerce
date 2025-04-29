class VerifyOtpModal{
  final String email;
  final String otp;

  VerifyOtpModal({required this.email, required this.otp});
  Map<String,dynamic> toJson(){
    return{
      'email':email,
      'otp':otp
    };
  }
}