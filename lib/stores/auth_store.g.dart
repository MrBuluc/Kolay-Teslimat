// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool>? _$isLoggedInComputed;

  @override
  bool get isLoggedIn => (_$isLoggedInComputed ??=
          Computed<bool>(() => super.isLoggedIn, name: '_AuthStore.isLoggedIn'))
      .value;

  late final _$userAtom = Atom(name: '_AuthStore.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$firstNameAtom =
      Atom(name: '_AuthStore.firstName', context: context);

  @override
  String? get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String? value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  late final _$lastNameAtom =
      Atom(name: '_AuthStore.lastName', context: context);

  @override
  String? get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String? value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  late final _$phoneNoAtom = Atom(name: '_AuthStore.phoneNo', context: context);

  @override
  String? get phoneNo {
    _$phoneNoAtom.reportRead();
    return super.phoneNo;
  }

  @override
  set phoneNo(String? value) {
    _$phoneNoAtom.reportWrite(value, super.phoneNo, () {
      super.phoneNo = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthStore.login', context: context);

  @override
  Future<dynamic> login(String phoneNumber) {
    return _$loginAsyncAction.run(() => super.login(phoneNumber));
  }

  late final _$_AuthStoreActionController =
      ActionController(name: '_AuthStore', context: context);

  @override
  dynamic logout() {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.logout');
    try {
      return super.logout();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
firstName: ${firstName},
lastName: ${lastName},
phoneNo: ${phoneNo},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
