# Based on example from:
# http://rforbiochemists.blogspot.com/2016/05/counting-and-identifying-stained-cells.html

library(EBImage)

args = commandArgs(trailingOnly = TRUE)

c2 = readImage(args[1])

c2.b = c2*2

c2.b.blur = gblur(c2.b, sigma = 5)

c2.b.blur.thres = c2.b.blur > otsu(c2.b.blur)

c2.b.blur.thres.cnt = bwlabel(c2.b.blur.thres)

nucNo = max(bwlabel(c2.b.blur.thres))
print(paste(args[1],nucNo), sep = ',')

fileConn = file("out.csv")
writeLines(paste(args[1], nucNo, sep = ','), fileConn)
close(fileConn)
