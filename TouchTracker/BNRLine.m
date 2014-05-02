//
//  BNRLine.m
//  TouchTracker
//
//  Created by Jan Graßegger on 01.05.14.
//  Copyright (c) 2014 Jan Graßegger. All rights reserved.
//

#import "BNRLine.h"

@implementation BNRLine

-  (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        float beginX = [aDecoder decodeFloatForKey:@"begin_x"];
        float beginY = [aDecoder decodeFloatForKey:@"begin_y"];
        self.begin = CGPointMake(beginX, beginY);
    
        float endX = [aDecoder decodeFloatForKey:@"end_x"];
        float endY = [aDecoder decodeFloatForKey:@"end_y"];
        self.end = CGPointMake(endX, endY);
    }
    
    return self;
    
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeFloat:self.begin.x forKey:@"begin_x"];
    [aCoder encodeFloat:self.begin.y forKey:@"begin_y"];
    [aCoder encodeFloat:self.end.x forKey:@"end_x"];
    [aCoder encodeFloat:self.end.y forKey:@"end_y"];
}

@end
