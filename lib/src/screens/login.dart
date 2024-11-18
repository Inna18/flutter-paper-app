import 'package:flutter/material.dart';
import 'package:paper_app/src/repository/login_repository.dart';
import 'package:paper_app/src/screens/traces.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final LoginRepository _loginRepository = LoginRepository();

  FocusScopeNode focus = FocusScopeNode();
  final _passwordController0 = TextEditingController();
  final _passwordController1 = TextEditingController();
  final _passwordController2 = TextEditingController();
  final _passwordController3 = TextEditingController();
  final _passwordController4 = TextEditingController();
  final _passwordController5 = TextEditingController();
  final _codeController = TextEditingController();
  var passwordControllers = [];
  var errorCount = 0;
  var errorMessage = '';
  var password = ['', '', '', '', '', ''];
  late FocusNode firstFocusNode;

  bool remember = false;

  @override
  void dispose() {
    _codeController.dispose();

    _passwordController0.dispose();
    _passwordController1.dispose();
    _passwordController2.dispose();
    _passwordController3.dispose();
    _passwordController4.dispose();
    _passwordController5.dispose();

    firstFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    passwordControllers = [
      _passwordController0,
      _passwordController1,
      _passwordController2,
      _passwordController3,
      _passwordController4,
      _passwordController5,
    ];

    firstFocusNode = FocusNode();

    super.initState();
  }

  void _changeFocus(String inputValue, int index) async {
    setState(() {
      if (inputValue.isNotEmpty) {
        if (password[index].isEmpty) {
          password[index] = inputValue;
        }
      } else {
        password[index] = '';
      }
    });
    focus = FocusScope.of(context);
    if (inputValue.length == 1 && index < password.length) {
      if (index + 1 < password.length && password[index + 1] == '') {
        focus.nextFocus();
      }
    }
    if (inputValue.isEmpty && index != 0) focus.previousFocus();
  }

  List<Widget> getPasswordField() {
    List<Widget> passwordField = [];
    for (var i = 0; i < 6; i++) {
      passwordField.add(Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        width: 40,
        height: 60,
        child: TextField(
          focusNode: i == 0 ? firstFocusNode : null,
          controller: passwordControllers[i],
          maxLength: 1,
          style: TextStyle(
            color: focus.hasFocus && i < password.length && password[i] != ''
                ? const Color.fromRGBO(70, 133, 255, 1)
                : Colors.white,
          ),
          decoration: InputDecoration(
              filled: true,
              fillColor:
                  focus.hasFocus && i < password.length && password[i] != ''
                      ? const Color.fromRGBO(70, 133, 255, 1)
                      : Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                    width: 1, color: Color.fromRGBO(195, 205, 219, 1)),
              ),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                color: Color.fromRGBO(195, 205, 219, 1),
                width: 1,
              ))),
          onChanged: (value) => _changeFocus(value, i),
          // obscureText: true,
        ),
      ));
    }
    return passwordField;
  }

  List<Widget> getLoginError() {
    List<Widget> errorField = [];
    if (errorMessage != '') {
      errorField.add(Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
              Text('다시 확인해주세요. ($errorCount/5)',
                  style: const TextStyle(color: Colors.red)),
            ],
          )));
    }
    return errorField;
  }

  void _login() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    Map<String, dynamic> response =
        await _loginRepository.login(_codeController.text, password.join());

    if (response['message'] == '성공') {
      prefs.getString("token");
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => const TracesScreen()));
    } else {
      setState(() {
        errorMessage = response['message'];
        errorCount += 1;
        password = ['', '', '', '', '', ''];
        _passwordController0.clear();
        _passwordController1.clear();
        _passwordController2.clear();
        _passwordController3.clear();
        _passwordController4.clear();
        _passwordController5.clear();
      });
      firstFocusNode.requestFocus();
      if (errorCount > 5) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('알림'),
              content: const SizedBox(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('입력 허용 횟수 5회를 초과하였습니다.'),
                    Text('비밀번호 초기화를 위해'),
                    Text('거래처 담당자에게 문의 부탁드립니다.'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('확인'),
                  onPressed: () {
                    errorCount = 0;
                    errorMessage = '';
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(1, 20, 57, 0.8),
            borderRadius: BorderRadius.circular(24)),
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/title-lg.png',
              width: 240,
            ),
            const Text('고객사 조회',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            Form(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('고객사 코드',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _codeController,
                            decoration: InputDecoration(
                                hintText: '고객사 코드를 입력해주세요.',
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(16),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(195, 205, 219, 1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(195, 205, 219, 1),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4))),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('간편 비밀번호',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: getPasswordField(),
                    ),
                    Row(
                      children: getLoginError(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: const Text(
                              '고객사코드 저장',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: remember,
                            onChanged: (value) {
                              setState(() {
                                remember = !remember;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            overlayColor:
                                const WidgetStatePropertyAll(Colors.white),
                            activeColor: const Color.fromRGBO(70, 133, 255, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: const Size(300, 54),
                          padding: const EdgeInsets.all(2),
                          shadowColor: Colors.transparent,
                          backgroundColor:
                              const Color.fromRGBO(70, 133, 255, 1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                      onPressed: () => _login(),
                      child: const Text(
                        '로그인',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
