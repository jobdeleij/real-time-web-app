from loguru import logger
from bson.json_util import dumps
from fastapi.middleware.cors import CORSMiddleware
from fastapi import Depends, FastAPI, WebSocket, WebSocketDisconnect

from modules.websockets import ConnectionManager
from services.weather_service import get_data_by_sensor_id, add_random_sensor_data

app = FastAPI(
    title="Real-time web application API",
    description="Real-time web application API",
    version="1.0.0",
)

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)

websockets_manager = ConnectionManager()


@app.get("/test")
async def test():
    logger.info("test endpoint invoked")
    return "Hello world"


@app.websocket("/websocket")
async def websocket_endpoint(websocket: WebSocket):
    await websockets_manager.connect(websocket)
    try:
        while True:
            received_data = await websocket.receive_json()
            sensor_id = received_data.get('sensorId')
            sensor_data = await get_data_by_sensor_id(sensor_id)
            logger.info(sensor_data)
            await add_random_sensor_data(sensor_id)
            await websocket.send_json(dumps(sensor_data))
    except WebSocketDisconnect:
        await websockets_manager.disconnect(websocket)


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
