import 'package:exchange_rate_currency_app/core/utils/functions/get_dates_between.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/exchange_rate_cubit/exchangeratecubit_cubit.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/inputscubits/cubit/inputscubit_cubit.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/inputscubits/cubit/inputscubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeRateTableWidget extends StatelessWidget {
  const ExchangeRateTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeRateCubit, ExchangeratecubitState>(
      builder: (context, exchangeState) {
        if (exchangeState is ExchangeratecubitSuceess) {
          final cubit = context.read<ExchangeRateCubit>();
          final inputsState =
              context.read<InputsCubitCubit>().state as InputsUpdated;
          final allDates = getDatesBetween(
            inputsState.startDate.toString(),
            inputsState.endDate.toString(),
          );
          const int rowsPerPage = 10;
          final int totalPages = (allDates.length / rowsPerPage).ceil();

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      border: TableBorder.all(color: Colors.grey.shade300),
                      columnWidths: const {
                        0: FixedColumnWidth(120), // Date
                        1: FixedColumnWidth(80), // From
                        2: FixedColumnWidth(80), // To
                        3: FixedColumnWidth(100), // Price
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.1),
                          ),
                          children: const [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Date',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'From',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'To',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Price',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ...List.generate(
                          (allDates.length >
                                  (exchangeState.currentpage + 1) * rowsPerPage)
                              ? rowsPerPage
                              : allDates.length -
                                  (exchangeState.currentpage * rowsPerPage),
                          (index) {
                            int dataIndex =
                                exchangeState.currentpage * rowsPerPage + index;
                            String dateKey = allDates[dataIndex];
                            return TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      dateKey,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${inputsState.fromCurrency}",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${inputsState.toCurrency}",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      exchangeState
                                              .exchangeRate
                                              .dates[dateKey]?["${inputsState.fromCurrency}${inputsState.toCurrency}"]
                                              .toString() ??
                                          'N/A',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton.small(
                    onPressed:
                        exchangeState.currentpage > 0
                            ? () =>
                                cubit.updatePage(exchangeState.currentpage - 1)
                            : null,
                    backgroundColor:
                        exchangeState.currentpage > 0
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                    child: const Icon(Icons.arrow_left),
                  ),
                  Text(
                    "Page ${exchangeState.currentpage + 1} of $totalPages",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  FloatingActionButton.small(
                    onPressed:
                        exchangeState.currentpage < totalPages - 1
                            ? () =>
                                cubit.updatePage(exchangeState.currentpage + 1)
                            : null,
                    backgroundColor:
                        exchangeState.currentpage < totalPages - 1
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                    child: const Icon(Icons.arrow_right),
                  ),
                ],
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
