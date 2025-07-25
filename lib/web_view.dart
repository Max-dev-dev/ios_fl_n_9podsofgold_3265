import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ios_f_n_9potsofgold_3265/ver_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _showAppNotFoundDialog(BuildContext ctx) => showDialog(
  context: ctx,
  builder: (dCtx) => AlertDialog(
    title: const Text('Application not found'),
    content: const Text('The required application is not installed on your device.'),
    actions: [TextButton(onPressed: () => Navigator.of(dCtx).pop(), child: const Text('OK'))],
  ),
);

Future<void> _tryLaunchOrAlert(String url, BuildContext ctx) async {
  try {
    final success = await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );
    if (!success) {
      await _showAppNotFoundDialog(ctx);
    }
  } catch (e) {
    await _showAppNotFoundDialog(ctx);
  }
}

Future<void> _silentLaunch(String url) async {
  try {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  } catch (_) {
  }
}

final Map<String, String Function(Uri)> _appLinkBuilders = {
  'facebook.com': (u) => 'fb://facewebmodal/f?href=${u.toString()}',
  'instagram.com': (u) => 'instagram://user?username=${u.pathSegments.isNotEmpty ? u.pathSegments.first : ''}',
  'twitter.com': (u) => 'twitter://user?screen_name=${u.pathSegments.isNotEmpty ? u.pathSegments.first : ''}',
  'x.com': (u) => 'twitter://user?screen_name=${u.pathSegments.isNotEmpty ? u.pathSegments.first : ''}',
  'wa.me': (u) => 'whatsapp://send?phone=${u.pathSegments.first}',
  'whatsapp.com': (u) => 'whatsapp://send?phone=${u.pathSegments.first}',
};

Future<void> _openInAppOrBrowser(String url, BuildContext ctx) async {
  final uri = Uri.parse(url);
  for (final entry in _appLinkBuilders.entries) {
    if (uri.host.contains(entry.key)) {
      final appUrl = entry.value(uri);
      if (await canLaunchUrlString(appUrl)) {
        await launchUrlString(appUrl, mode: LaunchMode.externalApplication);
        return;
      }
      break;
    }
  }
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  } else {
    await _showAppNotFoundDialog(ctx);
  }
}

Future<NavigationActionPolicy> handleDeepLink({
  required Uri uri,
  required InAppWebViewController controller,
  required BuildContext ctx,
}) async {
  final urlStr = uri.toString();
  final scheme = uri.scheme.toLowerCase();
  final host = uri.host.toLowerCase();

  const bankSchemes = {
    'rbcmobile',
    'cibcbanking',
    'scotiabank',
    'bmoolbb',
    'conexus',
    'pcfbanking',
    'tdct',
  };

  if (bankSchemes.contains(scheme)) {
    await _tryLaunchOrAlert(uri.toString(), ctx);
    return NavigationActionPolicy.CANCEL;
  }

  if (host == 'mobile.rbcroyalbank.com' && uri.queryParameters['emrf'] != null) {
    final token = uri.queryParameters['emrf']!;
    await _silentLaunch('rbcmobile://emrf_$token');
    return NavigationActionPolicy.ALLOW;
  }

  if (host.contains('cibconline.cibc.com')) {
    final frag   = uri.fragment;
    final params = Uri.splitQueryString(frag);
    if (params['emtId'] != null) {
      await _silentLaunch(
          'cibcbanking://requestetransfer?etransfertoken=${params['emtId']}'
      );
    }
    return NavigationActionPolicy.ALLOW;
  }

  if (host == 'secure.scotiabank.com' &&
      uri.queryParameters['requestRefNumber'] != null) {
    final ref = uri.queryParameters['requestRefNumber']!;
    await _silentLaunch(
        'scotiabank://?requestFlag=true&requestRefNumber=$ref'
    );
    return NavigationActionPolicy.ALLOW;
  }

  if (host == 'm.bmo.com' && uri.queryParameters['receiveFulfillToken'] != null) {
    final token = uri.queryParameters['receiveFulfillToken']!;
    await _silentLaunch('bmoolbb://id=$token&type=FULFILL');
    return NavigationActionPolicy.ALLOW;
  }

  if (host.contains('conexus.ca') &&
      uri.queryParameters['paymentId'] != null &&
      uri.queryParameters['type'] != null) {
    final id   = uri.queryParameters['paymentId']!;
    final type = uri.queryParameters['type']!;
    await _silentLaunch(
        'conexus://etransfers?type=$type&paymentId=$id'
    );
    return NavigationActionPolicy.ALLOW;
  }

  if (host == 'secure.pcfinancial.ca' &&
      uri.queryParameters['interacIssuedIncomingMoneyDemandNumber'] != null) {
    final num = uri.queryParameters['interacIssuedIncomingMoneyDemandNumber']!;
    await _silentLaunch(
        'pcfbanking://?interacIssuedIncomingMoneyDemandNumber=$num'
    );
    return NavigationActionPolicy.ALLOW;
  }

  if (host.contains('feeds.td.com') && uri.queryParameters['RMID'] != null) {
    final rmid = uri.queryParameters['RMID']!;
    await _silentLaunch('tdct://?RMID=$rmid');
    return NavigationActionPolicy.ALLOW;
  }

  if (host.contains('challenges.cloudflare.com')) return NavigationActionPolicy.ALLOW;

  if (urlStr.startsWith('about:') && scheme == 'about') return NavigationActionPolicy.ALLOW;

  if (scheme == 'javascript') return NavigationActionPolicy.CANCEL;

  const cryptoSchemes = [
    'ethereum',
    'bitcoin',
    'litecoin',
    'tron',
    'bsc',
    'dogecoin',
    'bitcoincash',
    'tether',
  ];
  if (cryptoSchemes.contains(scheme)) {
    await Clipboard.setData(ClipboardData(text: urlStr));
    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('Address copied')));
    return NavigationActionPolicy.CANCEL;
  }

  if (_appLinkBuilders.keys.any((k) => host.contains(k))) {
    await _openInAppOrBrowser(urlStr, ctx);
    return NavigationActionPolicy.CANCEL;
  }

  if (scheme == 'http' || scheme == 'https' || scheme == 'file') return NavigationActionPolicy.ALLOW;

  if (await canLaunchUrlString(urlStr)) {
    await launchUrlString(urlStr, mode: LaunchMode.externalApplication);
  } else {
    await _showAppNotFoundDialog(ctx);
  }
  return NavigationActionPolicy.CANCEL;
}

class UrlWebViewApp extends StatefulWidget {
  final String url;
  final String? pushUrl;
  final bool openedByPush;

  const UrlWebViewApp({Key? key, required this.url, this.pushUrl, required this.openedByPush}) : super(key: key);

  @override
  State<UrlWebViewApp> createState() => _UrlWebViewAppState();
}

class _UrlWebViewAppState extends State<UrlWebViewApp> {
  late InAppWebViewController _webViewController;
  late String _webUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);


    if (widget.openedByPush) {
      widget.pushUrl?.isEmpty ?? true ? sendEvent('push_open_webview') : sendEvent('push_open_browser');
      isPush = false;
    }

    _initialize();
    sendEvent('webview_open');

    _webUrl = widget.url;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.pushUrl?.isNotEmpty == true) {
        launchUrlString(widget.pushUrl!, mode: LaunchMode.externalApplication);
      }
    });
  }

  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirst = prefs.getBool('is_first_launch') ?? true;
    if (isFirst) {
      if (prefs.getBool('permission_granted') ?? true) await sendEvent('push_subscribe');
      prefs.setBool('is_first_launch', false);

      await _identifyUserInOneSignal(timestampUserId!);
    }
  }

  Future<void> _identifyUserInOneSignal(String tsId) async {
    try {
      if (tsId != null && tsId.isNotEmpty) {
        await OneSignal.login(tsId);
        print('OneSignal External ID : $tsId');
      }
    } catch (e) {
      print('Error External ID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          top: true,
          bottom: true,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            initialSettings: InAppWebViewSettings(
              transparentBackground: false,
              mediaPlaybackRequiresUserGesture: false,
              allowsInlineMediaPlayback: true,
              allowsBackForwardNavigationGestures: true,
              javaScriptCanOpenWindowsAutomatically: true,
              supportMultipleWindows: true,
              useShouldOverrideUrlLoading: true,
              javaScriptEnabled: true,
              domStorageEnabled: true,
              databaseEnabled: true,
              cacheEnabled: true,
              clearCache: false,
              userAgent:
              "Mozilla/5.0 (iPhone; CPU iPhone OS 17_2_1 like Mac OS X) "
                  "AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2 "
                  "Mobile/15E148 Safari/604.1",
              resourceCustomSchemes: [],
              allowFileAccess: true,
              allowFileAccessFromFileURLs: false,
              allowUniversalAccessFromFileURLs: false,
            ),
            onWebViewCreated: (ctrl) => _webViewController = ctrl,
            onLoadStart: (_, __) => setState(() => _isLoading = true),
            onLoadStop: (_, __) => setState(() => _isLoading = false),
            onLoadError: (_, __, ___, ____) => setState(() => _isLoading = false),
            onPermissionRequest: (controller, request) async {
              final granted = <PermissionResourceType>[];
              if (request.resources.contains(PermissionResourceType.CAMERA)) {
                granted.add(PermissionResourceType.CAMERA);
              }
              if (request.resources.contains(PermissionResourceType.MICROPHONE)) {
                granted.add(PermissionResourceType.MICROPHONE);
              }
              return PermissionResponse(
                resources: granted,
                action: granted.isEmpty
                    ? PermissionResponseAction.DENY
                    : PermissionResponseAction.GRANT,
              );
            },

            shouldOverrideUrlLoading: (controller, nav) async {

              if (nav.request.url?.scheme == 'about' && !nav.isForMainFrame) {
                return NavigationActionPolicy.ALLOW;
              }

              final uri = nav.request.url!;
              final host = uri.host.toLowerCase();
              if ((host.contains('express-connect.com') || host.contains('mobile.rbcroyalbank.com')) &&
                  (uri.scheme == 'http' || uri.scheme == 'https')) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => WebPopupScreen(initialUrl: uri.toString())));
                return NavigationActionPolicy.CANCEL;
              }
              return handleDeepLink(uri: uri, controller: controller, ctx: context);
            },
              onCreateWindow: (controller, req) async {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => WebPopupScreen(
                      initialUrl: req.request.url?.toString() ?? 'about:blank',
                      windowId: req.windowId,
                    ),
                  ),
                );
                return true;
              },
              onConsoleMessage: (controller, consoleMessage) {
              print('Console: ${consoleMessage.message}');
            },
          ),
        ),
        bottomNavigationBar: _NavigationBar(controllerGetter: () => _webViewController),
      ),
    );
  }
}

class WebPopupScreen extends StatefulWidget {
  final String initialUrl;
  final int? windowId;
  const WebPopupScreen({Key? key, required this.initialUrl, this.windowId}) : super(key: key);

  @override
  State<WebPopupScreen> createState() => _WebPopupScreenState();
}

class _WebPopupScreenState extends State<WebPopupScreen> {
  late InAppWebViewController _ctrl;

  static const double _edgeWidth = 20.0;

  @override
  Widget build(BuildContext context) {
    final webview = InAppWebView(
      windowId: widget.windowId,
      initialUrlRequest: widget.windowId == null
          ? URLRequest(url: WebUri(widget.initialUrl))
          : null,
      initialSettings: InAppWebViewSettings(
        allowsBackForwardNavigationGestures: false,
        javaScriptCanOpenWindowsAutomatically: true,
        supportMultipleWindows: true,
        useShouldOverrideUrlLoading: true,
      ),
      onWebViewCreated: (c) => _ctrl = c,
      shouldOverrideUrlLoading: (c, nav) =>
          handleDeepLink(uri: nav.request.url!, controller: c, ctx: context),
      onCloseWindow: (_) => Navigator.of(context).pop(),
    );

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SafeArea(child: webview),

            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: _edgeWidth,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragUpdate: (d) {
                  if (d.primaryDelta != null && d.primaryDelta! > 12) {
                    Navigator.of(context).maybePop();
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: _NavigationBar(
          controllerGetter: () => _ctrl,
          onBackTap: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  final InAppWebViewController Function() controllerGetter;

  final VoidCallback? onBackTap;

  const _NavigationBar({
    Key? key,
    required this.controllerGetter,
    this.onBackTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              if (onBackTap != null) {
                onBackTap!();
              } else {
                final c = controllerGetter();
                if (await c.canGoBack()) {
                  c.goBack();
                } else {
                  Navigator.of(context).maybePop();
                }
              }
            },
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => controllerGetter().reload(),
          ),
        ],
      ),
    );
  }
}

