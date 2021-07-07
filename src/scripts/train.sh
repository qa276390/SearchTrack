CUDA_VISIBLE_DEVICES=1 python main.py tracking,seg --exp_id mots_seqmap --dataset kitti_mots --dataset_version train --pre_hm --hm_disturb 0.05 --lost_disturb 0.2 --fp_disturb 0.1 --gpus 0 --batch_size 18 --num_epochs 140  --lr_step 80,100
CUDA_VISIBLE_DEVICES=1 python main.py tracking,seg --exp_id mots_scsw1_dncsm --dataset kitti_mots --dataset_version train --pre_hm --hm_disturb 0.05 --lost_disturb 0.2 --fp_disturb 0.1 --gpus 0 --batch_size 20 --num_epoch 140 --lr_step 80,100 --same_aug_pre --seg_weight 1
CUDA_VISIBLE_DEVICES=2 python main.py tracking,seg --exp_id mots_hts_mtl_ignore --dataset kitti_mots --dataset_version train --pre_hm --hm_disturb 0.05 --lost_disturb 0.2 --fp_disturb 0.1 --gpus 0 --batch_size 10 --num_epoch 140 --lr_step 80,100 --same_aug_pre --num_workers 4  --wh_weight 0 --off_weight 0 --mtl
<<<<<<< HEAD
CUDA_VISIBLE_DEVICES=0 python main.py tracking,seg --exp_id mots_pt_mot17 --dataset kitti_mots --dataset_version train --pre_hm --hm_disturb 0.05 --lost_disturb 0.2 --fp_disturb 0.1 --gpus 0 --batch_size 8 --num_epoch 140 --lr_step 70,90 --same_aug_pre --num_workers 4  --wh_weight 0 --off_weight 0 --mtl --load_model ../models/mot17_half.pth
=======
CUDA_VISIBLE_DEVICES=2 python main.py tracking,seg --exp_id mots_cnp_pt17 --dataset kitti_mots --dataset_version train --pre_hm --hm_disturb 0.05 --lost_disturb 0.2 --fp_disturb 0.1 --gpus 0 --batch_size 10 --num_epoch 60 --lr_step 20,40 --same_aug_pre --num_workers 4  --wh_weight 0 --off_weight 0 --mtl --load_model ../exp/tracking,seg/mots_pt_mot17/model_best.pth --copy_and_paste
>>>>>>> 05c65e1e906b09d60ec2a7b225b4813c9787ef19
