import 'package:expansesapp/widgets/adaptatives/adaptative_flat_button.dart';
import 'package:expansesapp/widgets/adaptatives/adaptative_raised_button.dart';
import 'package:expansesapp/widgets/adaptatives/adaptative_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final Function addHandler;
  NewTransaction(this.addHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  DateTime _selectedDate;

  _submitData() {
    if (amountCtrl.text.isEmpty) {
      return;
    }
    String title = titleCtrl.text;
    double amount = double.parse(amountCtrl.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addHandler(title, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _openDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme:
                  ColorScheme.light(primary: Theme.of(context).primaryColor),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        }).then((pickedDate) => {
          if (pickedDate != null)
            {
              setState(() {
                _selectedDate = pickedDate;
              })
            }
        });
  }

  String _getSelectedDateLabel(DateTime selectedDate) {
    if (selectedDate != null) {
      String dateFmt = DateFormat('dd/MM/yyyy').format(selectedDate);
      return 'Data escolhida: ${dateFmt}';
    }
    return 'Ainda não escolheu uma data!';
  }

  Widget _getDatePickerForm(DateTime selectedDate) {
    String selectedDateLabel = _getSelectedDateLabel(selectedDate);
    return Container(
      height: 90,
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            selectedDateLabel,
            textAlign: TextAlign.center,
          ),
          AdaptativeFlatButton(
            'Escolha uma data',
            _openDatePicker,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              AdaptativeTextField(
                'Título',
                _submitData,
                titleCtrl
              ),
              AdaptativeTextField(
                'Valor',
                _submitData,
                amountCtrl,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              _getDatePickerForm(_selectedDate),
              AdaptativeRaisedButton(
                'Adicionar',
                _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
