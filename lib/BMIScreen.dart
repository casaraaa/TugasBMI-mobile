import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {

  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  double? _hasilBMI;
  String _keterangan = 'Keterangan muncul disini...';
  String _gender = 'Laki-laki'; 

  void _logikaBMI(){
    final double bb = double.tryParse(_bbController.text) ?? 0;
    final double tbInCm = double.tryParse(_tbController.text) ?? 0;

    setState(() {
      if (bb > 0 && tbInCm > 0) {
        final double tbInM = tbInCm / 100;
        final double bmi = bb / (tbInM * tbInM);

        _hasilBMI = bmi;

        if (_gender == 'Perempuan') {
          if (bmi < 17) {
            _keterangan = 'kurang nih, ayoo banyakin makan.';
          } else if (bmi < 23) {
            _keterangan = 'body goals luvv.';
          } else if (bmi < 27) {
            _keterangan = 'kelebihan nih,diet yuuu.';
          } else {
            _keterangan = 'Obsesitas, ayoo jaga pola makan.';
          }
          return;
        }

        if (bmi < 18.5){
          _keterangan = 'kurus.';
        } else if (bmi < 25){
          _keterangan = 'ideal';
        } else if (bmi < 30){
          _keterangan = 'Gendut.';
        } else {
          _keterangan = 'Obsesitas';
        }
      } else {
        _hasilBMI = null;
        _keterangan = 'Masukan data yang valid';
      }
    });
  }

  void _resetBMI() {
    _bbController.clear();
    _tbController.clear();
    setState(() {
      _hasilBMI = null;
      _keterangan = 'Keterangan muncul disini...';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50, 
      appBar: AppBar(
        title: Text('Kalkulator BMI'),
        leading: Icon(Icons.calculate),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(50),
          child: Center(
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Text(
                  'Hasil BMI :',
                  textAlign: .center,
                  style: TextStyle(
                    fontWeight: .bold,
                    fontSize: 20
                  ),
                ),

                SizedBox(height: 20,),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                    border: Border.all(
                      color: Colors.black
                    ),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Text(_hasilBMI?.toStringAsFixed(1)?? '--',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: .bold
                        ),),
                        SizedBox(height: 20,),
                        Text(_keterangan, style: TextStyle(fontWeight: .bold, color: Colors.red),),

                        SizedBox(height: 8,),
                        Text('Kategori: $_gender'),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                Text(
                  'Silahkan Masukan Data Anda :',
                  textAlign: .center,
                ),

                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: Text('Laki-laki'),
                      avatar: Icon(Icons.male),
                      selected: _gender == 'Laki-laki',
                      onSelected: (_) => setState(() => _gender = 'Laki-laki'),
                    ),
                    SizedBox(width: 12,),
                    ChoiceChip(
                      label: Text('Perempuan'),
                      avatar: Icon(Icons.female),
                      selected: _gender == 'Perempuan',
                      onSelected: (_) => setState(() => _gender = 'Perempuan'),
                    ),
                  ],
                ),

                SizedBox(height: 20,),
                TextField(
                  controller: _bbController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Berat Badan (Kg)',
                    icon: Icon(Icons.monitor_weight),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    )
                  ),
                ),

                SizedBox(height: 20,),
                TextField(
                  controller: _tbController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Tinggi Badan (Cm)',
                    icon: Icon(Icons.height),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    )
                  ),
                ),

                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: _logikaBMI,
                  child: Text(
                    'Hitung BMI',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                  style:ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue
                  ),
                ),

                SizedBox(height: 10,),
                OutlinedButton.icon(
                  onPressed: _resetBMI,
                  icon: Icon(Icons.refresh, color: Colors.red),
                  label: Text('Reset', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}