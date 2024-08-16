enum FromDestinationType {
  fromDestination(0, 'destination'),
  fromBookRide(1, 'bookRide'),
  fromHome(3, 'fromHome'),
  fromPickup(4, 'fromPickup');

  final int id;
  final String description;

  const FromDestinationType(this.id, this.description);
}
