import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
            top: 70,
            left: 20,
            child: _BtnBack()),
          Center(
            child: Transform.translate(
              offset: Offset(0, -22),
              child: BounceInDown(child: Icon(Icons.location_on_rounded, size: 60,))),
          ),
          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              child: MaterialButton(
                minWidth: size.width - 120,
                child: Text('Confirmar destino', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
                color: Colors.black,
                elevation: 0,
                height: 50,
                //bordes redondeados
                shape: StadiumBorder(),
                onPressed: (){},
              ),
            ))
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.white,
        child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back, color: Colors.black,)),
      ),
    );
  }
}