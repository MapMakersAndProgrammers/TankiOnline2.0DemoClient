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
        clas = list(package[className].values())
        if len(clas) < 2: continue
        chain = f"{packageName}:{className}"
        functionName = clas[1]

        realChain = ""
        if len(functionName.split(":")) == 1:
            realClassName = functionName.split(":")[-1].split("/")[0]
            realChain = f"{realClassName}"   
        else:
            realPackageName = functionName.split(":")[0]
            realClassName = functionName.split(":")[-1].split("/")[0]
            realChain = f"{realPackageName}:{realClassName}"

        classMap[chain] = realChain

with open("packagemap.json", "w") as f:
    dump(classMap, f)