# MODEL ZOO

- The experiments are run with PyTorch 1.0, CUDA 10.0, and CUDNN 7.5.
- Training and testing times are measured on our servers with V100s GPUs.
- The models can be downloaded directly from [Google drive](https://drive.google.com/drive/folders/1GQI_OPgDzQXdG8XW0vjs2_KS1eieccjD?usp=sharing).

### KITTI MOTS 

| Model                 |GPUs| Train time| Test time | Validation HOTA  | Test HOTA  | Download  |
|-----------------------|----|-----------|-----------|------------------|------------|-----------|
| [kitti_mots_sch_fulltrain](../experiments/kitti_mots_fulltrain.sh)         |    2 |    -    | 0.19s     |      -      |       53.1/67.1     | [model](https://drive.google.com/file/d/1gvBkDmCWjdJWHaFY50ZfrqhKGXQzi4MA/view?usp=sharing) |
| [kitti_mots_sch_half](../experiments/kitti_mots_half.sh)         |    1 |    -    | 0.19s      |         63.5/78.5     |      -     | [model](https://drive.google.com/file/d/1c0EYf5aa6xG7NAfN8f2WYN3SKMno6sAu/view?usp=sharing) |

#### Notes

- `*_half` corresponds to the half-half video train/ val split mentioned in the paper. 
- `*_fulltrain` corresponds to train on the full training set.
- HOTA are report in pedestrian/car.
-  all models are fine tune on [ctdet_coco_dla_2x.pth](https://drive.google.com/file/d/18Q3fzzAsha_3Qid6mn4jcIFPeOGUaj1d/edit) provided by [CenterNet](https://github.com/xingyizhou/CenterNet/blob/master/readme/MODEL_ZOO.md).

### MOT17

| Model                 | GPUs |Train time| Test time | Validation HOTA  | Test HOTA  | Download | 
|-----------------------|------|----------|-----------|------------------|------------|----------|
| [mot17_fulltrain_sch_ch](../experiments/mot17_fulltrain.sh)       |    2 |    -    | -     |          -       | 53.4 |  [model](https://drive.google.com/file/d/1tmpGfoCyDdFkl3R3UpYLyh5SR8spSLQ_/view?usp=sharing)     |
| [mot17_half_sch](../experiments/mot17_half.sh)            |    2 |    -    | -     |         -    |      -     | [model](https://drive.google.com/file/d/1FsL_apCEpx4LTKg8PSZkr1TRCy0tVw8s/view?usp=sharing) |
| [crowdhuman_sch](../experiments/crowdhuman.sh)            |    2 |    -   | -      |       -     |      -     |[model](https://drive.google.com/file/d/1YXXNaoLFYf5ovdXcs4xUw5ER6aP44l8z/view?usp=sharing) |

#### Notes

- `*_half` corresponds to the half-half video train/ val split mentioned in the paper. 
- `*_fulltrain` corresponds to train on the full training set and submit to leaderboard using public detections.
- `mot17_half`/ `mot17_fulltrain` are finetuned on the `crowdhuman` model, and `mot17_half_sc`/ `mot17_fulltrain_sc` are trained from ImageNet initialization.
- The crowdhuman model is trained on CrowdHuman dataset with similar setting as [CenterTrack](https://github.com/xingyizhou/CenterTrack).


