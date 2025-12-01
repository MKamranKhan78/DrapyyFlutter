
import 'dart:convert';

import 'package:http/http.dart' as http;


class NetworkManager {
    static const String BASE_URL ="https://app.drapyy.com/api/v1/";









    //---------------------ERROR API----------------------------
    static const String addressUpdate ="customer/address/update"; // giving 500 internal sever error
    //------------DONE fully on add fb token and flow setting after logout---------------------
    //---------------------DONE API---------------------------------


    static const String register ="register";
    static const String login ="login";
    static const String home_cat_products ="home-category-products";
    static const String home ="home";
    static const String getMenu ="get-menu";
    static const String config_data ="config-data";
    static const String cart ="cart";
    static const String top_seller ="top-selling-products";
    static const String getTrending ="get-trending";
    static const String getTopRated ="get-top-rated";
    static const String cartUpdate ="cart/update";
    static const String cartRemove ="cart/remove";
    static const String addCart ="cart/add";
    static const String product_details ="product-detail";
    static const String productColor ="product-colors";
    static const String syncWishlist ="sync-wishlist";
    static const String wishlist ="customer/wishlist";
    static const String updateImage ="customer/profile-picture-update";
    static const String termsAndCondition ="page/terms_and_condition";
    static const String privacy_policy ="page/privacy-policy";
    static const String placeOrder ="checkout/place-order";
    static const String applyCoupon ="checkout/apply-coupon";
    static const String voucher ="customer/vouchers";
    static const String checkout ="checkout";
    static const String address ="customer/address";
    static const String addAddress ="customer/address/add";
    static const String deleteAddress ="customer/address/delete";
    static const String forgot_pass ="forgot-password";
    static const String profile ="customer/profile";
    static const String update_profile ="customer/profile-update";
    static const String update_password ="customer/password-update";
    static const String orders ="customer/orders";
    static const String becomeSeller ="become-seller";
    static const String become_seller_data ="become-seller-data";
    static const String notifications ="customer/notifications";
    static const String avail_Points ="customer/avail-points";
    static const String avail_points_list ="customer/avail-points-list";
    static const String my_follow ="customer/my-follows";
    static const String all_brands ="brands";
    static const String my_follows_sync ="customer/my-follows/sync";
    static const String sync_my_follows ="customer/my-follows/sync";
    static const String search ="search";
    static const String productByBroand ="products-by-brand";
    static const String logout ="log-out";
    static const String guest_api ="guest-user";






    //---------------------DONE---------------------------------
    /////// CONSTANTS ///////
   static const String API_TOKEN ="apikey";
   static const String FIREBASE_TOKEN ="firebase_token";
   //static const String PREF_SKIP ="skiiip";
   static const String PREF_NAME ="name";
   static const String PREF_EMAIL ="email";
   static const String PREF_PROFILE ="profile";
   static const String PREF_ADDRESS ="address";
   static const String PREF_PHONE ="phone";
   static const String PREF_POSTAL ="postal";
   static const String PREF_CUSTOMER_ID ="c_id";
   static const String PREF_CLIENT_PHONE_NUM ="c_phone_number";
   static const String PREF_CLIENT_EMAIL ="c_email_client";
   static const String PREF_STATE_ID ="state_id";
   static const String PREF_CUSTOMER_POINTS ="pts";
   static const String PREF_LAT ="lat";
   static const String PREF_LNG ="lng";
   static const String PREF_BUILDING ="building";
   static const String PREF_FlOOR ="floor";



   static const String PREF_IS_GUEST ="PREF_IS_GUEST";
   static const String PREF_MOBILE ="PREF_MOBILE";
   static const String PREF_IS_INTRO_SCREEN_DONE ="PREF_INTRO_SCREEN";
   static const String PREF_FULL_NAME ="PREF_FULL_NAME";
   static const String PREF_USER_ID ="PREF_USER_ID";
   static const String PREF_CITY_NAME ="PREF_CITY_NAME";
   static const String PREF_DOB_NAME ="PREF_DOB_NAME";
   static const String PREF_ADRESS ="PREF_ADRESS";
   static const String PREF_CART_COUNT ="PREF_CART_COUNT";
   static const String PREF_WISH_COUNT ="PREF_WISH_COUNT";
   static const String PREF_POSTAL_CODE ="PREF_POSTAL_CODE";

   static const String PREF_YOUTUBE ="PREF_YOUTUBE";
   static const String PREF_FACEBOOK ="PREF_FACEBOOK";
   static const String PREF_INSTAGRAM ="PREF_INSTAGRAM";
   static const String PREF_PINTREST ="PREF_PINTREST";




}