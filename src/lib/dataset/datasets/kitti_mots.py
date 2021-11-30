from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import pycocotools.coco as coco
import numpy as np
import torch
import json
import cv2
import os
import math

from ..generic_dataset import GenericDataset
from utils.ddd_utils import compute_box_3d, project_to_image

class KITTIMOTS(GenericDataset):
  num_categories = 2
  default_resolution = [384, 1280]
  class_name = ['Car', 'Pedestrian']
  # coco2kitti = {1: 2, 3: 1}
  # negative id is for "not as negative sample for abs(id)".
  # 0 for ignore losses for all categories in the bounding box region
  # ['Car', Pedestrian']
  cat_ids = {1:1, 2:2, 10:0}
  max_objs = 50
  def __init__(self, opt, split):
    data_dir = os.path.join(opt.data_dir, 'kitti_mots')
    image_split = 'train' if opt.dataset_version != 'test' else 'test' #'test'

    if opt.dataset_version in ['train', 'test']:
      ann_file = 'tracking_{}.json'.format('train' if split == 'train' else \
        'test')
    elif opt.dataset_version == 'train_part' and 'train' in split:
      ann_file = 'tracking_{}.json'.format('train_part')
    elif opt.dataset_version == 'val_part' or 'val' in split:
      ann_file = 'tracking_{}.json'.format('val_part')


    img_dir = os.path.join(
      data_dir, 'data_tracking_image_2', '{}ing'.format(image_split), 'image_02')
    #ann_file_ = split_ if opt.dataset_version == '' else opt.dataset_version
    ann_path = os.path.join(data_dir, 'annotations', ann_file)
    self.images = None
    super(KITTIMOTS, self).__init__(opt, split, ann_path, img_dir)
    self.alpha_in_degree = False
    self.num_samples = len(self.images)

    print('Loaded {} {} samples'.format(split, self.num_samples))


  def __len__(self):
    return self.num_samples

  def _to_float(self, x):
    return float("{:.2f}".format(x))


  def save_results(self, results, save_dir):
    results_dir = save_dir
    if not os.path.exists(results_dir):
      os.makedirs(results_dir)

    for video in self.coco.dataset['videos']:
      video_id = video['id']
      file_name = video['file_name']
      out_path = os.path.join(results_dir, '{}.txt'.format(file_name))
      f = open(out_path, 'w')
      images = self.video_to_images[video_id]
      
      for image_info in images:
        if not (image_info['id'] in results):
          continue
        result = results[image_info['id']]
        frame_id = image_info['frame_id']
        for obj in result:
          track_id = str(obj['class']) + "{0:03}".format(obj['tracking_id'])
          class_id = obj['class'] 
          img_height = obj['seg']['size'][0]
          img_width =  obj['seg']['size'][1]
          seg_rle = obj['seg']['counts']
          line = f"{str(int(frame_id)-1)} {track_id} {class_id} {img_height} {img_width} {seg_rle}\n"
          f.write(line)

      f.close()
      print(f'Save to {out_path}')
        

  def run_eval(self, results, save_dir):
    self.save_results(results, save_dir)
    # os.system('python tools/eval_kitti_track/evaluate_tracking.py ' + \
    #           '{}/results_kitti_mots/ {}'.format(
    #             save_dir, self.opt.dataset_version))
    
