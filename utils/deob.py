from json import load
from sys import argv
from glob import glob
import re
from multiprocessing import Pool

mappingPath = argv[1]
detailMappingPath = argv[2]
abcPath = argv[3]

mapping = {}
with open(mappingPath, "r") as file:
    mapping = load(file)

detailMapping = {}
with open(detailMappingPath, "r") as file:
    detailMapping = load(file)

paths = glob(f"{abcPath}/**/**/*.asasm")

def deobfuscateFile(path):
    print(path)
    with open(path, "r+") as reader:
        className = path.split("/")[-1]
        className = className.split(".")[0]
        packageName = path.split("/")[-2]

        content_lines = reader.readlines()
 
        new_lines = []
 
        for index, line in enumerate(content_lines):
            if (
                not line.strip().startswith("#include")
                and not line.strip().startswith("pushstring")
                and index != 0
            ):
                for entry in mapping:
                    fakePackageName = entry.split(":")[0]
                    fakeClassName = entry.split(":")[1]
                    if fakePackageName in line:
                        realName = mapping[f"{fakePackageName}:{fakeClassName}"].split(":")[0]
                        line = re.sub(
                            rf"(^|[\"\/:]){fakePackageName}([\"\/:]|$)", rf"\1{realName}\2", line
                        )
                    if fakeClassName in line:
                        realName = mapping[f"{fakePackageName}:{fakeClassName}"].split(":")[1]
                        line = re.sub(
                            rf"(^|[\"\/:]){fakeClassName}([\"\/:]|$)", rf"\1{realName}\2", line
                        )
                #classs = detailMapping[packageName][className]
                for package in detailMapping:
                    for classs in detailMapping[package]:
                        classs = detailMapping[package][classs]
                        for member in classs:
                            realMember = classs[member]
                            if realMember == None: continue

                            memberChain = member.split("/")
                            memberName = memberChain[-1]
                            if memberName == "setter" or memberName == "getter":
                                memberName = memberChain[-2]
                            elif memberName == "init" or memberName == "final" or memberName.rstrip() == "each" or memberName == "package":
                                continue
                            if ":" in memberName:
                                memberName = memberName.split(":")[-1]
                            
                            realMemberChain = realMember.split("/")
                            realMemberName = realMemberChain[-1]
                            if realMemberName == "set" or realMemberName == "get":
                                realMemberName = realMemberChain[-2]
                            if ":" in realMemberName:
                                realMemberName = realMemberName.split(":")[-1]
                            if realMemberName == memberName:
                                continue

                            if memberName in line:
                                line = re.sub(
                                    rf"(^|[\"\/:]){memberName}([\"\/:]|$)", rf"\1{realMemberName}\2", line
                                )

            new_lines.append(line)
 
        # Reset the file to the beginning and truncate the content
        reader.seek(0)
        reader.truncate()
 
        # Then write the new contents to the file
        reader.writelines(new_lines)

# for path in paths:
#     deobfuscateFile(path)
pool = Pool(12)
pool.map(deobfuscateFile, paths)