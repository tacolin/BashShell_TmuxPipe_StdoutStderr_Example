#!/usr/bin/env python

import sys, time, os

for i in xrange(10):
  sys.stdout.write("[info] Hello {0}\n".format(i))
  sys.stdout.write("[v1] Hello {0}\n".format(i))
  sys.stdout.flush()

  sys.stderr.write("[warn] Hello {0}\n".format(i))
  sys.stderr.write("[error] Hello {0}\n".format(i))
  sys.stderr.flush()

  time.sleep(1)