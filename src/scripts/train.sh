CUDA_VISIBLE_DEVICES=2 python main.py tracking,seg --exp_id mots_hts_mtl_ignore --dataset kitti_mots --dataset_version train_part --pre_hm --hm_disturb 0.05 --lost_disturb 0.2 --fp_disturb 0.1 --gpus 0 --batch_size 10 --num_epoch 140 --lr_step 80,100 --same_aug_pre --num_workers 4  --wh_weight 0 --off_weight 0 --mtl
CUDA_VISIBLE_DEVICES=2 python main.py tracking,seg --exp_id mots_cnp_pt17 --dataset kitti_mots --dataset_version train_part --pre_hm --hm_disturb 0.05 --lost_disturb 0.2 --fp_disturb 0.1 --gpus 0 --batch_size 10 --num_epoch 60 --lr_step 20,40 --same_aug_pre --num_workers 4  --wh_weight 0 --off_weight 0 --mtl --load_model ../exp/tracking,seg/mots_pt_mot17/model_best.pth --paste_up
<<<<<<< Updated upstream
=======
CUDA_VISIBLE_DEVICES=0 python main.py tracking,seg --exp_id mots_dacnp_pt_coco_v1.1 --dataset kitti_mots --dataset_version train_part --pre_hm --hm_disturb 0.05 --lost_disturb 0.2 --fp_disturb 0.1 --gpus 0 --batch_size 8 --num_epoch 140 --lr_step 80,100 --same_aug_pre --num_workers 4  --wh_weight 0 --off_weight 0 --mtl --load_model ../models/coco_tracking.pth --copy_and_paste 0.4
>>>>>>> Stashed changes
