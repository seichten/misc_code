#!/usr/bin/python

#imports
import os, time

path_to_watch = "."

before = dict ([(f, None) for f in os.listdir (path_to_watch)])

while 1:
  time.sleep (10)
  after = dict ([(f, None) for f in os.listdir (path_to_watch)])
  added = [f for f in after if not f in before]
  removed = [f for f in before if not f in after]
  if added:
      for val in added:
          if val.endswith('.bam'):
              print str(datetime.datetime.now()) + "\t" + val + " is a bam file"
          elif val.endswith('.bed'):
              print str(datetime.datetime.now()) + "\t" + val + " is a bed file"
          elif val.endswith('.fastq'):
              print str(datetime.datetime.now()) + "\t" +  val + " is a fastq file"
          elif val.endswith('.fasta'):
              print str(datetime.datetime.now()) + "\t" + val + " is a fasta file"
          else:
              print val


  if removed: print "Removed: ", ", ".join (removed)
  before = after
