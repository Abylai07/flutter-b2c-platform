class PaymentStatus {
  static const Map<String, String> _statusDescriptions = {
    'created': 'Платеж создан',
    'refunded': 'Платеж возвращен',
    'canceled': 'Платеж отменен',
    'need_approve': 'Требуется подтверждение платежа',
    'hold': 'Платеж захолдирован',
    'clearing': 'Платеж в процессе клиринга(успешный прием при 2-х стадийной оплате)',
    'withdraw': 'Платеж успешно принят(успешный прием)',
    'refill': 'Платеж успешно выполнен(успешная выплата)',
    'processing': 'Платеж обрабатывается (статус не является финальным)',
    'process': 'Платеж обрабатывается (статус не является финальным)',
    'error': 'Платеж завершен с ошибкой',
    'chargeback': 'Платеж возвращен(возвращен банком эквайером)',
    'partial_refund': 'Частичный возврат платежа',
    'partial_clearing': 'Частичный клиринг платежа',
  };



  static String getStatusDesc(String status) {
    return _statusDescriptions[status] ?? 'Статус неизвестен';
  }
}

String getErrorDescription(String statusCode) {
  switch (statusCode) {
    case 'provider_server_error':
      return 'Ошибка на стороне банка-эквайера';
    case 'provider_common_error':
      return 'Ошибка на стороне сервера банка-эквайера';
    case 'provider_time_out':
      return 'Ошибка на стороне банка-эквайера (Статус не является конечным результатом, нужно опросить методом /status)';
    case 'provider_incorrect_response_format':
      return 'Ошибка на стороне сервера банка-эквайера';
    case 'ov_server_error':
      return 'Ошибка на стороне сервера';
    case 'ov_routes_unavailable':
      return 'Ошибка обработки платежа';
    case 'ov_send_otp_error':
      return 'Некорректный проверочный код. Повторите попытку';
    case 'ov_incorrect_otp':
      return 'Некорректный проверочный код, повторите попытку';
    case 'ov_not_need_approve_status':
      return 'Неверный статус платежа';
    case 'ov_payment_method_incorrect':
      return 'Некорректный метод платежа';
    default:
      return 'Неизвестная ошибка';
  }
}
