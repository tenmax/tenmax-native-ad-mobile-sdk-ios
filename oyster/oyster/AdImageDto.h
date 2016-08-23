//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AdImageDto : NSObject
@property (nonatomic, readonly, assign) long width;
@property (nonatomic, readonly, assign) long height;
@property (nonatomic, readonly, strong) NSString* url;

- (instancetype) initWithWidth:(long) width height:(long) height url:(NSString*) url;

@end