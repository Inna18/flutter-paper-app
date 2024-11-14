import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenUtils {
  TokenUtils._();

  static bool isValid(token) {
    var decodedToken = JwtDecoder.decode(token);
    var date = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000,
            isUtc: true)
        .toLocal();

    var expireAt = DateFormat.yMMMd().add_jm().format(date);
    print('Expire at: $expireAt');

    if (DateTime.now().isBefore(date)) {
      return true;
    }

    return false;
  }
}
