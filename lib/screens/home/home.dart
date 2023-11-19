import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:wealthwhiz/Screens/home/widgets/rootpage.dart';
import 'package:wealthwhiz/Screens/profile/profilepage.dart';
import '../../Account/balance.dart';
import '../../db/transactions/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../transaction/edit_transaction/edit_transaction.dart';
import '../transaction/viewtransaction/view_transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshAll();
    balanceAmount();
    var time = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: const Text(
          'WealthWhiz',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfilePage()));
              },
              icon: const Icon(
                IconlyLight.setting,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              color: Colors.limeAccent[700],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.03,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(IconlyLight.calendar, color: Colors.white),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          DateFormat("dd-MMMM-yyyy").format(time),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                      valueListenable: totalNotifier,
                      builder: (context, value, child) {
                        return Column(
                          children: [
                            const Text(
                              'Balance',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              totalNotifier.value.toString(),
                              style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.transparent),
                          child: const Icon(
                            Icons.arrow_downward,
                            color: Colors.green,
                            size: 47,
                          ),
                        ),
                        Column(
                          children: [
                            const Text(
                              "Income",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            ValueListenableBuilder(
                                valueListenable: incomeNotifier,
                                builder: (context, value, child) {
                                  return Text(
                                    incomeNotifier.value.toString(),
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 20,
                                        color: Colors.blueGrey),
                                  );
                                }),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 0,
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Expense",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                ValueListenableBuilder(
                                    valueListenable: expenseNotifier,
                                    builder: (context, value, child) {
                                      return Text(
                                        expenseNotifier.value.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.blueGrey),
                                      );
                                    }),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.transparent),
                              child: const Icon(
                                Icons.arrow_upward,
                                color: Colors.red,
                                size: 47,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: const Text(
                'Recent Transactions',
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05),
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      elevation: MaterialStateProperty.all<double>(5),
                      shadowColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    RootPage.selectedIndexNotifier.value = 1;
                  },
                  child: const Text('View All')),
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: TransactionDB.instance.transactionListNotifier,
          builder: (BuildContext context, List<TransactionModel> newList,
              Widget? _) {
            return Expanded(
                child: newList.isNotEmpty
                    ? ListView.separated(
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          final value = newList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => View_Transaction(
                                            amount: value.amount,
                                            category: value.category.name,
                                            description: value.purpose,
                                            date: value.date,
                                          )));
                            },
                            child: Slidable(
                              startActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      borderRadius: BorderRadius.circular(20),
                                      spacing: 8,
                                      backgroundColor: Colors.lightGreen,
                                      foregroundColor: Colors.black,
                                      icon: IconlyLight.edit,
                                      label: 'Edit',
                                      onPressed: (context) {
                                        final model = TransactionModel(
                                            purpose: value.purpose,
                                            amount: value.amount,
                                            date: value.date,
                                            category: value.category,
                                            type: value.type,
                                            id: value.id);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditTransaction(
                                                      model: model,
                                                    )));
                                      },
                                    ),
                                    SlidableAction(
                                        borderRadius: BorderRadius.circular(20),
                                        spacing: 8,
                                        backgroundColor: Colors.lightGreen,
                                        foregroundColor: Colors.black,
                                        icon: IconlyLight.delete,
                                        label: 'Delete',
                                        onPressed: (context) {
                                          value;

                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Delete'),
                                                  content: const Text(
                                                      'Do you want to delete this transaction?'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            'Cancel')),
                                                    TextButton(
                                                        onPressed: () {
                                                          TransactionDB.instance
                                                              .deleteTransaction(
                                                                  value.id!);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text('Ok'))
                                                  ],
                                                );
                                              });
                                        })
                                  ]),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: value.type == CategoryType.income
                                        ? Colors.white
                                        : Colors.white,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.limeAccent[700],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      leading: Text(
                                        parseDate(value.date),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      trailing: Column(
                                        children: [
                                          Text(
                                            ' ${value.category.name}',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: value.type ==
                                                      CategoryType.income
                                                  ? Colors.green[900]
                                                  : Colors.red,
                                            ),
                                          ),
                                          Text(
                                            "₹ ${value.amount}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: value.type ==
                                                      CategoryType.income
                                                  ? Colors.green[900]
                                                  : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 11,
                          );
                        },
                        itemCount: newList.length,
                      )
                    : Center(
                        child: SizedBox(
                          height: 240,
                          width: 240,
                          child: Lottie.asset('images/rubicscube.json'),
                        ),
                      ));
          },
        ),
      ]),
    );
  }

  String parseDate(DateTime date) {
    final date0 = DateFormat.MMMd().format(date);
    final splitedDate = date0.split(' ');
    return ' ${splitedDate.first} ${splitedDate.last}';
  }
}
