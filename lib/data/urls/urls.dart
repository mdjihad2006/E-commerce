class Urls{
  static const String _baseUrl ="https://ecom-rs8e.onrender.com/api";
  static const String registrationUrl ="$_baseUrl/auth/signup";
  static const String verifyOtp ="$_baseUrl/auth/verify-otp";
  static const String signIn ="$_baseUrl/auth/login";
  static const String wishlist ="$_baseUrl/wishlist";
  static const String sliderUrl ="$_baseUrl/slides";
  static const String getCategoryUrl ="$_baseUrl/categories";
  static const String getProductUrl ="$_baseUrl/products";
 static String getProductByIdUrl(String id) => "$_baseUrl/products/id/$id";

  static const String getWishListUrl ="$_baseUrl/wishlist";
  static const String addToWishList ="$_baseUrl/wishlist";
  static String getProductDetialsUrl(String productId) =>"$_baseUrl/products/id/$productId";
  static const String addToCartUrl ="$_baseUrl/cart";
  static String deleteFromCartListUrl(String id) => '$_baseUrl/cart/$id';
  static const String cartListUrl = '$_baseUrl/cart';



}