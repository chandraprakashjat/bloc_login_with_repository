import 'package:bloc_login/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  FocusNode focusNodeName = FocusNode();

  FocusNode focusNodePass = FocusNode();

  @override
  void initState() {
    super.initState();

    focusNodeName.addListener(() {
      if (!focusNodeName.hasFocus) {
        context.read<LoginBloc>().add(UnFocusName());
        FocusScope.of(context).requestFocus(focusNodePass);
      } else {
        FocusScope.of(context).requestFocus(focusNodeName);
      }
    });

    focusNodePass.addListener(() {
      if (!focusNodePass.hasFocus) {
        context.read<LoginBloc>().add(UnFocusPassword());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.formzStatus == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login faild:Try again')));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _NameInput(focusNodeName),
            const Padding(
              padding: EdgeInsets.all(12),
            ),
            _PasswordInput(focusNodePass),
            const Padding(
              padding: EdgeInsets.all(12),
            ),
            _SubmitButton()
          ],
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput(this.focusNode);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (pre, current) => pre.name != current.name,
        builder: (context, state) {
          return TextFormField(
            focusNode: focusNode,
            key: const Key('loginForm_userNameInput_textField'),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            onChanged: (value) =>
                context.read<LoginBloc>().add(NameChangeEvent(value)),
            decoration: InputDecoration(
                labelText: 'Name',
                helperText: 'Enter User Name',
                errorText: state.name.invalid ? 'Enter User Name' : null,
                icon: const Icon(Icons.person)),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput(this.focusNode);
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (current, next) => current.password != next.password,
        builder: (context, state) {
          return TextFormField(
              key: const Key('loginForm_password_inputFieldKey'),
              focusNode: focusNode,
              textInputAction: TextInputAction.done,
              obscureText: true,
              onChanged: (value) =>
                  context.read<LoginBloc>().add(PasswordChangeEvent(value)),
              decoration: InputDecoration(
                labelText: 'Password',
                helperText: 'Enter Your Password',
                icon: const Icon(Icons.lock),
                errorText:
                    state.password.invalid ? 'Enter Valid password' : null,
              ));
        });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (pre, current) => pre.formzStatus != current.formzStatus,
        builder: (context, state) {
          return state.formzStatus.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    context.read<LoginBloc>().add(OnSubmit());
                  },
                  child: const Text('Submit'));
        });
  }
}
