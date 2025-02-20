import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  const BasicAppButton({
    required this.title,required this.onPress,
    this.height,
    this.loading=false,
    super.key});
 final VoidCallback onPress;
 final String title;
 final double? height;
 final bool loading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPress,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height?? 92)
        ),
        child: loading?const Center(child: CircularProgressIndicator(color: Colors.white,))
            :Text(title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20,fontFamily: "Satoshi")));
  }
}
