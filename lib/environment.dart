class Environment {

  /// constant defining the test environment. 
  /// This is the string determining whether the build is a test build used in `--dart-define=ENVIRONMENT=test`
  static const String _TEST_ENVIRONMENT = "test";

  /// the environment as defined with `--dart-define=ENVIRONMENT=xxx`
  static const _ENVIRONMENT = String.fromEnvironment(
    'environment',
    defaultValue: _TEST_ENVIRONMENT,
  );

  /// Getter for determining if the client runs on test environment or not.
  /// if it's not the test environment the code assumes it's production enviironment.
  static bool get isTest => Environment._ENVIRONMENT == Environment._TEST_ENVIRONMENT;

  /// creating a map that uses the default (test) environment and overwrites it
  /// with values from the production environment if we are not running in test environment.
  static late final Map<String, dynamic> _environmentConfig = Environment._ENVIRONMENT == Environment._TEST_ENVIRONMENT ? _test : {..._test, 
  ..._production};

  /// Hostname for the backend
  static late final String backendHostname = _environmentConfig["BACKEND_HOSTNAME"];

  /// Hostname the static callback page which is used to (re-)open the client
  static late final String callbackHostname = _environmentConfig["CALLBACK_HOSTNAME"];

  /// folder name of the subdirectory used for storing data locally when running in test environment
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
    "TEST_SUBDIR" : "", // no subdir for production environment
    "OIDC_CLIENT_ID_APPLE" : "com.environmentdemo.app",
    "OIDC_CLIENT_ID_GOOGLE_FOR_IOS" : "28045425415-r7n6spi6vbc4sh1cpqmpsr1nov0egqug.apps.googleusercontent.com",
    "OIDC_CLIENT_ID_GOOGLE_FOR_NON_IOS" : "28045425415-d903vrftd6kt3fftj2bosqclac4ii0c2.apps.googleusercontent.com",
    "OIDC_GOOGLE_REDIRECT_URL_SCHEME_IOS" : "com.skalio.spaces:/oauthredirect",
    "FRONTEND_HOSTNAME" : "app.environmentdemo.com",
    "PROTOCOL_NAME": "environmentdemo",
  };

}