//
//  BNRPoint.h
//  TouchTracker
//
//  Created by Jan Graßegger on 02.05.14.
//  Copyright (c) 2014 Jan Graßegger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRPoint : NSObject

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

- (instancetype)initWithPoint:(CGPoint) point;

@end
