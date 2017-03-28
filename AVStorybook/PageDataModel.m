//
//  PageDataModel.m
//  AVStorybook
//
//  Created by Pierre Binon on 2017-03-27.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//
//!!!DON'T FORGET TO ADD AUTHORIZATION TO USE PHOTOS IN INFO.PLIST!!!

#import "PageDataModel.h"



@implementation PageDataModel

- (instancetype) initWithIndex: (int) index
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
