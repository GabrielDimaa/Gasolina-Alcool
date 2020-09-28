import 'package:flutter/material.dart';

void main() {
  	runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
	TextEditingController _gasolina = TextEditingController();
	TextEditingController _alcool = TextEditingController();
	String _result;
	GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
			title: "AP1",
			debugShowCheckedModeBanner: false,
			home: Scaffold(
				appBar: AppBar(
					title: Text("Conversor de Combustível"),
      				backgroundColor: Color(0xFF434B4E),
				),

				body: Container(
					height: double.infinity,
					color: Color(0xFF434B4E),
					child: SingleChildScrollView(
						child: Container(
							child: Column(
								children: <Widget> [
									refresh(),
									card(),
									formResult(),
									buttonResult()
								]
							)
						)
					)
				)
			)	
        );
    }




	// Metodos

	@override
	void initState() {
		super.initState();
		reset();
	}

	void calculate() {
		double gasolina = double.parse(_gasolina.text);
		double alcool = double.parse(_alcool.text);
		double resultado = alcool / gasolina;

		setState(() {
			if (resultado < 0.7) _result = "Abasteça com Álcool!";
			else _result = "Abasteça com Gasolina!";
		});
	}

	void reset() {
		_gasolina.text = "";
		_alcool.text = "";
		setState(() {
			_result = "";
		});
	}





	// Componentes Widgets


// Refresh top App

	Widget refresh() {
		return Container(
			color: Color(0xFF434B4E),
			height: 160,
			width: double.infinity,
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget> [
					textRefresh("Gasolina"),
					buttonRefresh(),
					textRefresh("Álcool")
				]
			)
		);
	}

	Widget textRefresh(texto) {
		return Container(
			decoration: BoxDecoration(
				color: Color(0xFF434B4E),
				borderRadius: BorderRadius.only(
					topLeft: Radius.circular(10),
					topRight: Radius.circular(10),
					bottomLeft: Radius.circular(10),
					bottomRight: Radius.circular(10)
				),
				boxShadow: [
					BoxShadow(
						color: Colors.black.withOpacity(0.2),
						spreadRadius: 3,
						blurRadius: 2,
						offset: Offset(2, 3), // changes position of shadow
					)
				]
			),
			child: Padding(
				padding: EdgeInsets.all(20),
				child: Text(
					texto, 
					style: TextStyle(
						color: Colors.white,
						fontSize: 17
					)
				)
			)
		);
	}

	Widget buttonRefresh() {
		return Padding(
			padding: EdgeInsets.all(20),
			child: MaterialButton(
				child: Icon(
					IconData(0xe627, fontFamily: 'MaterialIcons'),
					size: 35.0,
					color: Colors.white
				),
				color: Color(0xFFEF767A),
				splashColor: Color(0xFFEA484E),
				padding: EdgeInsets.all(15),
				shape: CircleBorder(),
				onPressed: () {
					reset();
				}
			)
		);
	}





// Card contendo Form

	Widget card() {
		return Container(
			margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
			padding: EdgeInsets.all(25),
			width: double.infinity,
			height: 290,
			decoration: BoxDecoration(
				color: Color(0xFF434B4E),
				borderRadius: BorderRadius.only(
					topLeft: Radius.circular(10),
					topRight: Radius.circular(10),
					bottomLeft: Radius.circular(10),
					bottomRight: Radius.circular(10)
				),
				boxShadow: [
					BoxShadow(
						color: Colors.black.withOpacity(0.2),
						spreadRadius: 5,
						blurRadius: 2,
						offset: Offset(2, 3), // changes position of shadow
					)
				]
			),
			child: Column(
				children: <Widget> [
					Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Text("Gasolina", style: TextStyle(color: Color(0xFF7777E4), fontSize: 22)),
							Text("   |   ", style: TextStyle(color: Colors.white, fontSize: 31)),
							Text("Álcool ", style: TextStyle(color: Color(0xFFFFE347), fontSize: 22))
						]
					),
					form()
				]
			)
		);
	}

	Widget form() {
		Color colorGasolina = const Color(0xFF7777E4);
		Color colorAlcool = const Color(0xFFFFE347);

		return Form(
			key: _formKey,
			child: Column(
				children: <Widget>[
					formField(
						label: "Preço da Gasolina",
						error: "Insira o preço da Gasolina",
						controller: _gasolina,
						borderColor: colorGasolina
					),
					formField(
						label: "Preço do Álcool",
						error: "Insira o preço do Álcool",
						controller: _alcool,
						borderColor: colorAlcool
					)
				]
			)
		);
	}

	Widget formField({TextEditingController controller, String error, String label, Color borderColor}) {
		return Padding(
			padding: EdgeInsets.all(10),
			child: TextFormField(
				keyboardType: TextInputType.number,
				style: TextStyle(color: borderColor, fontSize: 17),
				decoration: InputDecoration(
					labelText: label,
					labelStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 17),
					border: OutlineInputBorder(
						borderRadius: BorderRadius.all(Radius.circular(40))
					),
					focusedBorder: OutlineInputBorder(
						borderSide: BorderSide(color: borderColor)
					)
				),
				controller: controller,
				validator: (text) {
					return text.isEmpty ? error : null;
				}
			)
		);
	}




// resultado do form (Obs: fora do card)

	Widget formResult() {
		return Padding(
			padding: EdgeInsets.symmetric(vertical: 40),
			child: Text(
				_result,
				textAlign: TextAlign.center,
				style: TextStyle(color: Color(0xFFEF767A), fontSize: 25)
			)
		);
	}




// button calculador

	Widget buttonResult() {
		return RaisedButton(
			onPressed: () {
				if (_formKey.currentState.validate()) {
					calculate();
				}
			},
			child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 20)),
			color: Color(0xFFEF767A),
			padding: EdgeInsets.symmetric(vertical: 13, horizontal: 35)
      	);
	}
}