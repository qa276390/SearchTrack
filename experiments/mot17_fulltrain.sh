cd src
# train
CUDA_VISIBLE_DEVICES=1,2 python main.py tracking  --exp_id mot17_fulltrain_sch_ch --dataset mot --dataset_version 17trainval --ltrb_amodal   --same_aug_pre --num_workers 4 --load_model ../exp/tracking/crowdhuman_sch/model_last.pth  --sch_track --hm_disturb 0.05  --no_pre_img --sch_feat_channel 16 --gpus 4,5 --not_set_cuda_env --batch_size 5 --master_batch_size 2 --wh_weight 0.1  --val_interval 1000 --mots_use_all_head 
# test with public detection
python test.py tracking --exp_id mot17_fulltrain_sch_ch --dataset mot --dataset_version 17test  --ltrb_amodal    --pre_thresh 0.4 --nms_kernel 3 --sch_track --no_pre_img --sch_thresh 0.4 --track_K 3  --sch_feat_channel 16 --kmf_ind --sch_eval --max_age 9 --resume  --save_results --dir_suffix age30-pub --max_age 30 --new_thresh 0.4 --out_thresh  0.3 --public_det --load_results ../data/mot17/results/test_det.json --no_enlarge --trainval

cd ..