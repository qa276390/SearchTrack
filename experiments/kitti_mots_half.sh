cd src
# train
python main.py tracking,seg --exp_id mots_sch --dataset kitti_mots --dataset_version train_part --gpus 0  --num_epoch 140 --lr_step 80,110 --same_aug_pre --num_workers 4  --wh_weight 0.1  --batch_size 12 --load_model ../models/ctdet_coco_dla_2x.pth --sch_track --hm_disturb 0.05  --no_pre_img --sch_feat_channel 16
# eval
python test.py tracking,seg --exp_id mots_sch --dataset kitti_mots --dataset_version val_part   --pre_thresh 0.4 --nms_kernel 5 --sch_track --no_pre_img --sch_thresh 0.4 --track_K 3  --sch_feat_channel 16 --kmf_ind --sch_eval  --resume  --save_results --max_age 9 --new_thresh 0.4 --out_thresh  0.4

