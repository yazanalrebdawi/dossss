class ApiUrls {
  ApiUrls._();
  static const String _baseURl = 'http://94.72.98.154/abdulrahim/public/api';

  // POSTS
  static final String rigester = '$_baseURl/auth/register-as-provider';
  static final String login = "$_baseURl/auth/login";
  static final String logout = "$_baseURl/auth/logout"; //profile
  static final String profile = "$_baseURl/profile";

  // Home
  static final String statuseWork = "$_baseURl/change-work-status";
  static final String homeData = "$_baseURl/home-page";
  

  //  Products
  static final String products = "$_baseURl/products";

  //  category
  static final String categories = "$_baseURl/categories";

  //  services
  static final String services = "$_baseURl/services";

  //  branches
  static final String branches = "$_baseURl/my-branches";
}
