import subprocess
from glob import glob
from sys import argv

path = argv[1]
paths = glob(f"{path}/*.abc")
for path in paths:
    subprocess.run(["rabcdasm", path])