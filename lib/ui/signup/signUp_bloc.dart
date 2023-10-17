
import 'package:bashtil/bases/button_bloc.dart';
import 'package:bashtil/bases/validator.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends ButtonBloc {
  final _emailBehaviour = BehaviorSubject<String>();
  final _passwordBehaviour = BehaviorSubject<String>();
  final _employeeBehaviour = BehaviorSubject<String>();

  final Validator _validator = Validator();

  Stream<String> get email => _emailBehaviour.stream;

  Stream<String> get password => _passwordBehaviour.stream;

  Stream<String> get employee => _employeeBehaviour.stream;

  Function(String) get updateEmail => _emailBehaviour.sink.add;

  Function(String) get updatePassword => _passwordBehaviour.sink.add;

  Function(String) get updateEmployee => _employeeBehaviour.sink.add;

  @override
  void init() {
    super.init();
    _employeeBehaviour.sink.add('0');
  }

  Stream<bool> get validate =>
      Rx.combineLatest3(_emailBehaviour, _employeeBehaviour, _passwordBehaviour,
          (
        String email,
        String employee,
        String password,
      ) {
        if (_validator.isEmailValid(email) &&
            employee != 0 &&
            _validator.isPasswordValid(password)) return true;
        return false;
      });

  bool get isValid =>
      _validator.isEmailValid(_emailBehaviour.value) &&
      _employeeBehaviour.value != 0 &&
      _validator.isPasswordValid(_passwordBehaviour.value);



  @override
  void dispose() {
    super.dispose();

    _emailBehaviour.close();
    _passwordBehaviour.close();
  }
}
