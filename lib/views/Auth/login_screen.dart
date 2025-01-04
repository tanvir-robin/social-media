import 'package:appifylab_task/components/common_fullsc_button.dart';
import 'package:appifylab_task/components/textfiled_common.dart';
import 'package:appifylab_task/controllers/auth_controller.dart';
import 'package:appifylab_task/helpers/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: true,
        body: Container(
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (authController) {
            return SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(),
                        const BrandingContainer(),
                        const Spacer(),
                        buildSignInContainer(authController, context),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    ));
  }

  Widget buildSignInContainer(
      AuthController authController, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: const Color(0xFF095661),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          const BoxShadow(
            color: Color(0xFF013D45),
            offset: Offset(0, -4),
            blurRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            offset: const Offset(0, 4),
            blurRadius: 20,
          ),
        ],
      ),
      child: Form(
        key: authController.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Utils.getSpacer(height: 16),
            const Text(
              ' Email',
              style: TextStyle(fontSize: 16, color: Color(0xFFF5F5FF)),
            ),
            Utils.getSpacer(height: 8),
            TextfiledCommon(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter email';
                }
                if (!GetUtils.isEmail(value)) {
                  return 'Please enter valid email';
                }
                return null;
              },
              label: 'Email',
              controller: authController.emailController,
            ),
            Utils.getSpacer(height: 16),
            const Text(
              ' Password',
              style: TextStyle(fontSize: 16, color: Color(0xFFF5F5FF)),
            ),
            Utils.getSpacer(height: 8),
            TextfiledCommon(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
              label: 'Password',
              isPassword: true,
              controller: authController.passwordController,
            ),
            Utils.getSpacer(height: 16),
            Row(
              children: [
                CupertinoCheckbox(
                    checkColor: Colors.black,
                    activeColor: const Color(0xFFE8F54B),
                    value: authController.isRememberMe,
                    onChanged: (value) {
                      authController.setRememberMe(value);
                    }),
                const Text(
                  'Remember me',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Utils.getSpacer(height: 16),
            CommonFullscButton(
              title: 'Login',
              onPressed: () {
                authController.signIn();
              },
            ),
            Utils.getSpacer(height: 40),
          ],
        ),
      ),
    );
  }
}

class BrandingContainer extends StatelessWidget {
  const BrandingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Utils.getCurrentScreenWidth(context) * 0.85,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/logo_main.png',
                height: 40,
              ),
              Utils.getSpacer(width: 8),
              const Text(
                'ezycourse',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'The Best Online Learning Platform',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFFE900),
            ),
          ),
        ],
      ),
    );
  }
}
