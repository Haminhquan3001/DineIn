/// only takes the first decimal place from rating
String formatRating(String rating) {
  // Convert the input string to a double
  double number = double.tryParse(rating)!;

  // Check if conversion was successful and number is not null
  if (number != null) {
    // Convert the number to a string with one decimal place
    String result = number.toStringAsFixed(1);

    // Return the result
    return result;
  } else {
    // Return an error message if conversion failed
    return "Invalid input";
  }
}
