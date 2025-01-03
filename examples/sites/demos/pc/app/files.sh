#!/bin/bash

echo "start"

# 检查参数个数
if [ $# -ne 2 ]; then
  echo "用法: $0 <起始文件夹名> <结束文件夹名>"
  exit 1
fi

start_folder="$1"
end_folder="$2"

# 获取当前目录下所有文件夹
folders=($(find . -maxdepth 1 -type d -print | sort))

# 查找起始和结束文件夹的索引
start_index=-1
end_index=-1
for i in "${!folders[@]}"; do
  folder="${folders[$i]}"
    folder="${folder##./}" # Remove "./" prefix
  if [[ "$folder" == "$start_folder" ]]; then
    start_index="$i"
  elif [[ "$folder" == "$end_folder" ]]; then
    end_index="$i"
  fi
done

# 检查起始和结束文件夹是否存在
if [ "$start_index" -eq -1 ]; then
  echo "起始文件夹 '$start_folder' 未找到"
  exit 1
fi

if [ "$end_index" -eq -1 ]; then
  echo "结束文件夹 '$end_folder' 未找到"
  exit 1
fi

# 检查起始文件夹是否在结束文件夹之前
if [ "$start_index" -gt "$end_index" ]; then # 修改了这里，允许相等的情况，但提示起始文件夹必须在结束文件夹之前
  echo "起始文件夹必须在结束文件夹或与其相同"
  exit 1
elif [ "$start_index" -eq "$end_index" ]; then
    echo "$start_folder" # 如果起始和结束文件夹相同，则只输出起始文件夹
    exit 0
fi

# 提取中间的文件夹（包含起始和结束）并用逗号拼接
result=""
for i in $(seq "$start_index" "$end_index"); do # 修改了这里，包含起始和结束索引
    folder="${folders[$i]}"
    folder="${folder##./}" # Remove "./" prefix
  if [ -n "$result" ]; then
    result="$result,$folder"
  else
    result="$folder"
  fi
done

echo "$result"