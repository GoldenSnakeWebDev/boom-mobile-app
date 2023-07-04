const String clientID = "519882056280297";
const String appSecret = "b49efe8f4d6c3e497de7d799c9138e23";
const String redirectUri = "https://www.boooooooooom.com/";
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
const String nftStorageApiKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweGFjNThmRWVGMDU4M2EzODZhQWE1MjU0NTVGMjAwZUI1ZTQxNkY1NDciLCJpc3MiOiJuZnQtc3RvcmFnZSIsImlhdCI6MTY2NzM4Mzg3MjY0OCwibmFtZSI6ImJvb20ifQ.7K86oXzENWpUn3hq6G7k9UvKRzqXup4QQ3JJDTLKUpE";

const String polygonTestApiKey = "369IPUUUS5ZZBYQMAZ5G3V1ZK7MHJTVF25";

const String oneSignalAppId = "d0910db3-e8ff-4418-9365-1a0a494d9615";

const String WALLET_CONNECT_ID = "748a4dd9654a1f5291e7ff9714f63ac7";
