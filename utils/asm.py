import subprocess
from glob import glob
from sys import argv

path = argv[1]
paths = glob(f"{path}/*/*.main.asasm")
for path in paths:
    subprocess.run(["rabcasm", path])