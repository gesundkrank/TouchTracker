//
//  BNRPoint.m
//  TouchTracker
//
//  Created by Jan Graßegger on 02.05.14.
//  Copyright (c) 2014 Jan Graßegger. All rights reserved.
//

#import "BNRPoint.h"

@implementation BNRPoint

- (instancetype)initWithPoint:(CGPoint)point
{
    self = [super init];
    
    if (self) {
        _x = point.x;
        _y = point.y;
    }
    
    return self;
}

@end
