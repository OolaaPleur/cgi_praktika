import 'package:flutter/material.dart';
import 'package:frontend/models/aircraft.dart';
import 'package:frontend/models/flight.dart';
import 'package:frontend/screens/flight_details_screen/widgets/seat_selection_sheet/countdown_dialog.dart';
import 'package:frontend/screens/flight_details_screen/widgets/seat_selection_sheet/seat_legend_container.dart';
import 'package:frontend/screens/flight_details_screen/widgets/seat_selection_sheet/unified_seat_grid.dart';
import 'package:frontend/services/seat_service.dart';
import 'package:frontend/utils/countdown_controller.dart';
import 'package:frontend/utils/pricing_utils.dart';
import 'dart:async';

class SeatSelectionSheet extends StatefulWidget {
  final Aircraft aircraft;
  final FlightDetails flight;
  final int passengerCount;

  const SeatSelectionSheet({
    super.key,
    required this.aircraft,
    required this.flight,
    required this.passengerCount,
  });

  @override
  State<SeatSelectionSheet> createState() => _SeatSelectionSheetState();
}

class _SeatSelectionSheetState extends State<SeatSelectionSheet> {
  final Set<String> _selectedSeats = {};
  final Map<String, bool> _visibleClasses = {};
  bool _showWindowSeats = false;
  bool _showExtraLegroom = false;
  bool _showExitRow = false;
  final int _secondsLeft = 3;
  final CountdownController _countdownController = CountdownController();

  @override
  void initState() {
    super.initState();
    // Initialize all classes as visible with normalized names
    for (var config in widget.aircraft.configurations) {
      _visibleClasses[config.className.toUpperCase()] = true;
    }
  }

  bool _isSeatVisible(String seatClass) {
    final isClassVisible = _visibleClasses[seatClass.toUpperCase()] ?? false;
    return isClassVisible;
  }

  bool _isSeatAvailable(Seat seat) {
    final isClassVisible = _isSeatVisible(seat.seatClass);

    // When _showWindowSeats is false, all seats should be available
    final isWindowVisible = _showWindowSeats ? seat.windowSeat : true;

    // When _showExtraLegroom is false, all seats should be available
    final isLegroomVisible = _showExtraLegroom ? seat.extraLegroom : true;

    // When _showExitRow is false, all seats should be available
    final isExitRowVisible = _showExitRow ? seat.exitRow : true;

    return isClassVisible &&
        isWindowVisible &&
        isLegroomVisible &&
        isExitRowVisible;
  }

  final _seatService = SeatService();

  Future<void> _occupySeats() async {
    final success = await _seatService.occupySeats(
      _selectedSeats.toList(),
      widget.flight.id,
    );

    _countdownController.startCountdown(3, _navigateToMain);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CountdownDialog(
          message:
              success
                  ? "Ticket buying is successful, returning to main page in"
                  : "Seats already taken, returning to main page in",
          isError: !success,
          countdownController: _countdownController,
        );
      },
    );
  }

  void _navigateToMain() {
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (route) => false,
        arguments: {'reload': true},
      );
    }
  }

  @override
  void dispose() {
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Select Your Seat (${_selectedSeats.length}/${widget.passengerCount})',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Check screen width for responsive layout
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWideScreen =
                            MediaQuery.of(context).size.width > 1100;
                        final legendWidget = SeatLegendContainer(
                          configurations: widget.aircraft.configurations,
                          showWindowSeats: _showWindowSeats,
                          showExtraLegroom: _showExtraLegroom,
                          showExitRow: _showExitRow,
                          visibleClasses: _visibleClasses,
                          onWindowSeatsChanged: (bool? value) {
                            setState(() {
                              _showWindowSeats = value ?? true;
                              // Only remove window seats if the filter is on and window seats are not allowed
                              if (_showWindowSeats) {
                                _selectedSeats.removeWhere((seatNumber) {
                                  final seat = widget.aircraft.seats.firstWhere(
                                    (s) => s.seatNumber == seatNumber,
                                  );
                                  return seat.windowSeat && !_showWindowSeats;
                                });
                              }
                            });
                          },
                          onExtraLegroomChanged: (bool? value) {
                            setState(() {
                              _showExtraLegroom = value ?? true;
                              // Only remove extra legroom seats if the filter is on and extra legroom seats are not allowed
                              if (_showExtraLegroom) {
                                _selectedSeats.removeWhere((seatNumber) {
                                  final seat = widget.aircraft.seats.firstWhere(
                                    (s) => s.seatNumber == seatNumber,
                                  );
                                  return seat.extraLegroom &&
                                      !_showExtraLegroom;
                                });
                              }
                            });
                          },
                          onExitRowChanged: (bool? value) {
                            setState(() {
                              _showExitRow = value ?? true;
                              // Only remove exit row seats if the filter is on and exit row seats are not allowed
                              if (_showExitRow) {
                                _selectedSeats.removeWhere((seatNumber) {
                                  final seat = widget.aircraft.seats.firstWhere(
                                    (s) => s.seatNumber == seatNumber,
                                  );
                                  return seat.exitRow && !_showExitRow;
                                });
                              }
                            });
                          },
                          onClassVisibilityChanged: (
                            String className,
                            bool? value,
                          ) {
                            setState(() {
                              final normalizedClassName =
                                  className.toUpperCase();
                              _visibleClasses[normalizedClassName] =
                                  value ?? false;
                              if (!(value ?? true)) {
                                _selectedSeats.removeWhere((seatNumber) {
                                  final seat = widget.aircraft.seats.firstWhere(
                                    (s) => s.seatNumber == seatNumber,
                                    orElse:
                                        () => Seat(
                                          id: 0,
                                          seatNumber: seatNumber,
                                          seatClass: normalizedClassName,
                                          reserved: false,
                                          exitRow: false,
                                          extraLegroom: false,
                                          windowSeat: false,
                                        ),
                                  );
                                  return seat.seatClass.toUpperCase() ==
                                      normalizedClassName;
                                });
                              }
                            });
                          },
                        );

                        if (isWideScreen) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: UnifiedSeatGrid(
                                        key: UniqueKey(),
                                        aircraft: widget.aircraft,
                                        selectedSeats: _selectedSeats,
                                        passengerCount: widget.passengerCount,
                                        isSeatAvailable: _isSeatAvailable,
                                        onSeatTap: (seat, config) {
                                          setState(() {
                                            if (_selectedSeats.contains(
                                              seat.seatNumber,
                                            )) {
                                              _selectedSeats.remove(
                                                seat.seatNumber,
                                              );
                                            } else if (_selectedSeats.length <
                                                widget.passengerCount) {
                                              _selectedSeats.add(
                                                seat.seatNumber,
                                              );
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 32),
                              SizedBox(width: 200, child: legendWidget),
                            ],
                          );
                        }

                        return Column(
                          children: [
                            legendWidget,
                            const SizedBox(height: 24),
                            Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: UnifiedSeatGrid(
                                    key: UniqueKey(),
                                    aircraft: widget.aircraft,
                                    selectedSeats: _selectedSeats,
                                    passengerCount: widget.passengerCount,
                                    isSeatAvailable: _isSeatAvailable,
                                    onSeatTap: (seat, config) {
                                      setState(() {
                                        if (_selectedSeats.contains(
                                          seat.seatNumber,
                                        )) {
                                          _selectedSeats.remove(
                                            seat.seatNumber,
                                          );
                                        } else if (_selectedSeats.length <
                                            widget.passengerCount) {
                                          _selectedSeats.add(seat.seatNumber);
                                        }
                                      });
                                    },
                                  ),
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
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Total Price'),
                        Text(
                          '\$${PricingUtils.calculateTotalPrice(_selectedSeats.toList(), widget.aircraft, widget.flight).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_selectedSeats.isNotEmpty)
                          Text(
                            '(${_selectedSeats.length} seats)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed:
                          _selectedSeats.length != widget.passengerCount
                              ? null
                              : () => _occupySeats(),
                      child: Text(
                        _selectedSeats.length != widget.passengerCount
                            ? 'Select ${widget.passengerCount} Seats'
                            : 'Confirm Selection',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
