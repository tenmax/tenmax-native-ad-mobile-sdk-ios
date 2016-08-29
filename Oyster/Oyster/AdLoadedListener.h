//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AdViewModel;

@protocol AdLoadedListener<NSObject>

- (void) onAdFailedToLoad:(NSError*) error;

- (void) onSuccess:(AdViewModel*) adViewModel;

@end