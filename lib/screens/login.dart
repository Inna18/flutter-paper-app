import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  FocusScopeNode focus = FocusScopeNode();
  final _codeController = TextEditingController();

  var password = ['', '', '', '', '', ''];
  bool remember = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
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

  void _login() {
    print(_codeController.text);
    print(password);
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
