cd src
# train
CUDA_VISIBLE_DEVICES=1,2 python main.py tracking  --exp_id mot17_half_sch --dataset mot --dataset_version 17halftrain --ltrb_amodal   --same_aug_pre --num_workers 4 --load_model ../exp/tracking/crowdhuman/model_last.pth  --sch_track --hm_disturb 0.05  --no_pre_img --sch_feat_channel 16 --gpus 4,5 --not_set_cuda_env --batch_size 5 --master_batch_size 2 --wh_weight 0.1  --val_interval 1000 --mots_use_all_head 
# test
CUDA_VISIBLE_DEVICES=1 python test.py tracking --exp_id mot17_half_sch --dataset mot --dataset_version 17trainval --ltrb_amodal  --track_thresh 0.4  --pre_thresh 0.4 --nms_kernel 3 --sch_track --no_pre_img --sch_thresh 0.4 --track_K 3  --sch_feat_channel 16 --kmf_ind --sch_eval --max_age 1 --save_results
cd ..