rem This batch file uses Gaston's compiler compiling fortran source into a 1802 binary file
erase  %1.bin
d:\fort02\fortran.exe -l -L -c  -b -ram=0000-7FFF -rom=8000-FFFF -elfos %1.fort.txt


 