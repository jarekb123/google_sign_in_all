library google_sign_in_all;

export 'src/interface.dart'
    if (dart.library.io) 'src/mobile.dart'
    if (dart.library.js) 'src/web.dart';
