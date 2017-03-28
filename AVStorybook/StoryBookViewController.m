//
//  StoryBookViewController.m
//  AVStorybook
//
//  Created by Pierre Binon on 2017-03-27.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//
//!!!DON'T FORGET TO ADD AUTHORIZATION TO USE PHOTOS IN INFO.PLIST!!!

#import "StoryBookViewController.h"
#import "StoryPartViewController.h"
#import "PageDataModel.h"



@interface StoryBookViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic) NSMutableArray *storyPages;

@end




@implementation StoryBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = self;
    self.delegate = self;
    
    self.storyPages = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i ++) {
    
        PageDataModel *pageModel = [[PageDataModel alloc] initWithIndex: i];
        
        [self.storyPages addObject: pageModel];
    }

    StoryPartViewController *firstPartViewController = [self.storyboard instantiateViewControllerWithIdentifier: @"storyPartViewController"];
    
    PageDataModel *retrievedPageDataModel = self.storyPages[0];
    
    firstPartViewController.pageDataModel = retrievedPageDataModel;
    
    [self setViewControllers: @[firstPartViewController] direction: UIPageViewControllerNavigationDirectionForward animated: NO completion: nil];
}


- (nullable UIViewController *) pageViewController: (UIPageViewController *) pageViewController viewControllerBeforeViewController: (StoryPartViewController *) viewController {

    
    NSInteger index = [self.storyPages indexOfObject: viewController.pageDataModel];
    
    index--;
    
    if (index >= 0) {
        
        StoryPartViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier: @"storyPartViewController"];
        
        PageDataModel *retrievedPageDataModel = self.storyPages[index];
        
        controller.pageDataModel = retrievedPageDataModel;
        return controller;
    }
    
    return nil;
}


- (nullable UIViewController *) pageViewController: (UIPageViewController *) pageViewController viewControllerAfterViewController: (StoryPartViewController *) viewController {
    
    NSInteger index = [self.storyPages indexOfObject: viewController.pageDataModel];
    
    index++;
    
    if (index < [self.storyPages count]) {
        
        StoryPartViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier: @"storyPartViewController"];
        
        PageDataModel *retrievedPageDataModel = self.storyPages[index];
        
        controller.pageDataModel = retrievedPageDataModel;
        return controller;
    }
    
    return nil;
}

@end
