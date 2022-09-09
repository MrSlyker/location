#!system/usr/bin/python
import os
import sys,time

def ketik(teks):
 for i in teks + "\n":
   sys.stdout.write(i)
   sys.stdout.flush()
   time.sleep(0.1)

ketik('Disclaimer!')
ketik('These tools are not to be misused or traded')
