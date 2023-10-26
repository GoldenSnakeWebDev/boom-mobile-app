const String boomIconUrl =
    "https://lh3.googleusercontent.com/pw/AMWts8D1lU-DNAZ4AoaPyHcD8TNiep-EIwPrjfg4NGXLTDdBE3VR3pFoUZmUnfLuzo6lsmsWR-7ireEPwXgwt3G56bDtoVtYVxW7juvw-SN4TolTMHyMT1dEe7JTtuksgJxjxlYOHaZgilElRDWO24P7QL8Xzw=w490-h465-no?authuser=0";

const String likeIconUrl =
    "https://lh3.googleusercontent.com/pw/AL9nZEUpFzAqQNLv4vmn8cJEvI7Vub5ormGjGokHxEgXKE1Lwlx-FJ5lUhDWNvQljTk5_TwzJ5jmEXzsKKlzLS2nW3gbyqsoAcdPf2F9q62xB82U6wd4MLsb6LIA-eqgBZfDDxnjPhr2SXi__uosv5N9GwT1hg=w182-h164-no?authuser=0";
const String loveIconUrl = "";
const String smileIconUrl =
    "https://lh3.googleusercontent.com/pw/AL9nZEX3RKY3NvDuA2SZQ6sjsL5IUEKQ4c67vCy3x7tykXC-9EwZjPBGJJkt4CZjexyrZYVIEu4c9E7Iz4N_fx7e8hC5T0e6hdPb8Jxq7X-hpRZQES-LXgFoOebEJg8Uguj_7LwV42yZu6eayFa5vVgza1-Q6w=w158-h118-no?authuser=0";
const String userIconUrl =
    "https://lh3.googleusercontent.com/pw/AJFCJaVzepRV3-WicUq6PDmKi3_BgRApLxu2dOyI5lhDzWcjO3_cmX8TVpABf_UQBqGqlFfpWikfsuXFT8ynAbGEWEFJDLvPVAjj4mjEEBPGW6xXiSKMrKeXevPivdfK38ZMyo6f7DC2O3yCcLCzzl8Jbe6pUQ=w512-h512-s-no?authuser=0";
const String reboomIconUrl = "";
const String reportIconUrl = "";
const String commentIconUrl = "";

//Smart Contract Mainnet Addresses

const String bnbTokenAddress = "0xAf517ACFD09B6AC830f08D2265B105EDaE5B2fb5";
const String maticTokenAddress = "0x67e78d7fBEB18b16b8ca2e1EC04F1E2d05AF174F";
const String bnbMarketAddress = "0x361e65C8Eb973A7e05606B92432618037FD66678";
const String maticMarketAddress = "0x46F0B35D57dbB7b1e971589350F7cFf5378Fd435";

//Mainnet RPC URLs

const String bnbMainnetRPC = "https://binance.llamarpc.com";
const String maticMainnetRPC = "https://polygon-rpc.com";

//Smart Contract TestNet Addresses
const String bnbTestNetToken = "0xAf517ACFD09B6AC830f08D2265B105EDaE5B2fb5";
const String maticTestNetToken = "0xa4F716c2812652b4d49F7CF3220A211FE89587eE";
const String bnbTestNetMarket = "0x8f7157b9513b33f3364dD9Bdc2639d4214f0d852";
const String maticTestNetMarket = "0xAf517ACFD09B6AC830f08D2265B105EDaE5B2fb5";

//TestNet RPC URLs
const String bnbTestnetRPC =
    "https://bsc-testnet.blockpi.network/v1/rpc/public";
const String maticTestnetRPC = "https://rpc.ankr.com/polygon_mumbai";

List<Map<String, String>> brandDetails = [
  {
    "img":
        "https://bafybeiecd2ncp25fnbrcol3x6eowmfrt7sjwpdn244krddyof5rnri4dwy.ipfs.nftstorage.link/gucci.jpeg",
    "title": "Gucci",
    "likes": "1.2K",
    "reboom": "40",
    "comments": "20",
  },
  {
    "img":
        "https://bafybeiecd2ncp25fnbrcol3x6eowmfrt7sjwpdn244krddyof5rnri4dwy.ipfs.nftstorage.link/versace.jpeg",
    "title": "Versace",
    "likes": "150",
    "reboom": "10",
    "comments": "5",
  },
  {
    "img":
        "https://bafybeiecd2ncp25fnbrcol3x6eowmfrt7sjwpdn244krddyof5rnri4dwy.ipfs.nftstorage.link/offwhite.jpeg",
    "title": "Offwhite",
    "likes": "10.5k",
    "reboom": "36",
    "comments": "15",
  },
  {
    "img":
        "https://bafybeiecd2ncp25fnbrcol3x6eowmfrt7sjwpdn244krddyof5rnri4dwy.ipfs.nftstorage.link/ipfs/bafybeiecd2ncp25fnbrcol3x6eowmfrt7sjwpdn244krddyof5rnri4dwy/jordans.jpeg",
    "title": "Jordans",
    "likes": "1.2K",
    "reboom": "69",
    "comments": "36",
  },
  {
    "img":
        "https://bafybeiecd2ncp25fnbrcol3x6eowmfrt7sjwpdn244krddyof5rnri4dwy.ipfs.nftstorage.link/zara.png",
    "title": "Zara",
    "likes": "1574",
    "reboom": "87",
    "comments": "70",
  },
];

List<Map<String, String>> brandNFTs = [
  {
    "title": "NFT",
    "img":
        "https://s3-alpha-sig.figma.com/img/a0ed/d9fd/9d276f722b9431bca5bab749058cda8b?Expires=1665360000&Signature=IK71Bp3tI4DJJyi7OXS-ryXKIRcAFvXk9QxlbBsYp4YjijuFdrRIe604DH5Mb9NiCeh0iJ44ZjfmV0Q-KMqg~XBfAw80mb6riV4BDavlr5lnhFsLM6ejeOhN60BnDzqquU57fmrY2KdALCb7d4GuH0YWOgJlR8-xZnMjQLwvEEAxnFx4bXiKcB5viYBRYL~TA8qQ8q0NzqjRRKTSp3xZBQySMKaCvTe1kv95dSzw9unSm~BYG02z92~4aImySQMIR9FfQ8zVAMOhLPiaTwMy1uK~D-K-HsXv-kVtld2vZUOWF2fDFELCHVO-GWyHhU3YtldxjIj93eFz6XxFmrF~EA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA"
  },
  {
    "title": "Women",
    "img":
        "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=",
  },
  {
    "title": "Home Collection",
    "img":
        "https://s3-alpha-sig.figma.com/img/ab9b/bbb5/ec758e61c1bdcd401de2d77aebe07fe6?Expires=1665360000&Signature=POtz1ClQpHSIzvPLglk~hkp4-pmnBBsk9XtVs8bYFTaBj9ni-rOznSruYq8vpI40EnQL10riyTCMtuL3JGIXlONXdoGMG4JrIEpYGpXKQ0K05x~Hk35ijzZVM0PWJzkRz3zLF0MfIAUu5VyvF9SpFrHtaeW1359HeFol9IpDWHxYZ1VTsUc5kXiqbMQUx6iOTcw8kE75LWcrfQDxfWouUltAdMW8p525J2Tm3OxALCN7CCUBUVCZFR8NasR2C0j6LIgbtN64PjIxUVuFUg7LcTk8OJcMcSo7aQt7Qw6rso5qpVEOHnkMLAvSeuL5JWJp8ew3KgiRu~--xnnfxPdtnw__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",
  },
  {
    "title": "Men",
    "img":
        "https://s3-alpha-sig.figma.com/img/f040/7d7c/a77397d3b7f425eebd7cad7148ae587b?Expires=1665360000&Signature=NYbRTnIomAjj8AAUfmXDqS7UzPq7wv9TXpj9K9vZrb27yguiY7Lg1~u5JTiU3CTF23b9LV5kdRe0JZ07lJ-AlBGpjzZKXWQWgHkAAByI2QJH05ukAb9Oq8h1uan2ou5S5cwstwGZhGAhwJr5a9jyHPry9JSlfZj4ftLZUCkBAQgCZFYdcgagloOnR82Q7vtDdFsyFRUtF15gLZ1a~yAnoEuLLXtFjBB2cWu~AKyudIHnGGCd~0jOZrQW5O9KhkPGE0fvGn3POeWh3uFo1N46vjIS9ggiCAeaPMievYhxq0xynEaqb0WQ0BQFoPhC63lvpthl0HR7dKPQV1bvN~iTcg__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",
  }
];

List<String> profileOptions = [
  "All",
  "I-Shop",
  "Boom Box",
  "Posts",
  "Social Bridge",
  "Activity",
];

final List<String> kAppRequiredEIP155Methods = [
  // 'eth_sign',
  // 'eth_signTypedData', // Ambiguous suggested to use _v forms
  'personal_sign',
  // 'signTypedData_v4', // Rainbow Android does not support as of 8/25/23
  // 'eth_signTransaction',   // Rainbow Android does not support as of 8/25/23
  'eth_sendTransaction',
  // 'eth_sendRawTransaction',
  // 'wallet_switchEthereumChain',  // Rainbow Android does not support as of 8/25/23
];

final List<String> kAppOptionalEIP155Methods = [
  'signTypedData_v4', // Rainbow Android does not support as of 8/25/23
  'wallet_switchEthereumChain', // Rainbow Android does not support as of 8/25/23
];

//TODO: Remove unrequired events and methods

final List<String> kAppRequiredEIP155Events =
    // Blockchain events that your app required direct visibility into the events
    //
    // NOTE: WalletConnect handles most bookeeping with wc_sessionUpdate and wc_sessionExtend
    // https://docs.walletconnect.com/2.0/specs/clients/sign/rpc-methods#wc_sessionupdate
    // https://docs.walletconnect.com/2.0/specs/clients/sign/rpc-methods#wc_sessionextend
    [
  'accountsChanged', // the accounts available to the Provider change
  'chainChanged', // the chain the Provider is connected to changes
  'connect', // the Provider becomes connected
  'disconnect', // the Provider becomes disconnected from all chains
];
final List<String> kAppOptionalEIP155Events =
// Blockchain events that your app required direct visibility into the events
//
// NOTE: WalletConnect handles most bookeeping with wc_sessionUpdate and wc_sessionExtend
// https://docs.walletconnect.com/2.0/specs/clients/sign/rpc-methods#wc_sessionupdate
// https://docs.walletconnect.com/2.0/specs/clients/sign/rpc-methods#wc_sessionextend
    [
  'accountsChanged', // the accounts available to the Provider change
  'chainChanged', // the chain the Provider is connected to changes
  'connect', // the Provider becomes connected
  'disconnect', // the Provider becomes disconnected from all chains
];
