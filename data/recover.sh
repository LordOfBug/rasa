#!/bin/bash
cat total_word_feature_extractor.dat.gza* > total_word_feature_extractor.dat.gz
gzip -d total_word_feature_extractor.dat.gz
