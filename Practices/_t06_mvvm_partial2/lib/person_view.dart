import 'package:_t06_mvvm_partial2/person_model.dart';
import 'package:_t06_mvvm_partial2/person_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonView extends StatefulWidget {
  const PersonView({super.key});

  @override
  State<PersonView> createState() => _PersonViewState();
}

enum InputStates { ADD, EDIT }

class _PersonViewState extends State<PersonView> {
  var theController = TextEditingController(text: "X69");
  var anotherController = TextEditingController(text: "69");
  bool updateFlag = false;
  Person? personToUpdate;
  InputStates inputState = InputStates.ADD;

  @override
  Widget build(BuildContext context) {
    PersonViewModel theViewModelEvent = context.watch<PersonViewModel>();

    void callMeOnUpdateClick(Person person) {
      theController.text = person.name;
      anotherController.text = person.age.toString();
      personToUpdate = person;
      updateFlag = true;
    }

    print(theViewModelEvent);
    print(theViewModelEvent.loading);
    print(theViewModelEvent.personList);

    return Scaffold(
      appBar: AppBar(
        title: Text("Person Stuff with MVVM"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(25),
            child: Column(
              children: [
                TextField(
                  controller: theController,
                ),
                TextField(
                  controller: anotherController,
                  keyboardType: TextInputType.number,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (updateFlag) {
                print("trying to update");

                context.read<PersonViewModel>().updatePerson(
                      personToUpdate!,
                      theController.text,
                      int.parse(anotherController.text),
                    );
                updateFlag = false;
                personToUpdate = null;
              } else {
                print("trying to add");
                context.read<PersonViewModel>().addPerson(
                    theController.text, int.parse(anotherController.text));
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              color: Colors.amber[100],
              alignment: Alignment.center,
              child: Text("${!updateFlag ? "Add" : "Edit"} A Person"),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: Colors.red[100],
            child: Text("Person List"),
          ),
          Expanded(
            child: thePersonListUI(theViewModelEvent, callMeOnUpdateClick),
          ),
        ],
      ),
    );
  }
}

Widget thePersonListUI(PersonViewModel personVM, Function updateCallBack) {
  if (personVM.loading) {
    return const CircularProgressIndicator();
  } else {
    List<Person> personList = personVM.personList;
    return ListView.builder(
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(personList[index].name),
            Text("${personList[index].age}"),
            ElevatedButton(
              onPressed: () {
                // print("delete item with index $index");
                context.read<PersonViewModel>().removePerson(personList[index]);
              },
              child: Icon(Icons.delete),
            ),
            ElevatedButton(
              onPressed: () {
                print("update item with index $index");
                updateCallBack(personList[index]);
              },
              child: Icon(Icons.settings_sharp),
            )
          ],
        );
      },
      itemCount: personList.length,
    );
  }
}
