cd src
# train
CUDA_VISIBLE_DEVICES=3,4  python main.py tracking --exp_id crowdhuman_sch --dataset crowdhuman --ltrb_amodal --pre_hm --shift 0.05 --scale 0.05 --hm_disturb 0.05  --num_epochs 140 --lr_step 90,120 --save_point 60,90 --gpus 3,4  --not_set_cuda_env  --lr 2.5e-4 --wh_weight 0.1  --val_interval 1000 --sch_track --no_pre_img --num_workers 8 --batch_size 8 --master_batch_size 4
cd ..