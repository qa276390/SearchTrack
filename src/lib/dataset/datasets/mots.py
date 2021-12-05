from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import pycocotools.coco as coco
from pycocotools.cocoeval import COCOeval
import numpy as np
import json
import os
from collections import defaultdict
from ..generic_dataset import GenericDataset
from shutil import copyfile
"""
pedestrian 2
ignore 10
"""

class MOTS(GenericDataset):
  num_categories = 1
  default_resolution = [544, 960]
  class_name = ['']
  max_objs = 256
  cat_ids = {2: 1, 10: 0}
  ids_cat = {1: 2}
  def __init__(self, opt, split):
    self.dataset_version = opt.dataset_version
    print('Using MOTS {}'.format(self.dataset_version))
    data_dir = os.path.join(opt.data_dir, 'mots{}'.format(20))

    if opt.dataset_version in ['train', 'test']:
      ann_file = '{}.json'.format('train' if split == 'train' or split == 'val' else \
        'test')
    elif opt.dataset_version == 'train_part':
       ann_file = '{}.json'.format('train_part')
    elif opt.dataset_version == 'val_part':
       ann_file = '{}.json'.format('val_part')
    img_dir = os.path.join(data_dir, '{}'.format(
      'test' if 'test' in self.dataset_version else 'train'))
    
    print('ann_file', ann_file)
    ann_path = os.path.join(data_dir, 'annotations', ann_file)

    self.images = None
    # load image list and coco
    super(MOTS, self).__init__(opt, split, ann_path, img_dir)

    self.num_samples = len(self.images)
    print('Loaded MOTS {} {} {} samples'.format(
      self.dataset_version, split, self.num_samples))

  def _to_float(self, x):
    return float("{:.2f}".format(x))

  def __len__(self):
    return self.num_samples

  def save_results(self, results, save_dir):
    results_dir = save_dir
    if not os.path.exists(results_dir):
      os.makedirs(results_dir)
    for video in self.coco.dataset['videos']:
      video_id = video['id']
      file_name = video['file_name']
      out_path = os.path.join(results_dir, '{}.txt'.format(file_name))

      seq_id = file_name.split('-')[-1]
      seq_file_name = f"00{seq_id}"
      out_seq_name = os.path.join(results_dir, '{}.txt'.format(seq_file_name))

      f = open(out_path, 'w')
      images = self.video_to_images[video_id]

      for image_info in images:
        if not (image_info['id'] in results):
          continue
        result = results[image_info['id']]
        frame_id = image_info['frame_id']
        for obj in result:
          track_id = str(self.ids_cat[int(obj['class'])]) + "{0:03}".format(obj['tracking_id'])
          class_id = self.ids_cat[int(obj['class'])]
          img_height = obj['seg']['size'][0]
          img_width =  obj['seg']['size'][1]
          seg_rle = obj['seg']['counts']
          line = f"{str(int(frame_id))} {track_id} {class_id} {img_height} {img_width} {seg_rle}\n"
          f.write(line)

      f.close()
      copyfile(out_path, out_seq_name)
      print(f'Save to {out_path}')
  
  def run_eval(self, results, save_dir):
    self.save_results(results, save_dir)
    # gt_type_str = '{}'.format(
    #             '_train_half' if '17halftrain' in self.opt.dataset_version \
    #             else '_val_half' if '17halfval' in self.opt.dataset_version \
    #             else '')
    # gt_type_str = '_val_half' if self.year in [16, 19] else gt_type_str
    # gt_type_str = '--gt_type {}'.format(gt_type_str) if gt_type_str != '' else \
    #   ''
    # os.system('python tools/eval_motchallenge.py ' + \
    #           '../data/mot{}/{}/ '.format(self.year, 'train') + \
    #           '{}/results_mot{}/ '.format(save_dir, self.dataset_version) + \
    #           gt_type_str + ' --eval_official')
