#!/bin/bash
# Adapted from https://github.com/facebookresearch/MIXER/blob/master/prepareData.sh

SCRIPTS=mosesdecoder/scripts
TOKENIZER=$SCRIPTS/tokenizer/tokenizer.perl
CLEAN=$SCRIPTS/training/clean-corpus-n.perl
NORM_PUNC=$SCRIPTS/tokenizer/normalize-punctuation.perl
REM_NON_PRINT_CHAR=$SCRIPTS/tokenizer/remove-non-printing-char.perl
BPEROOT=subword-nmt

src=fr
tgt=en
lang=fr-en
BPE_CODE=bl_en_fr/code
prep=fr_en_s16k/mtnt
tmp=$prep/tmp
orig=orig/mtnt/fr-en

mkdir $prep
mkdir $tmp

for L in $src $tgt; do
    for f in train.$L valid.$L test.$L; do
        echo "tokenizing ${f}..."
        cat $orig/$f | perl $TOKENIZER -threads 8 -a -l $L > $tmp/$f
        echo "apply_bpe.py to ${f}..."
        python $BPEROOT/apply_bpe.py -c $BPE_CODE.$L < $tmp/$f > $tmp/bpe.$f
    done
done

perl $CLEAN -ratio 1.5 $tmp/bpe.train $src $tgt $prep/train 1 250
perl $CLEAN -ratio 1.5 $tmp/bpe.valid $src $tgt $prep/valid 1 250

for L in $src $tgt; do
    cp $tmp/bpe.test.$L $prep/test.$L
done
