from loguru import logger
from bson.json_util import dumps
from fastapi.middleware.cors import CORSMiddleware
from fastapi import Depends, FastAPI, WebSocket, WebSocketDisconnect

from modules.websockets import ConnectionManager


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
            data = await websocket.receive_json()
            logger.info(data)
            await websocket.send_json(dumps(data))
    except WebSocketDisconnect:
        await websockets_manager.disconnect(websocket)


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
