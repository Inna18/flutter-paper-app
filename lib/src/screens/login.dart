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
    setRemember();
    setCode();

    super.initState();
  }

  void setCode() async {
    final prefs = await SharedPreferences.getInstance();
    var check = prefs.getBool('remember');
    var code = prefs.getString('clientCode');
    if (check == true && code != null) {
      _codeController.text = code;
    }
  }

  void setRemember() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      var check = prefs.getBool('remember');
      check == null ? remember = false : remember = check;
    });
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
          keyboardType: TextInputType.number,
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

  bool _filled() {
    if (_codeController.text != '' &&
        _passwordController0.text != '' &&
        _passwordController1.text != '' &&
        _passwordController2.text != '' &&
        _passwordController3.text != '' &&
        _passwordController4.text != '' &&
        _passwordController5.text != '') {
      return true;
    }
    return false;
  }

  void _login() async {
    final prefs = await SharedPreferences.getInstance();
    if (_filled()) {
      prefs.setString('clientCode', _codeController.text);
      print(prefs.getString('clientCode'));
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
                  height: 66,
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
  }

  void _saveCode(value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      remember = value;
      prefs.setBool('remember', remember);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.94,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
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
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 30),
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
                                            color: Color.fromRGBO(
                                                195, 205, 219, 1)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                195, 205, 219, 1),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(4))),
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
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: getPasswordField(),
                            ),
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
                                  onChanged: (value) => _saveCode(value),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  overlayColor: const WidgetStatePropertyAll(
                                      Colors.white),
                                  activeColor:
                                      const Color.fromRGBO(70, 133, 255, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
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
                                backgroundColor: _filled()
                                    ? const Color.fromRGBO(70, 133, 255, 1)
                                    : const Color.fromARGB(126, 160, 191, 255),
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
          ),
        ));
  }
}
