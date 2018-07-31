for i in *.cr2; do dcraw -c -w -h $i | cjpeg -quality 80 > $i.jpg; done

