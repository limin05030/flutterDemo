
class LatLng {
  double lat;
  double lon;
  int time = DateTime.now().millisecondsSinceEpoch;

  LatLng(this.lat, this.lon, {this.time});
}