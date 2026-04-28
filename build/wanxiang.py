import os


def process_dict_yaml(filename, prefix="wanxiang_"):
    # 1. 检查文件是否存在
    if not os.path.exists(filename):
        print(f"找不到文件: {filename}")
        return

    new_filename = prefix + filename

    # 2. 修改文件内部的 name 字段
    with open(filename, "r", encoding="utf-8") as f:
        lines = f.readlines()

    with open(filename, "w", encoding="utf-8") as f:
        for line in lines:
            # 匹配以 'name:' 开头的行
            if line.startswith("name:"):
                current_name = line.split(":", 1)[1].strip()
                f.write(f"name: {prefix}{current_name}\n")
            else:
                f.write(line)

    # 3. 重命名文件
    os.rename(filename, new_filename)
    print(f"已完成: {filename} -> {new_filename} (内部 name 已更新)")


# 执行
if __name__ == "__main__":
    process_dict_yaml("genshin.dict.yaml")
    process_dict_yaml("honkai3rd.dict.yaml")
    process_dict_yaml("starrail.dict.yaml")
    process_dict_yaml("zenlesszonezero.dict.yaml")
