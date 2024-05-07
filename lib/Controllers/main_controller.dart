import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Controllers/field_controller.dart';
import 'package:tarim_ai/Services/api_service.dart';

class MainController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    final FieldController fieldController = Get.find<FieldController>();

    // FieldController'dan soilData'nın var olup olmadığını kontrol et
    if (fieldController.soilData.value != null) {
      // soilData varsa ve içinde latitude & longitude bilgisi varsa kullan
      var soilData = fieldController.soilData.value!;
      if (soilData.latitude != null && soilData.longitude != null) {
        // Direkt olarak FieldController'dan alınan değerleri kullan
        currentWeatherData =
            getCurrentWeather(soilData.latitude!, soilData.longitude!);
        hourlyWeatherData =
            getHourlyWeather(soilData.latitude!, soilData.longitude!);
        daillyWeatherData =
            getDaillyWeather(soilData.latitude!, soilData.longitude!);
      }
    } else {
      // Eğer soilData yoksa veya içinde konum bilgisi yoksa, kullanıcının mevcut konumunu kullan
      await getUserLocation();
      currentWeatherData = getCurrentWeather(latitude.value, longitude.value);
      hourlyWeatherData = getHourlyWeather(latitude.value, longitude.value);
      daillyWeatherData = getDaillyWeather(latitude.value, longitude.value);
    }
  }

  dynamic currentWeatherData;
  dynamic hourlyWeatherData;
  dynamic daillyWeatherData;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isloaded = false.obs;

  void updateWeatherData(double lat, double lon) async {
    // Hava durumu API'sini kullanarak verileri al
    currentWeatherData = getCurrentWeather(lat, lon);
    hourlyWeatherData = getHourlyWeather(lat, lon);
    daillyWeatherData = getDaillyWeather(lat, lon);
    isloaded.value = false; // Yükleniyor durumuna getir
    await Future.delayed(
        const Duration(milliseconds: 100)); // API'den yanıt bekleniyor
    isloaded.value = true; // Yükleme tamamlandı, UI'ı güncelle
  }

  getUserLocation() async {
    bool isLocationEnabled;
    LocationPermission userPermission;

    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return Future.error("Location is not enabled");
    }

    userPermission = await Geolocator.checkPermission();
    if (userPermission == LocationPermission.deniedForever) {
      return Future.error("Permission is denied forever");
    } else if (userPermission == LocationPermission.denied) {
      userPermission = await Geolocator.requestPermission();
      if (userPermission == LocationPermission.denied) {
        return Future.error("Permission is denied");
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      latitude.value = value.latitude;
      longitude.value = value.longitude;
      isloaded.value = true;
    });
  }
}
