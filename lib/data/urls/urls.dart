class Urls {
  static const String _baseUrl = "https://ecom-rs8e.onrender.com/api";

  static const String addToCartUrl = "$_baseUrl/cart";
  static const String addToWishList = "$_baseUrl/wishlist";
  static const String cartListUrl = "$_baseUrl/cart";
  static String deleteFromCartListUrl(String id) => "$_baseUrl/cart/$id";
  static String deleteFromWishListUrl(String id) => "$_baseUrl/wishlist/$id";
  static String deleteReview(String id) => "$_baseUrl/reviews/$id";

  static const String getCategoryUrl = "$_baseUrl/categories";
  static const String getProductUrl = "$_baseUrl/products";
  static const String getPopularProductUrl = "$_baseUrl/products";
  static const String getSpecialProductUrl = "$_baseUrl/products";
  static const String getNewProductUrl = "$_baseUrl/products";
  //static String getProductById(String id) => "$_baseUrl/products/id/$id";
  //static String getPopularProduct = "$_baseUrl/products";

  static String getProductDetialsUrl(String productId) => "$_baseUrl/products/id/$productId";
  static const String getReviewList = "$_baseUrl/reviews";
  static const String getWishListUrl = "$_baseUrl/wishlist";

  static const String registrationUrl = "$_baseUrl/auth/signup";
  static const String signIn = "$_baseUrl/auth/login";
  static const String sliderUrl = "$_baseUrl/slides";
  static const String verifyOtp = "$_baseUrl/auth/verify-otp";

  static const String createReview = "$_baseUrl/reviews";
}
