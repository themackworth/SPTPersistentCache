/*
 * Copyright (c) 2016 Spotify AB.
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
#import "DetailViewController.h"

#import <SPTPersistentDataCache/SPTPersistentDataCache.h>
#import <SPTPersistentDataCache/SPTPersistentCacheResponse.h>
#import <SPTPersistentDataCache/SPTDataCacheRecord.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark DetailViewController

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        [self.persistentDataCache loadDataForKey:[NSString stringWithFormat:@"%u", [self.detailItem hash]]
                                    withCallback:^(SPTPersistentCacheResponse *response) {
                                        if (response.result != SPTPersistentDataCacheResponseCodeOperationSucceeded) {
                                            NSLog(@"Failed: %@", response.error);
                                            return;
                                        }
                                        self.detailImageView.image = [UIImage imageWithData:response.record.data];
                                    }
                                         onQueue:dispatch_get_main_queue()];
    }
}

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
