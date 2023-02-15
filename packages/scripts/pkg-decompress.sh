#!/bin/bash

cd ../compressed-R-packages

for f in *

do
  tar zxvf "$f" -C ../uncompressed-R-packages
done

