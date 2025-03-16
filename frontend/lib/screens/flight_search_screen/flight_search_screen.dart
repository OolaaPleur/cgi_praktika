import 'package:flutter/material.dart';
import '../../services/flight_service.dart';
import '../../models/flight.dart';
import 'widgets/search_form.dart';
import 'widgets/flight_list.dart';

class FlightSearchScreen extends StatefulWidget {
  final FlightService? flightService;

  const FlightSearchScreen({super.key, this.flightService});

  @override
  State<FlightSearchScreen> createState() => _FlightSearchScreenState();
}

class _FlightSearchScreenState extends State<FlightSearchScreen> {
  DateTime? _selectedDate;
  late final FlightService _flightService;
  List<Flight> _flights = [];
  List<Flight> _filteredFlights = [];
  bool _isLoading = false;
  Set<String> _airports = {};
  Set<String> _selectedContinents = {};
  String _fromText = '';
  String _toText = '';
  int _passengers = 1;
  String _currentSortOption = 'default';

  @override
  void initState() {
    super.initState();
    // Use the provided flight service or create a default one
    _flightService = widget.flightService ?? FlightService();
    _loadFlights();
  }

  Future<void> _loadFlights() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final flights = await _flightService.getFlights();
      setState(() {
        _flights = flights;
        _filteredFlights = flights;
        _airports = flights.fold<Set<String>>(
          {},
          (set, flight) =>
              set
                ..add(flight.departureAirport)
                ..add(flight.arrivalAirport),
        );
        // Initialize selected continents with all available continents
        _selectedContinents = flights.uniqueContinents;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading flights: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  void _filterFlights() {
    setState(() {
      _filteredFlights =
          _flights.where((flight) {
            // Filter by departure and arrival airports
            final matchesDeparture =
                _fromText.isEmpty ||
                flight.departureAirport.toLowerCase().contains(
                  _fromText.toLowerCase(),
                );
            final matchesArrival =
                _toText.isEmpty ||
                flight.arrivalAirport.toLowerCase().contains(
                  _toText.toLowerCase(),
                );

            // Filter by departure date
            final matchesDepartureDate =
                _selectedDate == null ||
                flight.departureDateTime.year == _selectedDate!.year &&
                    flight.departureDateTime.month == _selectedDate!.month &&
                    flight.departureDateTime.day == _selectedDate!.day;

            // Filter by selected continents
            final matchesContinent = _selectedContinents.contains(
              flight.arrivalContinent,
            );

            return matchesDeparture &&
                matchesArrival &&
                matchesDepartureDate &&
                matchesContinent;
          }).toList();
    });
  }

  void _sortFlights(String sortBy) {
    setState(() {
      _currentSortOption = sortBy;
      switch (sortBy) {
        case 'cheapest':
          _filteredFlights.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'expensive':
          _filteredFlights.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'default':
          // Sort by ID to restore original order
          _filteredFlights.sort((a, b) => a.id.compareTo(b.id));
          break;
      }
    });
  }

  ButtonStyle _getSortButtonStyle(String sortOption) {
    final isSelected = _currentSortOption == sortOption;
    return ElevatedButton.styleFrom(
      backgroundColor: isSelected ? Colors.blue : Colors.white,
      foregroundColor: isSelected ? Colors.white : Colors.blue,
      side: const BorderSide(color: Colors.blue),
      elevation: isSelected ? 2 : 0,
    );
  }

  ButtonStyle _getContinentButtonStyle(String continent) {
    final isSelected = _selectedContinents.contains(continent);
    return ElevatedButton.styleFrom(
      backgroundColor: isSelected ? Colors.blue : Colors.white,
      foregroundColor: isSelected ? Colors.white : Colors.blue,
      side: const BorderSide(color: Colors.blue),
      elevation: isSelected ? 2 : 0,
    );
  }

  void _toggleContinent(String continent) {
    setState(() {
      if (_selectedContinents.contains(continent)) {
        _selectedContinents.remove(continent);
      } else {
        _selectedContinents.add(continent);
      }

      // 1. Filter flights based on selected continents
      _filterFlights();

      // 2. Sort flights based on current sort option
      _sortFlights(_currentSortOption);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background image in container (will scroll up)
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width > 900 ? 400 : 600,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/search_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 150),
                    const Text(
                      'Discover Your Flight Experience',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // Center SearchForm
                    Center(
                      child: SearchForm(
                        airports: _airports,
                        selectedDate: _selectedDate,
                        passengers: _passengers,
                        onFromChanged: (value) {
                          setState(() {
                            _fromText = value;
                          });
                          _filterFlights();
                        },
                        onToChanged: (value) {
                          setState(() {
                            _toText = value;
                          });
                          _filterFlights();
                        },
                        onDateSelected: (date) {
                          setState(() {
                            _selectedDate = date;
                          });
                          _filterFlights();
                        },
                        onPassengersChanged: (value) {
                          setState(() {
                            _passengers = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            // Flight deals section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      // Continent filters
                      if (!_isLoading && _flights.isNotEmpty)
                        ...(_flights.uniqueContinents.toList()..sort()).map(
                          (continent) => ElevatedButton.icon(
                            onPressed: () => _toggleContinent(continent),
                            icon: Icon(
                              _selectedContinents.contains(continent)
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                            ),
                            label: Text(continent),
                            style: _getContinentButtonStyle(continent),
                          ),
                        ),

                      if (MediaQuery.of(context).size.width > 900)
                        Transform.rotate(
                          angle: 15 * 3.14159 / 180, // 45 degrees in radians
                          child: const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 4,
                            ),
                          ),
                        ),
                      // Sort buttons
                      ElevatedButton.icon(
                        onPressed: () => _sortFlights('default'),
                        icon: const Icon(Icons.sort),
                        label: const Text('Default'),
                        style: _getSortButtonStyle('default'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _sortFlights('cheapest'),
                        icon: const Icon(Icons.arrow_upward),
                        label: const Text('Cheapest'),
                        style: _getSortButtonStyle('cheapest'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _sortFlights('expensive'),
                        icon: const Icon(Icons.arrow_downward),
                        label: const Text('Most Expensive'),
                        style: _getSortButtonStyle('expensive'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FlightList(
                    flights: _filteredFlights,
                    isLoading: _isLoading,
                    passengerCount: _passengers,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
