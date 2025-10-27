// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(count) => "Принятые (${count})";

  static String m1(count) => "Все (${count})";

  static String m2(count) => "Завершенные (${count})";

  static String m3(name) => "Привет, ${name}!";

  static String m4(count) => "В процессе (${count})";

  static String m5(count) => "Новые (${count})";

  static String m6(num) => "Заказ №${num}";

  static String m7(price, period) => "от ${price} тг/${period}";

  static String m8(price, period) => "${price} ₸/${period}";

  static String m9(count) => "Выбрано: ${count}";

  static String m10(sec) => "Отправить повторно через ${sec} сек";

  static String m11(address) =>
      "Вы уверены, что хотите сохранить адрес: ${address}";

  static String m12(ver) => "Версия ${ver}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accept": MessageLookupByLibrary.simpleMessage("Принят"),
    "accepted": m0,
    "acceptedStatus": MessageLookupByLibrary.simpleMessage("Принятые"),
    "active": MessageLookupByLibrary.simpleMessage("Активные"),
    "addAddress": MessageLookupByLibrary.simpleMessage("Добавить адресс"),
    "addItem": MessageLookupByLibrary.simpleMessage("Добавление объявления"),
    "addItemRule": MessageLookupByLibrary.simpleMessage(
      "Правила размещения объявлений",
    ),
    "addPeriod": MessageLookupByLibrary.simpleMessage(
      "Добавить период и стоимость аренды",
    ),
    "addPhoto": MessageLookupByLibrary.simpleMessage("Добавить фото"),
    "addPhotoDesc": MessageLookupByLibrary.simpleMessage(
      "Выбирайте фотографии в хорошем качестве и сделанные при хорошем освещении, это поможет лучше рассмотреть товар",
    ),
    "addPhotoItem": MessageLookupByLibrary.simpleMessage(
      "Добавьте фотографии товара",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Адрес"),
    "addressHint": MessageLookupByLibrary.simpleMessage(
      "Улица, дом, номер кВа",
    ),
    "addressItem": MessageLookupByLibrary.simpleMessage(
      "Выберите адрес товара",
    ),
    "advertisement": MessageLookupByLibrary.simpleMessage("История объявлений"),
    "all": MessageLookupByLibrary.simpleMessage("Все"),
    "allCount": m1,
    "appSettings": MessageLookupByLibrary.simpleMessage("Настройки приложения"),
    "archive": MessageLookupByLibrary.simpleMessage("В архив"),
    "authorized": MessageLookupByLibrary.simpleMessage(
      "Этот номер уже зарегистрирован",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Назад"),
    "bik": MessageLookupByLibrary.simpleMessage("БИК"),
    "bin": MessageLookupByLibrary.simpleMessage("БИН/ИИН"),
    "birthday": MessageLookupByLibrary.simpleMessage("Дата рождения"),
    "book": MessageLookupByLibrary.simpleMessage("Забронировать"),
    "bookSuccess": MessageLookupByLibrary.simpleMessage(
      "Ваш запрос отправлен в арендатору. Ожидайте ответа ближайшее время. Статус аренды вы можете видеть в профиле История заказов",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("отмена"),
    "categories": MessageLookupByLibrary.simpleMessage("Категории"),
    "changeInfo": MessageLookupByLibrary.simpleMessage("Изменить данные"),
    "changeItem": MessageLookupByLibrary.simpleMessage("Изменить объявление"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Изменить пароль"),
    "changePhoto": MessageLookupByLibrary.simpleMessage(
      "Перетаскивайте фото, чтоб изменить порядок",
    ),
    "changePhotoItem": MessageLookupByLibrary.simpleMessage(
      "Измените фотографии товара",
    ),
    "chooseCity": MessageLookupByLibrary.simpleMessage("Выберите свой город"),
    "close": MessageLookupByLibrary.simpleMessage("Завершен"),
    "closed": m2,
    "closedStatus": MessageLookupByLibrary.simpleMessage("Завершенные"),
    "companyName": MessageLookupByLibrary.simpleMessage("Название компании"),
    "conditionItem": MessageLookupByLibrary.simpleMessage("Состояние товара"),
    "cost": MessageLookupByLibrary.simpleMessage("Цена"),
    "costAutomatic": MessageLookupByLibrary.simpleMessage(
      "Цена будет автоматически высчитываться сразу после получения товара",
    ),
    "day": MessageLookupByLibrary.simpleMessage("На день"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Удалить аккаунт"),
    "deleteAccountDesc": MessageLookupByLibrary.simpleMessage(
      "Вы уверены что хотите удалить аккаунт!",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Описание"),
    "descriptionItem": MessageLookupByLibrary.simpleMessage("Описание товара"),
    "edit": MessageLookupByLibrary.simpleMessage("изменить"),
    "email": MessageLookupByLibrary.simpleMessage("Электронная почта"),
    "empty": MessageLookupByLibrary.simpleMessage("Пусто"),
    "fillAll": MessageLookupByLibrary.simpleMessage("Заполните все поля"),
    "fillCost": MessageLookupByLibrary.simpleMessage(
      "Укажите стоимость периода",
    ),
    "filter": MessageLookupByLibrary.simpleMessage("Фильтры"),
    "forgotPass": MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
    "given": MessageLookupByLibrary.simpleMessage("Заказ выдан: "),
    "gmail": MessageLookupByLibrary.simpleMessage("example@mail.com"),
    "good": MessageLookupByLibrary.simpleMessage("Хорошее"),
    "haveAccount": MessageLookupByLibrary.simpleMessage("Уже есть аккаунт?"),
    "helloUser": m3,
    "howObtain": MessageLookupByLibrary.simpleMessage("Как получить товар"),
    "howReturn": MessageLookupByLibrary.simpleMessage("Как вернуть товар"),
    "iban": MessageLookupByLibrary.simpleMessage("IBAN счет"),
    "ideal": MessageLookupByLibrary.simpleMessage("Идеальное"),
    "inProgress": m4,
    "inProgressStatus": MessageLookupByLibrary.simpleMessage("В процессе"),
    "inactive": MessageLookupByLibrary.simpleMessage("В архиве"),
    "incorrect_email": MessageLookupByLibrary.simpleMessage(
      "Некорректная почта",
    ),
    "ipPerson": MessageLookupByLibrary.simpleMessage("Юридическое лицо(ИП)"),
    "item": MessageLookupByLibrary.simpleMessage("Товар: "),
    "itemName": MessageLookupByLibrary.simpleMessage("Название товара"),
    "itemNameHint": MessageLookupByLibrary.simpleMessage(
      "Например, самокат jtx",
    ),
    "landlordInfo": MessageLookupByLibrary.simpleMessage("Данные арендодателя"),
    "login": MessageLookupByLibrary.simpleMessage("Войти"),
    "logoutDesc": MessageLookupByLibrary.simpleMessage(
      "Вы уверены что хотите выйти!",
    ),
    "main": MessageLookupByLibrary.simpleMessage("Главная"),
    "mainPhoto": MessageLookupByLibrary.simpleMessage("Главное фото"),
    "mustFill": MessageLookupByLibrary.simpleMessage(
      "Поле обязательно для заполнения",
    ),
    "myCategory": MessageLookupByLibrary.simpleMessage("Подходящая категория"),
    "myOrders": MessageLookupByLibrary.simpleMessage("Мои заказы"),
    "name": MessageLookupByLibrary.simpleMessage("Имя"),
    "needPassword": MessageLookupByLibrary.simpleMessage(
      "Отлично!\nОсталось придумать надежный пароль",
    ),
    "newCount": m5,
    "newNew": MessageLookupByLibrary.simpleMessage("Новый"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Новый пароль"),
    "newPhoto": MessageLookupByLibrary.simpleMessage("Изменить фотографию"),
    "newStatus": MessageLookupByLibrary.simpleMessage("Новое"),
    "next": MessageLookupByLibrary.simpleMessage("Продолжить"),
    "noAccount": MessageLookupByLibrary.simpleMessage("Нет аккаунта?"),
    "normal": MessageLookupByLibrary.simpleMessage("Удовлетворительное"),
    "notFoundAccount": MessageLookupByLibrary.simpleMessage(
      "Активная учетная запись с такими данными не найдена",
    ),
    "notFountCategory": MessageLookupByLibrary.simpleMessage(
      "Если вы не нашли категорию для вашего товара, Вы можете оставить заявку в Службе поддержки и мы рассмотрим ваше предложение для добавление новой категории",
    ),
    "notRightCode": MessageLookupByLibrary.simpleMessage("Не правильный код!"),
    "obtainAndReturn": MessageLookupByLibrary.simpleMessage(
      "Выдача и возврат товара",
    ),
    "orderAt": MessageLookupByLibrary.simpleMessage("От арендаторов"),
    "orderHistory": MessageLookupByLibrary.simpleMessage("История заказов"),
    "orderInfo": MessageLookupByLibrary.simpleMessage("Информация о заказе"),
    "orderNum": m6,
    "orders": MessageLookupByLibrary.simpleMessage("История заказов"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "passwordAgain": MessageLookupByLibrary.simpleMessage("Повторите пароль"),
    "passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "Пароли не совпадают",
    ),
    "pay": MessageLookupByLibrary.simpleMessage("Оплатить"),
    "period": MessageLookupByLibrary.simpleMessage("Период аренды"),
    "personalData": MessageLookupByLibrary.simpleMessage("Личные данные"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Номер телефона"),
    "price": m7,
    "priceTg": m8,
    "rateApp": MessageLookupByLibrary.simpleMessage("Оценить приложение"),
    "recommendations": MessageLookupByLibrary.simpleMessage("Рекомендации"),
    "recover": MessageLookupByLibrary.simpleMessage("Восстановить"),
    "registerLandlord": MessageLookupByLibrary.simpleMessage(
      "Вы должны зарегистрироваться в качестве арендодателя",
    ),
    "removeSelect": MessageLookupByLibrary.simpleMessage("Удалить выбранное"),
    "rent": MessageLookupByLibrary.simpleMessage("Арендовать"),
    "rentCost": MessageLookupByLibrary.simpleMessage("Стоимость аренды"),
    "rentInfo": MessageLookupByLibrary.simpleMessage("Данные арендодателя"),
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "searchCategory": MessageLookupByLibrary.simpleMessage(
      "Поиск по категориям",
    ),
    "select": MessageLookupByLibrary.simpleMessage("Выбрать"),
    "selectCategory": MessageLookupByLibrary.simpleMessage(
      "Выберите подходящую категорию",
    ),
    "selectPhoto": MessageLookupByLibrary.simpleMessage("Выбрать из галереи"),
    "selected": m9,
    "sentAgain": MessageLookupByLibrary.simpleMessage("Отправить повторно"),
    "sentAgainSec": m10,
    "sentOtp": MessageLookupByLibrary.simpleMessage(
      "Арендодателю отправлен смс код. Введите код для подтверждения запроса",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("Вход"),
    "signInRental": MessageLookupByLibrary.simpleMessage(
      "Чтобы продолжить, вам необходимо зарегистрироваться как арендадатель",
    ),
    "signInSuccess": MessageLookupByLibrary.simpleMessage(
      "Вы вошли в аккаунт!",
    ),
    "signInText": MessageLookupByLibrary.simpleMessage(
      "Чтобы продолжить, вам необходимо войти в аккаунт или зарегистрироваться",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("Выйти из аккаунта"),
    "simplePerson": MessageLookupByLibrary.simpleMessage("Физическое лицо"),
    "singUp": MessageLookupByLibrary.simpleMessage("Регистрация"),
    "singUpSuccess": MessageLookupByLibrary.simpleMessage(
      "Регистрация прошла успешно!",
    ),
    "somethingWrong": MessageLookupByLibrary.simpleMessage(
      "Что-то пошло не так",
    ),
    "subCategories": MessageLookupByLibrary.simpleMessage("Подкатегории"),
    "success": MessageLookupByLibrary.simpleMessage("Успешно!"),
    "support": MessageLookupByLibrary.simpleMessage("Служба поддержки"),
    "sureAddress": m11,
    "surname": MessageLookupByLibrary.simpleMessage("Фамилия"),
    "takePhoto": MessageLookupByLibrary.simpleMessage("Сделать фото"),
    "termsUse": MessageLookupByLibrary.simpleMessage("Условия использования"),
    "tooPerson": MessageLookupByLibrary.simpleMessage("Юридическое лицо(ТОО)"),
    "totalAmount": MessageLookupByLibrary.simpleMessage("Общая сумма"),
    "version": m12,
    "viewed": MessageLookupByLibrary.simpleMessage("Просмотрено: "),
    "week": MessageLookupByLibrary.simpleMessage("На неделя"),
    "welcome": MessageLookupByLibrary.simpleMessage("Добро пожаловать"),
    "willSentCode": MessageLookupByLibrary.simpleMessage(
      "На ваш номер телефона будет отправлен код подтверждения",
    ),
    "writeCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Введите текущий пароль",
    ),
    "writeNewPassword": MessageLookupByLibrary.simpleMessage(
      "Введите новый пароль",
    ),
    "wrongCurrentPass": MessageLookupByLibrary.simpleMessage(
      "Текущий пароль неверен",
    ),
    "yes": MessageLookupByLibrary.simpleMessage("Да"),
    "yoko": MessageLookupByLibrary.simpleMessage("created by YOKO"),
  };
}
