class AuthException implements Exception {
  static const Map<String, String> errors = {
    "EMAIL_EXISTS": "O e-mail já está registrado.",
    "OPERATION_NOT_ALLOWED": "Operação não permitida.",
    "TOO_MANY_ATTEMPTS_TRY_LATER":
        "Muitas tentativas consecutivas, tente novamente mais tarde.",
    "EMAIL_NOT_FOUND": "O e-mail não foi encontrado.",
    "INVALID_PASSWORD": "Senha inválida.",
    "USER_DISABLED": "Usuário desativado.",
  };

  final String? key;

  const AuthException(this.key);

  @override
  String toString() {
    if (errors.containsKey(key)) {
      return errors[key]!;
    } else {
      return "Ocorreu um erro na autenticação";
    }
  }
}
