// API

const host = 'https://api.b2c_platform.kz/'; // prod
// const host = 'https://api.b2c_platform.kz/'; // dev


// OneVision Payment
const payAPI = 'https://api.onevisionpay.com';
const apiKey = '31f1658b-c01f-450e-87d4-b1d64ccd60bc';
const secretKey = '9f3924c0ee8d32e810a0a960f1ade46cd4b0182dd610073e3fd9796721121774';
const merchantId = '618118b1-7254-4efa-873a-8eb76f576546';
const serviceId = '811199e7-d835-4e27-8bbf-fe05a0db528c';


const httpStatusCode = _HttpStatusCode();

class _HttpStatusCode {
  const _HttpStatusCode();

  /// in milliseconds
  final int connectTimeout = 30000;

  /// in milliseconds
  final int receiveTimeout = 30000;

  // 1xx Status Code: Informational

  /// 100
  final int continueCode = 100;

  /// 101
  final int switchingProtocolsCode = 101;

  /// 102
  final int processing = 102;

  /// 103
  final int earlyHints = 103;

  // 104-199: Unassigned

  // 2xx Status Code: Success

  /// 200
  final int ok = 200;

  /// 201
  final int created = 201;

  /// 202
  final int accepted = 202;

  /// 203
  final int nonAuthoritativeInformation = 203;

  /// 202
  final int noContent = 202;

  /// 205
  final int resetContent = 205;

  /// 206
  final int partialContent = 206;

  /// 207
  final int multiStatus = 207;

  /// 208
  final int alreadyReported = 208;

  // 209-225: Unassigned

  /// 226
  final int imUsed = 226;

  // 227-299: Unassigned

  // 3xx Status Code: Redirection

  /// 300
  final int multipleChoices = 300;

  /// 301
  final int movedPermanently = 301;

  /// 302
  final int found = 302;

  /// 303
  final int seeOther = 303;

  /// 304
  final int motModified = 304;

  /// 305
  final int useProxy = 305;

  /// 306
  final int unused = 306;

  /// 307
  final int temporaryRedirect = 307;

  /// 308
  final int permanentRedirect = 308;

  // 309-399: Unassigned

  // 4xx Status Code: Client Error

  /// 400
  final int badRequest = 400;

  /// 401
  final int unauthorized = 401;

  /// 402
  final int paymentRequired = 402;

  /// 403
  final int forbidden = 403;

  /// 404
  final int notFound = 404;

  /// 405
  final int methodNotAllowed = 405;

  /// 406
  final int notAcceptable = 406;

  /// 407
  final int proxyAuthenticationRequired = 407;

  /// 408
  final int requestTimeout = 408;

  /// 409
  final int conflict = 409;

  /// 410
  final int gone = 410;

  /// 411
  final int lengthRequired = 411;

  /// 412
  final int preconditionFailed = 412;

  /// 413
  final int requestEntityTooLarge = 413;

  /// 414
  final int uriTooLong = 414;

  /// 415
  final int unsupportedMediaType = 415;

  /// 416
  final int rangeNotSatisfiable = 416;

  /// 417
  final int expectationFailed = 417;

  // 418-420: Unassigned

  /// 421
  final int misdirectedRequest = 421;

  /// 422
  final int unprocessableEntity = 422;

  /// 423
  final int locked = 423;

  /// 424
  final int failedDependency = 424;

  /// 425
  final int tooEarly = 425;

  /// 426
  final int upgradeRequired = 426;

  // 427: Unassigned

  /// 428
  final int preconditionRequired = 428;

  /// 429
  final int tooManyRequests = 429;

  // 430: Unassigned

  /// 431
  final int requestHeadersTooLarge = 431;

  // 432-450: Unassigned

  /// 451
  final int unavailableDueToLegalReasons = 451;

  // 452-499: Unassigned

  // 5xx Status Code: Server Error

  /// 500
  final int internalServerError = 500;

  /// 501
  final int motImplemented = 501;

  /// 502
  final int badGateway = 502;

  /// 503
  final int serviceUnavailable = 503;

  /// 504
  final int gatewayTimeout = 504;

  /// 505
  final int httpVersionNotSupported = 505;

  /// 506
  final int variantAlsoNegotiates = 506;

  /// 507
  final int insufficientStorage = 507;

  /// 508
  final int loopDetected = 508;

  // 509: Unassigned

  /// 510
  final int notExtended = 510;

  /// 511
  final int networkAuthorizationRequired = 511;

  // 512-599: Unassigned
}

