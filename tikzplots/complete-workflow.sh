#!/bin/bash

# 完整的 TikZ 工作流程脚本
# 1. 编译 TeX 为 PDF
# 2. 转换 PDF 为 PNG
# 3. 组织文件到不同目录
# 用法: ./complete-workflow.sh <tex-file-name-without-extension>

if [ $# -eq 0 ]; then
    echo "用法: $0 <tex-file-name-without-extension>"
    echo "例如: $0 polar-coords"
    exit 1
fi

# 创建目录结构
mkdir -p tex pdf png

TEX_FILE="tex/$1.tex"
PDF_FILE="pdf/$1.pdf"
PNG_FILE="png/$1.png"

echo "🚀 开始 TikZ 完整工作流程..."

# 步骤 1: 检查 TeX 文件是否存在
if [ ! -f "$TEX_FILE" ]; then
    echo "❌ 错误: 找不到文件 $TEX_FILE"
    exit 1
fi

# 步骤 2: 编译 TeX 为 PDF
echo "📝 步骤 1: 编译 TeX 为 PDF..."
cd tex
pdflatex -interaction=nonstopmode "$1.tex"

if [ $? -ne 0 ]; then
    echo "❌ TeX 编译失败"
    exit 1
fi

# 移动 PDF 到 pdf 目录
mv "$1.pdf" "../pdf/"
cd ..

echo "✅ PDF 编译成功: $PDF_FILE"

# 步骤 3: 转换 PDF 为 PNG
echo "🖼️  步骤 2: 转换 PDF 为 PNG..."
sips -s format png -Z 1200 "$PDF_FILE" --out "$PNG_FILE"

if [ $? -ne 0 ]; then
    echo "❌ PNG 转换失败"
    exit 1
fi
echo "✅ PNG 转换成功: $PNG_FILE"

# 步骤 4: 复制文件到项目根目录
# echo "📁 步骤 3: 复制文件到项目根目录..."
# cp "$PDF_FILE" ../
# cp "$PNG_FILE" ../
# echo "✅ 文件已复制到项目根目录"

# 步骤 5: 清理临时文件
echo "🧹 步骤 4: 清理临时文件..."
rm -f "tex/$1.aux" "tex/$1.log" "tex/$1.out"
echo "✅ 临时文件已清理"

echo ""
echo "🎉 工作流程完成！"
echo "📁 文件已组织到以下目录:"
echo "   📝 TeX: tex/$1.tex"
echo "   📄 PDF: $PDF_FILE"
echo "   🖼️  PNG: $PNG_FILE"
echo ""
echo "💡 在 Quarto 文档中使用:"
echo "   ![图片标题]($PNG_FILE){#fig-label}"
