class Environment {

  /// constant defining the test flavor. 
  /// This is the string determining whether the build is a test build used in `--dart-define=FLAVOR=test`
  static const String _TEST_FLAVOR = "test";

  /// the flavour as defined with `--dart-define=FLAVOR=xxx`
  static const _FLAVOR = String.fromEnvironment(
    'FLAVOR',
    defaultValue: _TEST_FLAVOR,
  );

  /// Getter for determining if the client runs on test flavour or not.
  /// if it's not the test flavour the code assumes it's production flavor.
  static bool get isTest => Environment._FLAVOR == Environment._TEST_FLAVOR;

  /// creating a map that uses the default (test) environment and overwrites it
  /// with values from the production environment if we are not running in test flavor.
  static late final Map<String, dynamic> _environmentConfig = Environment._FLAVOR == Environment._TEST_FLAVOR ? _test : {..._test, 
  ..._production};

  /// Hostname for the backend
  static late final String backendHostname = _environmentConfig["BACKEND_HOSTNAME"];

  /// Hostname the static callback page which is used to (re-)open the client
  static late final String callbackHostname = _environmentConfig["CALLBACK_HOSTNAME"];

  /// folder name of the subdirectory used for storing data locally when running in test flavour
  static late final String testSubDir = _environmentConfig["TEST_SUBDIR"];

  /// OIDC client ID for Sign In with Apple
  static late final String oidcClientIdApple = _environmentConfig["OIDC_CLIENT_ID_APPLE"];

  /// OIDC client ID for Sign In with Google on iOS
  static late final String oidcClientIdGoogleForIos = _environmentConfig["OIDC_CLIENT_ID_GOOGLE_FOR_IOS"];

  /// OIDC client ID for Sign In with Google on all platforms except iOS
  static late final String oidcClientIdGoogleForNonIos = _environmentConfig["OIDC_CLIENT_ID_GOOGLE_FOR_NON_IOS"];

  /// Custom Scheme for opening the App on iOS after signing in with Google on iOS
  static late final String oidcGoogleRedirectUrlSchemeIos = _environmentConfig["OIDC_GOOGLE_REDIRECT_URL_SCHEME_IOS"];

  /// The frontend hostname for the web client
  static late final String frontendHostname = _environmentConfig["FRONTEND_HOSTNAME"];

  /// protocol name to register at the operating system which can be used to call the desktop application from a browser
  static late final protocolName = _environmentConfig["PROTOCOL_NAME"];


  /// Default environment being used to create the test environment config.
  static const Map<String, dynamic> _test = {
    "BACKEND_HOSTNAME" : "catfact.ninja/fact",
    "CALLBACK_HOSTNAME" : "forward.environmentdemo.dev",
    "TEST_SUBDIR" : "TEST",
    "OIDC_CLIENT_ID_APPLE" : "com.environmentdemo.dev",
    "OIDC_CLIENT_ID_GOOGLE_FOR_IOS" : "1030967388313-kbp9ugr3l759euctlqkc9pijiqdqkij7.apps.googleusercontent.com",
    "OIDC_CLIENT_ID_GOOGLE_FOR_NON_IOS" : "1030967388313-dkt9ro159acvr4eqn4cufssqc5bd4mcj.apps.googleusercontent.com",
    "OIDC_GOOGLE_REDIRECT_URL_SCHEME_IOS" : "com.skalio.spaces.test:/oauthredirect",
    "FRONTEND_HOSTNAME" : "app.environmentdemo.dev",
    "PROTOCOL_NAME": "environmentdemotest",
  };

  /// configuration items that differ from default (test) environment
  /// being used to create the production environment config.
  static const Map<String, dynamic> _production = {
    "BACKEND_HOSTNAME" : "www.boredapi.com/api/activity",
    "CALLBACK_HOSTNAME" : "forward.environmentdemo.com",
    "TEST_SUBDIR" : "", // no subdir for production flavour
    "OIDC_CLIENT_ID_APPLE" : "com.environmentdemo.app",
    "OIDC_CLIENT_ID_GOOGLE_FOR_IOS" : "28045425415-r7n6spi6vbc4sh1cpqmpsr1nov0egqug.apps.googleusercontent.com",
    "OIDC_CLIENT_ID_GOOGLE_FOR_NON_IOS" : "28045425415-d903vrftd6kt3fftj2bosqclac4ii0c2.apps.googleusercontent.com",
    "OIDC_GOOGLE_REDIRECT_URL_SCHEME_IOS" : "com.skalio.spaces:/oauthredirect",
    "FRONTEND_HOSTNAME" : "app.environmentdemo.com",
    "PROTOCOL_NAME": "environmentdemo",
  };

}