from fastapi import FastAPI
import subprocess

app = FastAPI()

@app.get("/")
def root():
    return {"status": "ok", "message": "Pod2 environment is running"}

@app.get("/ffmpeg")
def ffmpeg_version():
    version = subprocess.check_output(["ffmpeg", "-version"]).decode().split("\n")[0]
    return {"ffmpeg_version": version}
