from json import load, dump
from sys import argv

mappingPath = argv[1]
mapping = {}
with open(mappingPath, "r") as file:
    mapping = load(file)

classMap = {}
for packageName in mapping:
    package = mapping[packageName]
    for className in package:
        clas = package[className]
        func = list(clas.values())
        if len(func) != 0:
            func = func[1]
            realName = func.split("/")[0]
            fakeName = f"{packageName}:{className}"
            classMap[fakeName] = realName

with open("packagemap.json", "w") as file:
    dump(classMap, file)