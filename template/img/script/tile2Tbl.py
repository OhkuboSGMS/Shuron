import os
from image2bcd import configs

tiles = {t: t for t in os.listdir("tile")}
tbl = configs.read_table(1)
keys =list(tbl.keys())
keys.sort()
# print(keys)
# tbl ={tbl[k]:k for k in keys}
tbl_text = ["| id | name | sprite| \n"]
tbl_text.append("| --- | --- | --- | \n")
tbl_text.extend([f"| {v} |{k} | ![{k}](img/script/tile/{k}.png) | \n" for (k, v) in tbl.items()])
tbl_text = "".join(tbl_text)
print(tbl_text)
