package tools

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/go-redis/redis/v8"
	"time"
)

type RedisUtil struct{}

var Redis = new(RedisUtil)
var (
	ctx = context.Background()
	rdb *redis.Client
)

// InitRedis 初始化
func InitRedis() *redis.Client {
	rdb = redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		Password: "", // no password set
		DB:       0,  // use default DB
	})
	pong, err := rdb.Ping(ctx).Result()
	if err != nil {
		fmt.Println("连接Redis出现错误：" + err.Error())
	} else {
		fmt.Println("连接Redis成功:" + pong)
	}
	return rdb
}

// Set 设置缓存
func (*RedisUtil) Set(key string, value interface{}, expiration time.Duration) {
	//序列化
	data, _ := json.Marshal(value)
	rdb.Set(ctx, key, string(data), expiration)
}

// Get 获取缓存
func (*RedisUtil) Get(key string, value interface{}) {
	str, _ := rdb.Get(ctx, key).Result()
	//反序列化
	json.Unmarshal([]byte(str), &value)

}

// Del 删除缓存
func (*RedisUtil) Del(key string) {
	rdb.Del(ctx, key)
}

// DelByPattern 模糊删除缓存
func (*RedisUtil) DelByPattern(pattern string) {
	keys, _ := rdb.Keys(ctx, pattern+"*").Result()
	for i := 0; i < len(keys); i++ {
		rdb.Del(ctx, keys[i])
	}
}
