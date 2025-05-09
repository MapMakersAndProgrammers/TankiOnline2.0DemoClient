from sys import argv
from os import listdir
from os.path import isdir
import subprocess

abcPath = argv[1]
swfPath = argv[2]

for path in listdir(abcPath):
    folder = path.split("/")[-1]
    path = f"{abcPath}/{path}"
    if not isdir(path): continue
    abcIndex = folder.split("-")[-1]
    abcFile = f"{path}/{folder}.main.abc"
    print(f"{path} {abcIndex} {abcFile}")
    subprocess.run(["abcreplace", swfPath, abcIndex, abcFile])