//
//  DABStartButton.m
//  QReader
//
//  Created by Danilo Braband on 18.11.13.
//  Copyright (c) 2013 Danilo Braband. All rights reserved.
//

#import "DABStartButton.h"

@implementation DABStartButton

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    if ([self isSelected]) {
        self.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:114.0/255.0 blue:34.0/255.0 alpha:1.0];
    } else {
        self.backgroundColor = [UIColor colorWithRed:124.0/255.0 green:16.0/255.0 blue:154.0/255.0 alpha:1.0];
    }
}

@end
