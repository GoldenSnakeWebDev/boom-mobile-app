const String clientID = "";
const String appSecret = "";
const String redirectUri = "https://rennylangat.github.io/";
const String scope = 'user_profile,user_media';
const String responseType = 'code';
const String url =
    'https://api.instagram.com/oauth/authorize?client_id=$clientID&redirect_uri=$redirectUri&scope=$scope&response_type=$responseType';

/// Presets your required fields on each call api.
/// Please refers to https://developers.facebook.com/docs/instagram-basic-display-api/reference .
List<String> userFields = ['id', 'username'];
List<String> mediaListFields = ['id', 'caption'];
List<String> mediaFields = [
  'id',
  'media_type',
  'media_url',
  'username',
  'timestamp'
];

//NFT Storage API Keys
const String nftStorageApiKey = "";
