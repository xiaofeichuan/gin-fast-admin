package tools

import (
	"context"
	"fmt"
	"github.com/go-redis/redis/v8"
	"go-fast-admin/server/common/utils"
	"time"
)

type RedisUtil struct{}

var Redis = new(RedisUtil)
var (
	ctx = context.Background()
	rdb *redis.Client
)

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
	rdb.Set(ctx, key, utils.Json.Serialize(value), expiration)
}

// Get 获取缓存
func (*RedisUtil) Get(key string, value interface{}) error {
	val, err := rdb.Get(ctx, key).Result()
	utils.Json.Deserialize(val, value)
	return err
}

// Del 删除缓存
func (*RedisUtil) Del(key string) {
	rdb.Del(ctx, key)
}

// DelByPattern 模糊删除缓存
func (*RedisUtil) DelByPattern(pattern string) {
	keys := rdb.Keys(ctx, pattern).Val()
	for i := 0; i < len(keys); i++ {
		rdb.Del(ctx, keys[i])
	}
}
