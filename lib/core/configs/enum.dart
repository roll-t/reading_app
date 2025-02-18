enum Status { success, error, wating, loading, none }

// ignore: camel_case_types
enum TypeInput { text, number, password }

enum EmailErrors { format, already }

enum DailyMeals { breakfast, lunch, dinner, snack }

enum TypeDialog { success, warning, error }

enum TagMarker { normal, newUpdate, justPosted, trending }

// ignore: constant_identifier_names
enum RequestApi { POST, GET, PUT, PATCH, DELETE }

enum ApiError {
  badRequest,
  unauthorized,
  notFound,
  serverError,
  unknown,
}

enum ListType {
  newRelease, // tương ứng với "truyen-moi"
  upcoming, // tương ứng với "sap-ra-mat"
  ongoing, // tương ứng với "dang-phat-hanh"
  completed, // tương ứng với "hoan-thanh"
}

enum ApiSource {
  local,
  comic,
}
