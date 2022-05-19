/// TODO: put these variables in --dart-define arguments
/// having the variables here is a security risk
/// remove after testing of the whole auth flow works
const AUTH0_DOMAIN =
    "dev-jp7b9rk6.us.auth0.com"; // String.fromEnvironment('AUTH0_DOMAIN');
const AUTH0_CLIENT_ID =
    "G3EpKLVRSmOK17DbFEkubCnTGzgooiut"; // String.fromEnvironment('AUTH0_CLIENT_ID');
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
const BUNDLE_IDENTIFIER = 'ch.saynode.vidaia';
const AUTH0_REDIRECT_URI = '$BUNDLE_IDENTIFIER://login-callback';
