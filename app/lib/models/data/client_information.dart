class ClientInformation {
  static String? clientId;
  static String? clientName;
  static String? clientSurname;
  static String? clientEmail;
  static String? clientPostalCode;
  static String? clientPhone;
  static String? clientImage;
  static String? clientToken;
  static String? forgotCode;
  static bool? clientIsProvider = false;
  static bool isLoggedIn = false;

  // Set the client logged status
  static setLoggedIn(bool status) {
    isLoggedIn = status;
  }

  // Get client initials
  static String getClientInitials() {
    if (clientName != null && clientSurname != null) {
      return clientName![0] + clientSurname![0];
    }
    return '';
  }
}
