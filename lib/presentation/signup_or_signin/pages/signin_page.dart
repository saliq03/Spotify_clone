import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/business/usecases/auth/signin_with_email.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/data/models/login_user_request.dart';
import 'package:spotify/presentation/signup_or_signin/bloc/auth_bloc.dart';
import 'package:spotify/presentation/signup_or_signin/pages/signup_page.dart';

import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../common/widgets/buttons/basic_app_button.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../service_locator.dart';
import '../../bottom_nav/pages/bottom_nav.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
 final emailController=TextEditingController();

 final passwordController=TextEditingController();
 late AuthBloc _bloc;
 @override
  void initState() {
   _bloc=AuthBloc();
    super.initState();
  }
  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (_) => _bloc,
  child: Scaffold(
      appBar: BasicAppbar(
        title:SvgPicture.asset(AppVectors.logo,height: 35,),hideBack: true,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Sign In",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,),),
                const SizedBox(height: 50,),

                TextFormField(
                  controller: emailController,

                  decoration: const InputDecoration(
                      hintText: "Enter Username Or Email"
                  ).applyDefaults(
                      Theme.of(context).inputDecorationTheme
                  ),
                ),
                const SizedBox(height: 16,),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) => previous.showPasswordSignIn!=current.showPasswordSignIn,
             builder: (context, state) {
               return TextFormField(
                  controller: passwordController,
                  obscureText: state.showPasswordSignIn, 
                  
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: (){
                      context.read<AuthBloc>().add(ShowPasswordSignIn());
                    }, icon:  Icon(state.showPasswordSignIn? CupertinoIcons.eye_slash:CupertinoIcons.eye),padding: const EdgeInsets.only(right: 10),),
                      hintText: "Enter Password"
                  ).applyDefaults(
                      Theme.of(context).inputDecorationTheme
                  ),
                );
  },
),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(onPressed: (){}, child: Text("Recovery Password",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: context.isDarkMode?const Color(0xffAEAEAE):Colors.black),)),
                  ],
                ),
                const SizedBox(height: 10),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) => previous.loadingSignIn!=current.loadingSignIn,
               builder: (context, state) {
               return BasicAppButton(title: "Sign In", onPress: () async {
                context.read<AuthBloc>().add(SignInWithEmailAndPassword(
                    email: emailController.text.toString(),
                    password: passwordController.text.toString(), context: context));
                },loading: state.loadingSignIn,);
  },
),
                const SizedBox(height: 29,),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey,height: 1,)),
                    Text("  Or  ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                    Expanded(child: Divider(color: Colors.grey,height: 1,)),

                  ],
                ),
                const SizedBox(height: 40,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppVectors.google),
                    const SizedBox(width: 60,),
                    SvgPicture.asset(AppVectors.apple,colorFilter: ColorFilter.mode(
                        context.isDarkMode?Colors.white:Colors.black, BlendMode.srcIn),),

                  ],),
                const SizedBox(height: 50,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not A Member?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SignupPage()));
                    }, child: const Text("Register Now",style:TextStyle(fontSize: 15,color: Color(0xff288CE9),fontWeight: FontWeight.w500),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
);
  }
}
