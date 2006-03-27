#!/bin/bash

# language identification using shift delta cepstral coefficients and pretrained DNN 

# variables setting

work_path=/home/wzj/LID
current_path=$work_path/testscript
versionum=version1.0
mfcc_type=a
#mfcc_type=b
train_mlp=$work_path/gen/$versionum/$mfcc_type/mlp
test_scp=$work_path/scp/$versionum/test/${mfcc_type}
out_dir=$current_path/$versionum/$mfcc_type

rm -rf $out_dir
mkdir -p $out_dir


# test and calculate the accuracy

nnet-forward --feature-transform=$train_mlp/final.feature_transform $train_mlp/final.nnet scp:$test_scp/test.scp ark,t:$out_dir/test.ark

perl $current_path/scripts/cal_utt.pl $out_dir/test.ark 3 > $out_dir/result

bash $current_path/scripts/cal_acc.sh $out_dir $out_dir/result
