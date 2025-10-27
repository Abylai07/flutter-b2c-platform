// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `example@mail.com`
  String get gmail {
    return Intl.message('example@mail.com', name: 'gmail', desc: '', args: []);
  }

  /// `Добро пожаловать`
  String get welcome {
    return Intl.message(
      'Добро пожаловать',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get login {
    return Intl.message('Войти', name: 'login', desc: '', args: []);
  }

  /// `created by YOKO`
  String get yoko {
    return Intl.message('created by YOKO', name: 'yoko', desc: '', args: []);
  }

  /// `Некорректная почта`
  String get incorrect_email {
    return Intl.message(
      'Некорректная почта',
      name: 'incorrect_email',
      desc: '',
      args: [],
    );
  }

  /// `Главная`
  String get main {
    return Intl.message('Главная', name: 'main', desc: '', args: []);
  }

  /// `Рекомендации`
  String get recommendations {
    return Intl.message(
      'Рекомендации',
      name: 'recommendations',
      desc: '',
      args: [],
    );
  }

  /// `Добавление объявления`
  String get addItem {
    return Intl.message(
      'Добавление объявления',
      name: 'addItem',
      desc: '',
      args: [],
    );
  }

  /// `Категории`
  String get categories {
    return Intl.message('Категории', name: 'categories', desc: '', args: []);
  }

  /// `Подкатегории`
  String get subCategories {
    return Intl.message(
      'Подкатегории',
      name: 'subCategories',
      desc: '',
      args: [],
    );
  }

  /// `Привет, {name}!`
  String helloUser(Object name) {
    return Intl.message(
      'Привет, $name!',
      name: 'helloUser',
      desc: '',
      args: [name],
    );
  }

  /// `Имя`
  String get name {
    return Intl.message('Имя', name: 'name', desc: '', args: []);
  }

  /// `Фамилия`
  String get surname {
    return Intl.message('Фамилия', name: 'surname', desc: '', args: []);
  }

  /// `Дата рождения`
  String get birthday {
    return Intl.message('Дата рождения', name: 'birthday', desc: '', args: []);
  }

  /// `Вход`
  String get signIn {
    return Intl.message('Вход', name: 'signIn', desc: '', args: []);
  }

  /// `Чтобы продолжить, вам необходимо войти в аккаунт или зарегистрироваться`
  String get signInText {
    return Intl.message(
      'Чтобы продолжить, вам необходимо войти в аккаунт или зарегистрироваться',
      name: 'signInText',
      desc: '',
      args: [],
    );
  }

  /// `Чтобы продолжить, вам необходимо зарегистрироваться как арендадатель`
  String get signInRental {
    return Intl.message(
      'Чтобы продолжить, вам необходимо зарегистрироваться как арендадатель',
      name: 'signInRental',
      desc: '',
      args: [],
    );
  }

  /// `Номер телефона`
  String get phoneNumber {
    return Intl.message(
      'Номер телефона',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Пароль`
  String get password {
    return Intl.message('Пароль', name: 'password', desc: '', args: []);
  }

  /// `Забыли пароль?`
  String get forgotPass {
    return Intl.message(
      'Забыли пароль?',
      name: 'forgotPass',
      desc: '',
      args: [],
    );
  }

  /// `Продолжить`
  String get next {
    return Intl.message('Продолжить', name: 'next', desc: '', args: []);
  }

  /// `Регистрация`
  String get singUp {
    return Intl.message('Регистрация', name: 'singUp', desc: '', args: []);
  }

  /// `Вы вошли в аккаунт!`
  String get signInSuccess {
    return Intl.message(
      'Вы вошли в аккаунт!',
      name: 'signInSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Регистрация прошла успешно!`
  String get singUpSuccess {
    return Intl.message(
      'Регистрация прошла успешно!',
      name: 'singUpSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Уже есть аккаунт?`
  String get haveAccount {
    return Intl.message(
      'Уже есть аккаунт?',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `На ваш номер телефона будет отправлен код подтверждения`
  String get willSentCode {
    return Intl.message(
      'На ваш номер телефона будет отправлен код подтверждения',
      name: 'willSentCode',
      desc: '',
      args: [],
    );
  }

  /// `Отправить повторно`
  String get sentAgain {
    return Intl.message(
      'Отправить повторно',
      name: 'sentAgain',
      desc: '',
      args: [],
    );
  }

  /// `Отправить повторно через {sec} сек`
  String sentAgainSec(Object sec) {
    return Intl.message(
      'Отправить повторно через $sec сек',
      name: 'sentAgainSec',
      desc: '',
      args: [sec],
    );
  }

  /// `Отлично!\nОсталось придумать надежный пароль`
  String get needPassword {
    return Intl.message(
      'Отлично!\nОсталось придумать надежный пароль',
      name: 'needPassword',
      desc: '',
      args: [],
    );
  }

  /// `Физическое лицо`
  String get simplePerson {
    return Intl.message(
      'Физическое лицо',
      name: 'simplePerson',
      desc: '',
      args: [],
    );
  }

  /// `Юридическое лицо(ТОО)`
  String get tooPerson {
    return Intl.message(
      'Юридическое лицо(ТОО)',
      name: 'tooPerson',
      desc: '',
      args: [],
    );
  }

  /// `Юридическое лицо(ИП)`
  String get ipPerson {
    return Intl.message(
      'Юридическое лицо(ИП)',
      name: 'ipPerson',
      desc: '',
      args: [],
    );
  }

  /// `Название компании`
  String get companyName {
    return Intl.message(
      'Название компании',
      name: 'companyName',
      desc: '',
      args: [],
    );
  }

  /// `БИН/ИИН`
  String get bin {
    return Intl.message('БИН/ИИН', name: 'bin', desc: '', args: []);
  }

  /// `БИК`
  String get bik {
    return Intl.message('БИК', name: 'bik', desc: '', args: []);
  }

  /// `IBAN счет`
  String get iban {
    return Intl.message('IBAN счет', name: 'iban', desc: '', args: []);
  }

  /// `Электронная почта`
  String get email {
    return Intl.message('Электронная почта', name: 'email', desc: '', args: []);
  }

  /// `Нет аккаунта?`
  String get noAccount {
    return Intl.message('Нет аккаунта?', name: 'noAccount', desc: '', args: []);
  }

  /// `Этот номер уже зарегистрирован`
  String get authorized {
    return Intl.message(
      'Этот номер уже зарегистрирован',
      name: 'authorized',
      desc: '',
      args: [],
    );
  }

  /// `Активная учетная запись с такими данными не найдена`
  String get notFoundAccount {
    return Intl.message(
      'Активная учетная запись с такими данными не найдена',
      name: 'notFoundAccount',
      desc: '',
      args: [],
    );
  }

  /// `Повторите пароль`
  String get passwordAgain {
    return Intl.message(
      'Повторите пароль',
      name: 'passwordAgain',
      desc: '',
      args: [],
    );
  }

  /// `Пароли не совпадают`
  String get passwordNotMatch {
    return Intl.message(
      'Пароли не совпадают',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Не правильный код!`
  String get notRightCode {
    return Intl.message(
      'Не правильный код!',
      name: 'notRightCode',
      desc: '',
      args: [],
    );
  }

  /// `Выйти из аккаунта`
  String get signOut {
    return Intl.message(
      'Выйти из аккаунта',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Удалить аккаунт`
  String get deleteAccount {
    return Intl.message(
      'Удалить аккаунт',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Арендовать`
  String get rent {
    return Intl.message('Арендовать', name: 'rent', desc: '', args: []);
  }

  /// `Поиск`
  String get search {
    return Intl.message('Поиск', name: 'search', desc: '', args: []);
  }

  /// `Пусто`
  String get empty {
    return Intl.message('Пусто', name: 'empty', desc: '', args: []);
  }

  /// `Данные арендодателя`
  String get landlordInfo {
    return Intl.message(
      'Данные арендодателя',
      name: 'landlordInfo',
      desc: '',
      args: [],
    );
  }

  /// `Период аренды`
  String get period {
    return Intl.message('Период аренды', name: 'period', desc: '', args: []);
  }

  /// `Адрес`
  String get address {
    return Intl.message('Адрес', name: 'address', desc: '', args: []);
  }

  /// `Описание`
  String get description {
    return Intl.message('Описание', name: 'description', desc: '', args: []);
  }

  /// `Ваш запрос отправлен в арендатору. Ожидайте ответа ближайшее время. Статус аренды вы можете видеть в профиле История заказов`
  String get bookSuccess {
    return Intl.message(
      'Ваш запрос отправлен в арендатору. Ожидайте ответа ближайшее время. Статус аренды вы можете видеть в профиле История заказов',
      name: 'bookSuccess',
      desc: '',
      args: [],
    );
  }

  /// `{price} ₸/{period}`
  String priceTg(Object price, Object period) {
    return Intl.message(
      '$price ₸/$period',
      name: 'priceTg',
      desc: '',
      args: [price, period],
    );
  }

  /// `от {price} тг/{period}`
  String price(Object price, Object period) {
    return Intl.message(
      'от $price тг/$period',
      name: 'price',
      desc: '',
      args: [price, period],
    );
  }

  /// `История заказов`
  String get orderHistory {
    return Intl.message(
      'История заказов',
      name: 'orderHistory',
      desc: '',
      args: [],
    );
  }

  /// `Личные данные`
  String get personalData {
    return Intl.message(
      'Личные данные',
      name: 'personalData',
      desc: '',
      args: [],
    );
  }

  /// `Назад`
  String get back {
    return Intl.message('Назад', name: 'back', desc: '', args: []);
  }

  /// `Забронировать`
  String get book {
    return Intl.message('Забронировать', name: 'book', desc: '', args: []);
  }

  /// `Настройки приложения`
  String get appSettings {
    return Intl.message(
      'Настройки приложения',
      name: 'appSettings',
      desc: '',
      args: [],
    );
  }

  /// `Что-то пошло не так`
  String get somethingWrong {
    return Intl.message(
      'Что-то пошло не так',
      name: 'somethingWrong',
      desc: '',
      args: [],
    );
  }

  /// `Добавить адресс`
  String get addAddress {
    return Intl.message(
      'Добавить адресс',
      name: 'addAddress',
      desc: '',
      args: [],
    );
  }

  /// `Сохранить`
  String get save {
    return Intl.message('Сохранить', name: 'save', desc: '', args: []);
  }

  /// `Вы уверены, что хотите сохранить адрес: {address}`
  String sureAddress(Object address) {
    return Intl.message(
      'Вы уверены, что хотите сохранить адрес: $address',
      name: 'sureAddress',
      desc: '',
      args: [address],
    );
  }

  /// `Название товара`
  String get itemName {
    return Intl.message(
      'Название товара',
      name: 'itemName',
      desc: '',
      args: [],
    );
  }

  /// `Например, самокат jtx`
  String get itemNameHint {
    return Intl.message(
      'Например, самокат jtx',
      name: 'itemNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Поле обязательно для заполнения`
  String get mustFill {
    return Intl.message(
      'Поле обязательно для заполнения',
      name: 'mustFill',
      desc: '',
      args: [],
    );
  }

  /// `Выберите подходящую категорию`
  String get selectCategory {
    return Intl.message(
      'Выберите подходящую категорию',
      name: 'selectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Поиск по категориям`
  String get searchCategory {
    return Intl.message(
      'Поиск по категориям',
      name: 'searchCategory',
      desc: '',
      args: [],
    );
  }

  /// `Если вы не нашли категорию для вашего товара, Вы можете оставить заявку в Службе поддержки и мы рассмотрим ваше предложение для добавление новой категории`
  String get notFountCategory {
    return Intl.message(
      'Если вы не нашли категорию для вашего товара, Вы можете оставить заявку в Службе поддержки и мы рассмотрим ваше предложение для добавление новой категории',
      name: 'notFountCategory',
      desc: '',
      args: [],
    );
  }

  /// `Подходящая категория`
  String get myCategory {
    return Intl.message(
      'Подходящая категория',
      name: 'myCategory',
      desc: '',
      args: [],
    );
  }

  /// `Состояние товара`
  String get conditionItem {
    return Intl.message(
      'Состояние товара',
      name: 'conditionItem',
      desc: '',
      args: [],
    );
  }

  /// `Новое`
  String get newStatus {
    return Intl.message('Новое', name: 'newStatus', desc: '', args: []);
  }

  /// `Идеальное`
  String get ideal {
    return Intl.message('Идеальное', name: 'ideal', desc: '', args: []);
  }

  /// `Хорошее`
  String get good {
    return Intl.message('Хорошее', name: 'good', desc: '', args: []);
  }

  /// `Удовлетворительное`
  String get normal {
    return Intl.message(
      'Удовлетворительное',
      name: 'normal',
      desc: '',
      args: [],
    );
  }

  /// `Стоимость аренды`
  String get rentCost {
    return Intl.message(
      'Стоимость аренды',
      name: 'rentCost',
      desc: '',
      args: [],
    );
  }

  /// `Цена будет автоматически высчитываться сразу после получения товара`
  String get costAutomatic {
    return Intl.message(
      'Цена будет автоматически высчитываться сразу после получения товара',
      name: 'costAutomatic',
      desc: '',
      args: [],
    );
  }

  /// `Добавить период и стоимость аренды`
  String get addPeriod {
    return Intl.message(
      'Добавить период и стоимость аренды',
      name: 'addPeriod',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'час' key

  /// `На день`
  String get day {
    return Intl.message('На день', name: 'day', desc: '', args: []);
  }

  /// `На неделя`
  String get week {
    return Intl.message('На неделя', name: 'week', desc: '', args: []);
  }

  /// `Описание товара`
  String get descriptionItem {
    return Intl.message(
      'Описание товара',
      name: 'descriptionItem',
      desc: '',
      args: [],
    );
  }

  /// `Улица, дом, номер кВа`
  String get addressHint {
    return Intl.message(
      'Улица, дом, номер кВа',
      name: 'addressHint',
      desc: '',
      args: [],
    );
  }

  /// `Удалить выбранное`
  String get removeSelect {
    return Intl.message(
      'Удалить выбранное',
      name: 'removeSelect',
      desc: '',
      args: [],
    );
  }

  /// `отмена`
  String get cancel {
    return Intl.message('отмена', name: 'cancel', desc: '', args: []);
  }

  /// `изменить`
  String get edit {
    return Intl.message('изменить', name: 'edit', desc: '', args: []);
  }

  /// `Добавьте фотографии товара`
  String get addPhotoItem {
    return Intl.message(
      'Добавьте фотографии товара',
      name: 'addPhotoItem',
      desc: '',
      args: [],
    );
  }

  /// `Измените фотографии товара`
  String get changePhotoItem {
    return Intl.message(
      'Измените фотографии товара',
      name: 'changePhotoItem',
      desc: '',
      args: [],
    );
  }

  /// `Добавить фото`
  String get addPhoto {
    return Intl.message('Добавить фото', name: 'addPhoto', desc: '', args: []);
  }

  /// `Выбирайте фотографии в хорошем качестве и сделанные при хорошем освещении, это поможет лучше рассмотреть товар`
  String get addPhotoDesc {
    return Intl.message(
      'Выбирайте фотографии в хорошем качестве и сделанные при хорошем освещении, это поможет лучше рассмотреть товар',
      name: 'addPhotoDesc',
      desc: '',
      args: [],
    );
  }

  /// `Сделать фото`
  String get takePhoto {
    return Intl.message('Сделать фото', name: 'takePhoto', desc: '', args: []);
  }

  /// `Выбрать из галереи`
  String get selectPhoto {
    return Intl.message(
      'Выбрать из галереи',
      name: 'selectPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Главное фото`
  String get mainPhoto {
    return Intl.message('Главное фото', name: 'mainPhoto', desc: '', args: []);
  }

  /// `Перетаскивайте фото, чтоб изменить порядок`
  String get changePhoto {
    return Intl.message(
      'Перетаскивайте фото, чтоб изменить порядок',
      name: 'changePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Цена`
  String get cost {
    return Intl.message('Цена', name: 'cost', desc: '', args: []);
  }

  /// `Укажите стоимость периода`
  String get fillCost {
    return Intl.message(
      'Укажите стоимость периода',
      name: 'fillCost',
      desc: '',
      args: [],
    );
  }

  /// `Выдача и возврат товара`
  String get obtainAndReturn {
    return Intl.message(
      'Выдача и возврат товара',
      name: 'obtainAndReturn',
      desc: '',
      args: [],
    );
  }

  /// `Как получить товар`
  String get howObtain {
    return Intl.message(
      'Как получить товар',
      name: 'howObtain',
      desc: '',
      args: [],
    );
  }

  /// `Как вернуть товар`
  String get howReturn {
    return Intl.message(
      'Как вернуть товар',
      name: 'howReturn',
      desc: '',
      args: [],
    );
  }

  /// `Выберите адрес товара`
  String get addressItem {
    return Intl.message(
      'Выберите адрес товара',
      name: 'addressItem',
      desc: '',
      args: [],
    );
  }

  /// `Заполните все поля`
  String get fillAll {
    return Intl.message(
      'Заполните все поля',
      name: 'fillAll',
      desc: '',
      args: [],
    );
  }

  /// `Успешно!`
  String get success {
    return Intl.message('Успешно!', name: 'success', desc: '', args: []);
  }

  /// `Да`
  String get yes {
    return Intl.message('Да', name: 'yes', desc: '', args: []);
  }

  /// `Вы уверены что хотите удалить аккаунт!`
  String get deleteAccountDesc {
    return Intl.message(
      'Вы уверены что хотите удалить аккаунт!',
      name: 'deleteAccountDesc',
      desc: '',
      args: [],
    );
  }

  /// `Вы уверены что хотите выйти!`
  String get logoutDesc {
    return Intl.message(
      'Вы уверены что хотите выйти!',
      name: 'logoutDesc',
      desc: '',
      args: [],
    );
  }

  /// `Изменить пароль`
  String get changePassword {
    return Intl.message(
      'Изменить пароль',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Изменить фотографию`
  String get newPhoto {
    return Intl.message(
      'Изменить фотографию',
      name: 'newPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Условия использования`
  String get termsUse {
    return Intl.message(
      'Условия использования',
      name: 'termsUse',
      desc: '',
      args: [],
    );
  }

  /// `Правила размещения объявлений`
  String get addItemRule {
    return Intl.message(
      'Правила размещения объявлений',
      name: 'addItemRule',
      desc: '',
      args: [],
    );
  }

  /// `Служба поддержки`
  String get support {
    return Intl.message(
      'Служба поддержки',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Оценить приложение`
  String get rateApp {
    return Intl.message(
      'Оценить приложение',
      name: 'rateApp',
      desc: '',
      args: [],
    );
  }

  /// `Версия {ver}`
  String version(Object ver) {
    return Intl.message('Версия $ver', name: 'version', desc: '', args: [ver]);
  }

  /// `Введите текущий пароль`
  String get writeCurrentPassword {
    return Intl.message(
      'Введите текущий пароль',
      name: 'writeCurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Введите новый пароль`
  String get writeNewPassword {
    return Intl.message(
      'Введите новый пароль',
      name: 'writeNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Новый пароль`
  String get newPassword {
    return Intl.message(
      'Новый пароль',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Изменить данные`
  String get changeInfo {
    return Intl.message(
      'Изменить данные',
      name: 'changeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Заказ выдан: `
  String get given {
    return Intl.message('Заказ выдан: ', name: 'given', desc: '', args: []);
  }

  /// `Просмотрено: `
  String get viewed {
    return Intl.message('Просмотрено: ', name: 'viewed', desc: '', args: []);
  }

  /// `Восстановить`
  String get recover {
    return Intl.message('Восстановить', name: 'recover', desc: '', args: []);
  }

  /// `В архив`
  String get archive {
    return Intl.message('В архив', name: 'archive', desc: '', args: []);
  }

  /// `История заказов`
  String get orders {
    return Intl.message('История заказов', name: 'orders', desc: '', args: []);
  }

  /// `История объявлений`
  String get advertisement {
    return Intl.message(
      'История объявлений',
      name: 'advertisement',
      desc: '',
      args: [],
    );
  }

  /// `Изменить объявление`
  String get changeItem {
    return Intl.message(
      'Изменить объявление',
      name: 'changeItem',
      desc: '',
      args: [],
    );
  }

  /// `Активные`
  String get active {
    return Intl.message('Активные', name: 'active', desc: '', args: []);
  }

  /// `В архиве`
  String get inactive {
    return Intl.message('В архиве', name: 'inactive', desc: '', args: []);
  }

  /// `Выбрано: {count}`
  String selected(Object count) {
    return Intl.message(
      'Выбрано: $count',
      name: 'selected',
      desc: '',
      args: [count],
    );
  }

  /// `Выберите свой город`
  String get chooseCity {
    return Intl.message(
      'Выберите свой город',
      name: 'chooseCity',
      desc: '',
      args: [],
    );
  }

  /// `Информация о заказе`
  String get orderInfo {
    return Intl.message(
      'Информация о заказе',
      name: 'orderInfo',
      desc: '',
      args: [],
    );
  }

  /// `Выбрать`
  String get select {
    return Intl.message('Выбрать', name: 'select', desc: '', args: []);
  }

  /// `Мои заказы`
  String get myOrders {
    return Intl.message('Мои заказы', name: 'myOrders', desc: '', args: []);
  }

  /// `От арендаторов`
  String get orderAt {
    return Intl.message('От арендаторов', name: 'orderAt', desc: '', args: []);
  }

  /// `Все`
  String get all {
    return Intl.message('Все', name: 'all', desc: '', args: []);
  }

  /// `Принятые`
  String get acceptedStatus {
    return Intl.message('Принятые', name: 'acceptedStatus', desc: '', args: []);
  }

  /// `В процессе`
  String get inProgressStatus {
    return Intl.message(
      'В процессе',
      name: 'inProgressStatus',
      desc: '',
      args: [],
    );
  }

  /// `Завершенные`
  String get closedStatus {
    return Intl.message(
      'Завершенные',
      name: 'closedStatus',
      desc: '',
      args: [],
    );
  }

  /// `Новый`
  String get newNew {
    return Intl.message('Новый', name: 'newNew', desc: '', args: []);
  }

  /// `Принят`
  String get accept {
    return Intl.message('Принят', name: 'accept', desc: '', args: []);
  }

  /// `Завершен`
  String get close {
    return Intl.message('Завершен', name: 'close', desc: '', args: []);
  }

  /// `Фильтры`
  String get filter {
    return Intl.message('Фильтры', name: 'filter', desc: '', args: []);
  }

  /// `Арендодателю отправлен смс код. Введите код для подтверждения запроса`
  String get sentOtp {
    return Intl.message(
      'Арендодателю отправлен смс код. Введите код для подтверждения запроса',
      name: 'sentOtp',
      desc: '',
      args: [],
    );
  }

  /// `Общая сумма`
  String get totalAmount {
    return Intl.message('Общая сумма', name: 'totalAmount', desc: '', args: []);
  }

  /// `Данные арендодателя`
  String get rentInfo {
    return Intl.message(
      'Данные арендодателя',
      name: 'rentInfo',
      desc: '',
      args: [],
    );
  }

  /// `Оплатить`
  String get pay {
    return Intl.message('Оплатить', name: 'pay', desc: '', args: []);
  }

  /// `Товар: `
  String get item {
    return Intl.message('Товар: ', name: 'item', desc: '', args: []);
  }

  /// `Все ({count})`
  String allCount(Object count) {
    return Intl.message(
      'Все ($count)',
      name: 'allCount',
      desc: '',
      args: [count],
    );
  }

  /// `Новые ({count})`
  String newCount(Object count) {
    return Intl.message(
      'Новые ($count)',
      name: 'newCount',
      desc: '',
      args: [count],
    );
  }

  /// `Принятые ({count})`
  String accepted(Object count) {
    return Intl.message(
      'Принятые ($count)',
      name: 'accepted',
      desc: '',
      args: [count],
    );
  }

  /// `В процессе ({count})`
  String inProgress(Object count) {
    return Intl.message(
      'В процессе ($count)',
      name: 'inProgress',
      desc: '',
      args: [count],
    );
  }

  /// `Завершенные ({count})`
  String closed(Object count) {
    return Intl.message(
      'Завершенные ($count)',
      name: 'closed',
      desc: '',
      args: [count],
    );
  }

  /// `Заказ №{num}`
  String orderNum(Object num) {
    return Intl.message('Заказ №$num', name: 'orderNum', desc: '', args: [num]);
  }

  /// `Текущий пароль неверен`
  String get wrongCurrentPass {
    return Intl.message(
      'Текущий пароль неверен',
      name: 'wrongCurrentPass',
      desc: '',
      args: [],
    );
  }

  /// `Вы должны зарегистрироваться в качестве арендодателя`
  String get registerLandlord {
    return Intl.message(
      'Вы должны зарегистрироваться в качестве арендодателя',
      name: 'registerLandlord',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'ru')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
