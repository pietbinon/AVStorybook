//
//  PageDataModel.m
//  AVStorybook
//
//  Created by Enoch Ng on 2016-05-22.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "PageDataModel.h"


@implementation PageDataModel

- (instancetype)initWithIndex:(int)index
{
    self = [super init];
    if (self) {
        _pageIndex = index;
        
        NSString *audioFileNameForURL = [ NSString stringWithFormat:@"MyAudioFileForPage%i.m4a",index ];
        
        
        NSArray *pathComponents = [NSArray arrayWithObjects:
                                   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                                   audioFileNameForURL,
                                   nil];
        
        self.audioFileURL = [NSURL fileURLWithPathComponents:pathComponents];
        
        
        
    }
    return self;
}

@end
