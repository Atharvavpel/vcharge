import 'package:redis/redis.dart' as redis;

class RedisConnection {
  static String serverIp = "192.168.0.241";
  static int serverPort = 6379;

  static Future<dynamic> get(String key) async {
      var redisClient = redis.RedisConnection();
    try {
      var conn = await redisClient.connect(serverIp, serverPort);
      var response = conn.send_object(["GET", key]);
      // redisClient.close();
      return response;
    } catch (e) {
      print("Exception in get $e");
    }
  }

  static Future<void> set(String key, dynamic value) async {
    try {
      var redisClient = redis.RedisConnection();
      var conn = await redisClient.connect(serverIp, serverPort);
      conn.send_object(["SET", key, value]);
    } catch (e) {
      print("Exception in set $e");
    }
    // redisClient.close();
  }
}
