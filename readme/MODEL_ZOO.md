# MODEL ZOO
COMING SOON...

- The experiments are run with PyTorch 1.0, CUDA 10.0, and CUDNN 7.5.
- Training and testing times are measured on our servers with V100s GPUs.
- The models can be downloaded directly from [Google drive](https://drive.google.com/drive/folders/1GQI_OPgDzQXdG8XW0vjs2_KS1eieccjD?usp=sharing).

### KITTI MOTS 

| Model                 |GPUs| Train time| Test time | Validation MOTA  | Test MOTA  | Download  |
|-----------------------|----|-----------|-----------|------------------|------------|-----------|
| [kitti_mots_sch_fulltrain](../experiments/kitti_mots_fulltrain.sh)         |    2 |    2h    | 45ms      |         60.7     |      -     | [model](https://drive.google.com/open?id=12xnXeY-kW3otNjCoQtyJAayHFiQdTTAU) |
| [kitti_mots_sch_half](../experiments/kitti_mots_half.sh)         |    1 |    2h    | 45ms      |         60.7     |      -     | [model](https://drive.google.com/open?id=12xnXeY-kW3otNjCoQtyJAayHFiQdTTAU) |

#### Notes

- `*_half` corresponds to the half-half video train/ val split mentioned in the paper. 
- - `*_fulltrain` corresponds to train on the full training set.
-  all models are fine tune on [ctdet_coco_dla_2x.pth](https://drive.google.com/open?id=1pl_-ael8wERdUREEnaIfqOV_VF2bEVRT) provided by [CenterNet](https://github.com/xingyizhou/CenterNet/blob/master/readme/MODEL_ZOO.md).

### MOT17

| Model                 | GPUs |Train time| Test time | Valication MOTA  | Test MOTA  | Download | 
|-----------------------|------|----------|-----------|------------------|------------|----------|
| [mot17_fulltrain_sch_ch](../experiments/mot17_fulltrain.sh)       |    2 |    -    | -     |          -       |67.3 (Private Detection)|  [model](https://drive.google.com/open?id=1h_8Ts11rf0GQ4_n6FgmCeBuFcWrRjJfa)     |
| [mot17_half_sch](../experiments/mot17_half.sh)            |    2 |    -    | -     |         66.1     |      -     | [model](https://drive.google.com/open?id=1sf1bWJ1LutwQ_wp176nd2Y3HII9WeFf0) |
| [crowdhuman_sch](../experiments/crowdhuman.sh)            |    2 |    -   | -      |       -     |      -     |[model](https://drive.google.com/open?id=1rIVl-jSG6oiBdiJmCvIAUOeasT7YllRZ) |

#### Notes

- `*_half` corresponds to the half-half video train/ val split mentioned in the paper. 
- `*_fulltrain` corresponds to train on the full training set.
- `mot17_half`/ `mot17_fulltrain` are finetuned on the `crowdhuman` model, and `mot17_half_sc`/ `mot17_fulltrain_sc` are trained from ImageNet initialization.
- The crowdhuman model is trained on CrowdHuman dataset with similar setting as [CenterTrack](https://github.com/xingyizhou/CenterTrack).


