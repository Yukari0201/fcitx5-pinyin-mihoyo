#!/bin/bash

# 安装与升级 mw2fcitx
echo "--- 正在更新 mw2fcitx ---"
pipx install mw2fcitx[opencc] 2>/dev/null || pipx upgrade mw2fcitx[opencc]

DICTS=(
    "utils/honkai3rd_dict.py"
    "utils/starrail_dict.py"
    "utils/zenlesszonezero_dict.py"
    "utils/genshin_dict.py"
)

# 循环执行字典转换
echo "--- 开始转换词库 ---"
for dict_path in "${DICTS[@]}"; do
    if [ -f "$dict_path" ]; then
        echo "处理中: $dict_path"
        mw2fcitx -c "$dict_path" --log-level ERROR || echo "错误: $dict_path 转换失败，跳过。"
    else
        echo "警告: 未找到文件 $dict_path，跳过。"
    fi
done

echo "--- 移动 dict/titles 到 build/ "
mv {*.dict,*.dict.yaml,*_titles.txt} build/

echo "--- 复制 build/*.dict.yaml 到 build/wanxiang/"
mkdir -p build/wanxiang
cp -p build/*.dict.yaml build/wanxiang/

echo "--- 所有任务已完成 ---"
