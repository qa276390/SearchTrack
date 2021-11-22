CUDA_VISIBLE_DEVICES=2 python eval.py tracking,seg --inf_dir ../data/kitti_mots/data_tracking_image_2/training/image_02/ --inf_seqmap ../experiments/val.seqmap --exp_id mots_cnp_pretrain_ignore --save_results --resume --K 50 --pre_hm --track_thresh 0.4 --pre_thresh 0.5 --paste_up --max_age 5 --dataset kitti_mots
CUDA_VISIBLE_DEVICES=0 python eval.py tracking,seg --inf_dir ../data/kitti_mots/data_tracking_image_2/training/image_02/ --inf_seqmap ../experiments/val.seqmap --exp_id mots_cnp_pt17 --save_results --resume --K 50 --pre_hm --track_thresh 0.55 --dir_suffix .55  --pre_thresh 0.55 --paste_up --max_age 7 --dataset kitti_mots --nms_kernel 5
CUDA_VISIBLE_DEVICES=0 python eval.py tracking,seg --inf_dir ../data/kitti_mots/data_tracking_image_2/training/image_02/ --inf_seqmap ../experiments/val.seqmap --exp_id mots_dacnp_v2 --save_results --resume --K 50 --pre_hm --track_thresh 0.4,0.5  --pre_thresh 0.5 --dataset kitti_mots --nms_kernel 5  --dir_suffix cnp-.4.5-age75 --paste_up --max_age 7,5
CUDA_VISIBLE_DEVICES=0 python eval.py tracking,seg --inf_dir ../data/kitti_mots/data_tracking_image_2/training/image_02/ --inf_seqmap ../experiments/val.seqmap --exp_id mots_dacnp_v2 --save_results --resume --K 50 --pre_hm --track_thresh 0.4,0.5  --pre_thresh 0.5 --dataset kitti_mots --nms_kernel 5  --dir_suffix cnp-.4.5-age73 --paste_up --max_age 7,3
CUDA_VISIBLE_DEVICES=0 python eval.py tracking,seg --inf_dir ../data/kitti_mots/data_tracking_image_2/training/image_02/ --inf_seqmap ../experiments/val.seqmap --exp_id mots_mtpimg_v0.3.1_DCN --save_results --resume --K 50 --pre_hm --track_thresh 0.4  --pre_thresh 0.5 --dataset kitti_mots --nms_kernel 5  --num_pre_imgs_input 2 --head_DCN --paste_up --max_age 7 --dir_suffix cnp
CUDA_VISIBLE_DEVICES=1 python eval.py tracking,seg --inf_dir ../data/kitti_mots/data_tracking_image_2/training/image_02/ --inf_seqmap ../experiments/val.seqmap --exp_id mots_sch_v0.2 --save_results --resume --K 50 --track_thresh 0.4  --pre_thresh 0.4 --dataset kitti_mots --nms_kernel 5 --sch_track --no_pre_img --sch_thresh 0.4 --dir_suffix 3-gdy --track_K 3  --debug 4 --sch_feat_channel 16
time CUDA_VISIBLE_DEVICES=1 python eval.py tracking,seg --inf_dir ../data/kitti_mots/data_tracking_image_2/training/image_02/ --inf_seqmap ../experiments/val.seqmap --exp_id mots_sch_v0.2 --save_results --resume --K 50 --track_thresh 0.4  --pre_thresh 0.4 --dataset kitti_mots --nms_kernel 5 --sch_track --no_pre_img --sch_thresh 0.4 --track_K 3  --sch_feat_channel 16 --kmf_ind --sch_eval --max_age 9 --dir_suffix age9-kmfind
CUDA_VISIBLE_DEVICES=1 python test.py tracking --exp_id mot17_fulltrain_sch_ch --dataset mot --dataset_version 17test  --ltrb_amodal    --pre_thresh 0.4 --nms_kernel 3 --sch_track --no_pre_img --sch_thresh 0.4 --track_K 3  --sch_feat_channel 16 --kmf_ind --sch_eval --max_age 9 --load_model ../exp/tracking/mot17_fulltrain_sch_ch/model_last.pth  --save_results --dir_suffix age30-pub --max_age 30 --new_thresh 0.4 --out_thresh  0.1 --public_det --load_results ../data/mot17/results/test_det.json --no_enlarge --trainval
