/// TODO: put these variables in --dart-define arguments
/// having the variables here is a security risk
/// remove after testing of the whole auth flow works
const AUTH0_DOMAIN = "dev-jp7b9rk6.us.auth0.com"; // String.fromEnvironment('AUTH0_DOMAIN');
const AUTH0_CLIENT_ID = "G3EpKLVRSmOK17DbFEkubCnTGzgooiut"; // String.fromEnvironment('AUTH0_CLIENT_ID');
const AUTH0_CLIENT_ID_METADATA = "HjuGFyrQbhsSfRby4dBR0GqTTGF9ysh7"; // String.fromEnvironment('AUTH0_CLIENT_ID');
const AUTH0_CLIENT_SECRET_METADATA = "l1ofwHdiClPe5YK7ICKc6B97YPFCkCR7q68iLrPdk713rT8dTw4_-HXDbQEg-_72"; // String.fromEnvironment('AUTH0_CLIENT_ID');
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
const BUNDLE_IDENTIFIER = 'ch.saynode.vidaia';
const AUTH0_REDIRECT_URI = '$BUNDLE_IDENTIFIER://login-callback';
const REFRESH_TOKEN_KEY = 'refresh_token';
