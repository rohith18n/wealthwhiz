import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import '../../Account/balance.dart';
import '../../chart_function/chart_function.dart';
import '../../graph/graphmodel.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _Statistics_ScreenState();
}

// ignore: camel_case_types
class _Statistics_ScreenState extends State<StatisticsScreen>
    with TickerProviderStateMixin {
  List<ChartDatas> dataExpense = chartLogic(expenseAllNotifier.value);
  List<ChartDatas> dataIncome = chartLogic(incomeAllNotifier.value);
  List<ChartDatas> dataAll = chartLogic(allNotifier.value);
  List<ChartDatas> yesterday = chartLogic(yesterdayNotifier.value);
  List<ChartDatas> today = chartLogic(todayNotifier.value);
  List<ChartDatas> month = chartLogic(lastMonthNotifier.value);
  List<ChartDatas> week = chartLogic(lastWeekNotifier.value);
  List<ChartDatas> todayIncome = chartLogic(incomeTodayNotifier.value);
  List<ChartDatas> incomeYesterday = chartLogic(incomeYesterdayNotifier.value);
  List<ChartDatas> incomeweek = chartLogic(incomeLastWeekNotifier.value);
  List<ChartDatas> incomemonth = chartLogic(incomeLastMonthNotifier.value);
  List<ChartDatas> todayExpense = chartLogic(expenseTodayNotifier.value);
  List<ChartDatas> expenseYesterday =
      chartLogic(expenseYesterdayNotifier.value);
  List<ChartDatas> expenseweek = chartLogic(expenseLastWeekNotifier.value);
  List<ChartDatas> expensemonth = chartLogic(expenseLastMonthNotifier.value);
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    filterFunction();
    chartdivertFunctionAll();
    chartdivertFunctionExpense();
    chartdivertFunctionIncome();
    super.initState();
  }

  String categoryId2 = 'All';
  int touchIndex = 1;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightGreen,
        title: const Text(
          'Statistics',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.039,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 24,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(18),
              elevation: 4,
              child: Container(
                height: height * 0.0457,
                width: width * 0.63,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                    left: 15,
                  ),
                  child: DropdownButton<String>(
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    isExpanded: true,
                    underline: const Divider(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    value: categoryId2,
                    items: <String>[
                      'All',
                      'Today',
                      'Yesterday',
                      'This week',
                      'This month',
                    ]
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        categoryId2 = value.toString();
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.045,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ]),
                controller: tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                tabs: const [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Income',
                  ),
                  Tab(
                    text: 'Expense',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.0263,
          ),
          SizedBox(
            width: double.maxFinite,
            height: height * 0.526,
            child: TabBarView(
              controller: tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: chartdivertFunctionAll().isEmpty
                      ? Center(
                          child: Lottie.asset(
                            'images/rubicscube.json',
                            width: width * 0.9,
                            height: height * 0.4,
                          ),
                        )
                      : SfCircularChart(
                          legend: Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                            position: LegendPosition.bottom,
                          ),
                          series: <CircularSeries>[
                            PieSeries<ChartDatas, String>(
                              dataLabelSettings: const DataLabelSettings(
                                color: Colors.white,
                                isVisible: true,
                                connectorLineSettings: ConnectorLineSettings(
                                    type: ConnectorType.curve),
                                overflowMode: OverflowMode.shift,
                                showZeroValue: false,
                                labelPosition: ChartDataLabelPosition.outside,
                              ),
                              dataSource: chartdivertFunctionAll(),
                              xValueMapper: (ChartDatas data, _) =>
                                  data.category,
                              yValueMapper: (ChartDatas data, _) => data.amount,
                              explode: true,
                            )
                          ],
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: chartdivertFunctionIncome().isEmpty
                      ? Center(
                          child: Lottie.asset(
                            'images/rubicscube.json',
                            width: width * 0.9,
                            height: height * 0.4,
                          ),
                        )
                      : SfCircularChart(
                          legend: Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                            position: LegendPosition.bottom,
                          ),
                          series: <CircularSeries>[
                            PieSeries<ChartDatas, String>(
                              dataLabelSettings: const DataLabelSettings(
                                color: Colors.white,
                                isVisible: true,
                                connectorLineSettings: ConnectorLineSettings(
                                    type: ConnectorType.curve),
                                overflowMode: OverflowMode.shift,
                                showZeroValue: false,
                                labelPosition: ChartDataLabelPosition.outside,
                              ),
                              dataSource: chartdivertFunctionIncome(),
                              xValueMapper: (ChartDatas data, _) =>
                                  data.category,
                              yValueMapper: (ChartDatas data, _) => data.amount,
                              explode: true,
                            )
                          ],
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: chartdivertFunctionExpense().isEmpty
                      ? Center(
                          child: Lottie.asset(
                            'images/rubicscube.json',
                            width: width * 0.9,
                            height: height * 0.4,
                          ),
                        )
                      : SfCircularChart(
                          legend: Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                            position: LegendPosition.bottom,
                          ),
                          series: <CircularSeries>[
                            PieSeries<ChartDatas, String>(
                              dataLabelSettings: const DataLabelSettings(
                                color: Colors.white,
                                isVisible: true,
                                connectorLineSettings: ConnectorLineSettings(
                                    type: ConnectorType.curve),
                                overflowMode: OverflowMode.shift,
                                showZeroValue: false,
                                labelPosition: ChartDataLabelPosition.outside,
                              ),
                              dataSource: chartdivertFunctionExpense(),
                              xValueMapper: (ChartDatas data, _) =>
                                  data.category,
                              yValueMapper: (ChartDatas data, _) => data.amount,
                              explode: true,
                            )
                          ],
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  chartdivertFunctionAll() {
    if (categoryId2 == 'All') {
      return dataAll;
    }
    if (categoryId2 == 'Today') {
      return today;
    }
    if (categoryId2 == 'Yesterday') {
      return yesterday;
    }
    if (categoryId2 == 'This week') {
      return week;
    }
    if (categoryId2 == 'This month') {
      return month;
    }
  }

  chartdivertFunctionIncome() {
    if (categoryId2 == 'All') {
      return dataIncome;
    }
    if (categoryId2 == 'Today') {
      return todayIncome;
    }
    if (categoryId2 == 'Yesterday') {
      return incomeYesterday;
    }
    if (categoryId2 == 'This week') {
      return incomeweek;
    }
    if (categoryId2 == 'This month') {
      return incomemonth;
    }
  }

  chartdivertFunctionExpense() {
    if (categoryId2 == 'All') {
      return dataExpense;
    }
    if (categoryId2 == 'Today') {
      return todayExpense;
    }
    if (categoryId2 == 'Yesterday') {
      return expenseYesterday;
    }
    if (categoryId2 == 'This week') {
      return expenseweek;
    }
    if (categoryId2 == 'This month') {
      return expensemonth;
    }
  }
}
