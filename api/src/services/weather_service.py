import random
import datetime

from database.database import database


async def get_data_by_sensor_id(sensor_id: int):
    sensor_data = await database.weather.find({'sensorId': sensor_id}).sort('ts', -1).to_list(length=100)
    if sensor_data and len(sensor_data) > 0:
        return [item for item in sensor_data]
    return None


async def add_random_sensor_data(sensor_id: int):
    sensor_data = {
        'sensorId': sensor_id,
        'ts': datetime.datetime.utcnow(),
        'temp': random.uniform(10.0, 299.9),
        'windSpeed': random.uniform(0.0, 99.9)
    }
    await database.weather.insert_one(sensor_data)
