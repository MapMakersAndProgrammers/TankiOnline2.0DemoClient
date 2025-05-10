from sys import argv
from glob import glob

from json import dump

path = argv[1]
paths = glob(f"{path}/**/*.class.asasm", recursive=True)

names = {}
for path in paths:
    name = None
    with open(path, "r") as file:
        className = path.split("/")[-1]
        className = className.split(".class.asasm")[0]
        packageName = path.split("/")[-2]

        if not packageName in names:
            names[packageName] = {}
        if not className in names[packageName]:
            names[packageName][className] = {}

        for line in file:
            line = line.strip()
            if line.startswith("name"):
                line = line.split("name \"")
                line = line[1][:-1]
                name = line
            elif line.startswith("refid"):
                line = line.split("refid \"")
                line = line[1][:-1]

                if name == None:
                    names[packageName][className][line] = None
                elif ".as$" not in name:
                    names[packageName][className][line] = name

with open("mapping.json", "w") as file:
    dump(names, file)