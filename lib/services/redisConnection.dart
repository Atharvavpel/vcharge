import 'dart:io';
import 'package:redis/redis.dart' as redis;

class RedisConnection{
  static String serverIp = "192.168.0.136";
  static int serverPort = 6379;

  static Future<dynamic> get(String key) async{
    var redisClient = redis.RedisConnection();
    var conn = await redisClient.connect(serverIp, serverPort);
    var response = conn.send_object(["GET",key]);
    // redisClient.close();
    return response;
  }

  static Future<void> set(String key, dynamic value) async{
    var redisClient = redis.RedisConnection();
    var conn = await redisClient.connect(serverIp, serverPort);
    conn.send_object(["SET",key,value]);
    // redisClient.close();
  }
}