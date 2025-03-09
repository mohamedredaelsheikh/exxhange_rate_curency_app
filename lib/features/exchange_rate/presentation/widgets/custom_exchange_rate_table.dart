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
            // شيلنا الـ Expanded وحطينا Column
            mainAxisSize: MainAxisSize.min, // نتحكم في الحجم
            children: [
              Table(
                border: TableBorder.all(),
                children: [
                  const TableRow(
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'From',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('To', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        'Price',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                          TableCell(child: Text(dateKey)),
                          TableCell(child: Text("${inputsState.fromCurrency}")),
                          TableCell(child: Text("${inputsState.toCurrency}")),
                          TableCell(
                            child: Text(
                              exchangeState
                                      .exchangeRate
                                      .dates[dateKey]?["${inputsState.fromCurrency}${inputsState.toCurrency}"]
                                      .toString() ??
                                  'N/A',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed:
                        exchangeState.currentpage > 0
                            ? () =>
                                cubit.updatePage(exchangeState.currentpage - 1)
                            : null,
                    child: const Text("Previous"),
                  ),
                  Text("Page ${exchangeState.currentpage + 1} of $totalPages"),
                  ElevatedButton(
                    onPressed:
                        exchangeState.currentpage < totalPages - 1
                            ? () =>
                                cubit.updatePage(exchangeState.currentpage + 1)
                            : null,
                    child: const Text("Next"),
                  ),
                ],
              ),
            ],
          );
        }
        return const Text(
          " Please Select Currencies and Dates ",
          style: TextStyle(
            color: Colors.red,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
