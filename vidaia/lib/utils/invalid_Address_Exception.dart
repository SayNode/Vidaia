
import 'package:thor_devkit_dart/crypto/address.dart';

class InvalidAddressException implements Exception {
   late String _message;
  
    InvalidAddressException([String message = 'Invalid InvalidAddress']) {
      _message = message;
    }

    	
    @override
    String toString() {
      return _message;
    }

}

 void validateAddress(String address) {
    if (address == null) {
      throw InvalidAddressException();
    } else if (!Address.isAddress(address)) {
      throw InvalidAddressException("Invalid Address!");
    }
  }