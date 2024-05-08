String formatAddressToStateAndCity(String address) {
  final List<String> addressList = address.split(',');

  String cityAndStateAndZip = "";
  String cityAndState = "";
  int zipLength = 0;
  
  try {
    cityAndStateAndZip =
        addressList.sublist(addressList.length - 2).join(', ').toString();
  } catch (Exception) {}

  try {
    zipLength =
        cityAndStateAndZip.split(',')[1].substring(1).split(" ")[2].length;
  } catch (Exception) {}

  try {
    cityAndState = cityAndStateAndZip
        .substring(0, cityAndStateAndZip.length - zipLength)
        .toString();
  } catch (Exception) {}

  return cityAndState;
}
