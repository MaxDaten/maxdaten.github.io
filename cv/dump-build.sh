pandoc -H ./tex/base.tex -o ./curriculum-vitae.pdf ./curriculum-vitae.md
pandoc -s -t html5 -H ./css/cv.css -o ./curriculum-vitae.html ./curriculum-vitae.md
pandoc -s -t docx -o ./curriculum-vitae.docx ./curriculum-vitae.md
