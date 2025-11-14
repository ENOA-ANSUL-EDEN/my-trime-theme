#!/bin/sh

if [ $# -lt 1 ]; then
    echo "用法: $0 输入字体.ttf"
    exit 1
fi

INPUT_FONT="$1"
OUTPUT_FONT="EmptyFont.ttf"

if [ ! -f "$INPUT_FONT" ]; then
    echo "错误：找不到字体文件：$INPUT_FONT"
    exit 1
fi

echo "正在生成 EmptyFont.ttf ……"

pyftsubset "$INPUT_FONT" \
    --gids=0,1 \
    --glyph-names \
    --notdef-glyph \
    --notdef-outline \
    --layout-features="*" \
    --unicodes="" \
    --no-hinting \
    --passthrough-tables="OS/2,head,hhea,vhea,post,name,STAT" \
    --output-file="$OUTPUT_FONT"

if [ $? -eq 0 ]; then
    echo "完成：已生成 $OUTPUT_FONT"
else
    echo "失败：生成 EmptyFont.ttf 时发生错误。"
    exit 1
fi