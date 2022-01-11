cd src
# train
CUDA_VISIBLE_DEVICES=0,1 python main.py tracking,seg --exp_id mots_sch_fulltrain --dataset kitti_mots --dataset_version train  --num_epoch 140 --lr_step 80,110 --same_aug_pre --num_workers 4  --wh_weight 0.1 --load_model ../models/ctdet_coco_dla_2x.pth --sch_track --hm_disturb 0.05  --no_pre_img --sch_feat_channel 16 --gpus 0,1 --not_set_cuda_env --batch_size 9 --master_batch_size 4 --val_interval 1000

# test
python test.py tracking,seg --exp_id mots_sch_fulltrain --dataset kitti_mots --dataset_version test  --pre_thresh 0.4 --nms_kernel 5 --sch_track --no_pre_img --sch_thresh 0.4 --track_K 3  --sch_feat_channel 16 --kmf_ind --sch_eval  --resume  --save_results --max_age 9 --new_thresh 0.4 --out_thresh  0.4
