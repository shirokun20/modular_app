import 'dart:convert';

extension StringExt on String {
  String toRupiah({String separator='.', String trailing=''}) {
    return "Rp ${replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}$separator')}$trailing";
  }
  bool parseBool() {
    return toLowerCase() == 'true';
  }

  String getInitials(String fullName) => fullName.isNotEmpty
      ? fullName
      .trim()
      .split(RegExp(' +'))
      .map((s) => s[0])
      .take(2)
      .join()
      : '';


  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  // untuk hasil dari scan QR (Ambil id nya)
  String getSubmissionId() {
    String url = this;
    List<String> parts = url.split('/');
    if (parts.length > 2) {
      return parts[1];
    } else {
      return url;
    }
  }

  String toEncodeBase64() {
    String encodedText = base64Encode(utf8.encode(this));
    return encodedText;
  }

  String toDecodeBase64() {
    List<int> decodedBytes = base64Decode(this);
    String decodedText = utf8.decode(decodedBytes);
    return decodedText;
  }
}

extension StringNullable on String? {
  String toStringDefault() {
    return this ?? "-";
  }
}