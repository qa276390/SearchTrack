from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import pickle
import json
import numpy as np
import os
import cv2
TRAIN_PART_SEQ = [0, 1, 3, 4, 5, 9, 11, 12, 15, 17, 19, 20]
VAL_PART_SEQ = [2, 6, 7, 8, 10, 13, 14, 16, 18]
DATA_PATH = '../../data/kitti_mots/'
SPLITS = ['val_part', 'train_part', 'test', 'train']
VIDEO_SETS = {'train_part': TRAIN_PART_SEQ , 'test': range(29), 'val_part': VAL_PART_SEQ, 'train': range(21)}
CREATE_HALF_LABEL = False
DEBUG = False

'''
# Class ID
car 1
pedestrian 2

# Format
time_frame id class_id img_height img_width rle

An example line from a txt file:

52 1005 1 375 1242 WSV:2d;1O10000O10000O1O100O100O1O100O1000000000000000O100O102N5K00O1O1N2O110OO2O001O1NTga3

Which means

time frame 52 
object id 1005 (meaning class id is 1, i.e. car and instance id is 5) 
class id 1 
image height 375 
image width 1242 
rle WSV:2d;1O10000O10000O1O100O100O1O100O1000000000000000O100O...1O1N 


'''


def _bbox_to_coco_bbox(bbox):
  return [(bbox[0]), (bbox[1]),
          (bbox[2] - bbox[0]), (bbox[3] - bbox[1])]

cats = ['Pedestrian', 'Car', 'DontCare']


cat_ids = {'Pedestrian': 2, 'Car': 1, 'DontCare':10}

cat_info = []
for i, cat in enumerate(cats):
  cat_info.append({'name': cat, 'id': i + 1})

if __name__ == '__main__':
  for split in SPLITS:
    #ann_dir = DATA_PATH + '/instances_txt/'
    ret = {'images': [], 'annotations': [], "categories": cat_info,
           'videos': []}
    num_images = 0
    for i in VIDEO_SETS[split]:
      image_id_base = num_images
      video_name = '{:04d}'.format(i)
      ret['videos'].append({'id': i + 1, 'file_name': video_name})
      ann_dir = 'train'  if not ('test' in split) else split
      video_path = DATA_PATH + \
        '/data_tracking_image_2/{}ing/image_02/{}'.format(ann_dir, video_name)
      image_files = sorted(os.listdir(video_path))
      num_images_video = len(image_files)
      if CREATE_HALF_LABEL and 'half' in split:
        image_range = [0, num_images_video // 2 - 1] if split == 'train_half' else \
          [num_images_video // 2, num_images_video - 1]
      else:
        image_range = [0, num_images_video - 1]
      print('num_frames', video_name, image_range[1] - image_range[0] + 1)
      for j, image_name in enumerate(image_files):
        if (j < image_range[0] or j > image_range[1]):
          continue
        num_images += 1
        image_info = {'file_name': '{}/{:06d}.png'.format(video_name, j),
                      'id': num_images,
                      'video_id': i + 1,
                      'frame_id': j + 1 - image_range[0]}
        ret['images'].append(image_info)

      if split == 'test':
        continue
      # 0 -1 DontCare -1 -1 -10.000000 219.310000 188.490000 245.500000 218.560000 -1000.000000 -1000.000000 -1000.000000 -10.000000 -1.000000 -1.000000 -1.000000
      ann_path = DATA_PATH + 'instances_txt/{}.txt'.format(video_name)
      anns = open(ann_path, 'r')
      
      if CREATE_HALF_LABEL and 'half' in split:
        label_out_folder = DATA_PATH + 'label_02_{}/'.format(split)
        label_out_path = label_out_folder + '{}.txt'.format(video_name)
        if not os.path.exists(label_out_folder):
          os.mkdir(label_out_folder)
        label_out_file = open(label_out_path, 'w')
      
      for ann_ind, txt in enumerate(anns):
        tmp = txt[:-1].split(' ')
        frame_id = int(tmp[0])
        track_id = int(tmp[1])
        cat_id = int(tmp[2])
        img_height = int(tmp[3])
        img_width = int(tmp[4])
        seg_mask = str(tmp[5])
       
        ann = {'image_id': frame_id + 1 - image_range[0] + image_id_base,
               'id': int(len(ret['annotations']) + 1),
               'category_id': cat_id,
               'segmentation': {"counts": seg_mask, "size": (img_height, img_width)}, 
               'track_id': track_id + 1}
        if CREATE_HALF_LABEL and 'half' in split:
          if (frame_id < image_range[0] or frame_id > image_range[1]):
            continue
          out_frame_id = frame_id - image_range[0]
          label_out_file.write('{} {}'.format(
            out_frame_id, txt[txt.find(' ') + 1:]))
        
        ret['annotations'].append(ann)
      
    print("# images: ", len(ret['images']))
    print("# annotations: ", len(ret['annotations']))
    out_dir = '{}/annotations/'.format(DATA_PATH)
    if not os.path.exists(out_dir):
      os.mkdir(out_dir)
    out_path = '{}/annotations/tracking_{}.json'.format(
      DATA_PATH, split)
    json.dump(ret, open(out_path, 'w'))
