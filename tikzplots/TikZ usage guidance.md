# TikZ usage guidance

Create separate `.tex` files for each TikZ plot in the `tex/` directory, and call `complete-workflow.sh` to compile the TikZ file to PDF and then convert it to PNG.

The script automatically organizes files into separate directories:
- `tex/` - contains your `.tex` source files
- `pdf/` - contains compiled `.pdf` files
- `png/` - contains converted `.png` files

Add the PNG file to the `.qmd` files. The CLI output of `complete-workflow.sh` will contain the filename of PNG files.

```
cd tikzplots
./complete-workflow.sh tikz-file // no ".tex" filename extension
```

**Note**: Make sure your `.tex` files are placed in the `tex/` directory before running the script.