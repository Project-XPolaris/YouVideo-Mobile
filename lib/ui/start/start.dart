import 'package:flutter/material.dart';
import 'package:youui/layout/login/LoginLayout.dart';
import 'package:youvideo/config.dart';
import 'package:youvideo/ui/home/wrap.dart';
import 'package:youvideo/ui/start/youauth_md.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: LoginLayout(
                onLoginSuccess: (loginAccount) async {
                  await ApplicationConfig().saveAuth(
                    apiUrl: loginAccount.apiUrl ?? "",
                    token: loginAccount.token ?? "",
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePageWrap()),
                  );
                },
                title: "YouVideo",
                subtitle: "ProjectXPolaris",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.dashboard),
                label: const Text("使用 MediaDashboard 登录并选择服务"),
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MdLoginPage()),
                  );
                  if (result == true) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePageWrap()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
