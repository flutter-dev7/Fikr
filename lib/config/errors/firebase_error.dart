class FirebaseError {
  String mapFirebaseError(String code) {
    switch (code) {
      case "invalid-email":
        return "Неверный email";

      case "user-not-found":
        return "Пользователь не найден";

      case "wrong-password":
        return "Неверный пароль";

      case "invalid-credential":
        return "Неверный email или пароль";

      case "email-already-in-use":
        return "Этот email уже используется";

      case "weak-password":
        return "Слишком слабый пароль";

      case "user-disabled":
        return "Аккаунт отключен";

      case "network-request-failed":
        return "Нет подключения к интернету";

      case "timeout":
        return "Время ожидания истекло";

      case "too-many-requests":
        return "Слишком много попыток. Попробуйте позже";

      case "operation-not-allowed":
        return "Операция не разрешена";

      case "missing-email":
        return "Введите email";

      case "account-exists-with-different-credential":
        return "Аккаунт уже существует с другим способом входа";

      case "credential-already-in-use":
        return "Данные уже используются другим аккаунтом";

      case "invalid-verification-code":
        return "Неверный код подтверждения";

      case "invalid-verification-id":
        return "Ошибка подтверждения";

      case "session-expired":
        return "Сессия истекла. Попробуйте снова";

      case "internal-error":
        return "Внутренняя ошибка сервера";

      case "channel-error":
        return "Ошибка соединения. Попробуйте позже";

      default:
        return "Что-то пошло не так";
    }
  }
}
