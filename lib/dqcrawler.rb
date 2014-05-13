@e  = Entity.find_by("name"=>/bubble/i)
@a = Entity.find(@e["article"])
@source = @a["url"]
@b = Entity.find(@a["extraction_tech"])
@c = eval(@b["code"])
@d = Entity.find(@b["presentation"])
@out = eval(@d["code"])