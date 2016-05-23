//
//  StoryBookViewController.m
//  AVStorybook
//
//  Created by Enoch Ng on 2016-05-22.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

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
    
    for(int i = 0; i < 5; i ++){
    
        PageDataModel *thisPageModel = [[PageDataModel alloc] initWithIndex:i];
        
        [self.storyPages addObject:thisPageModel];
        
    }

    StoryPartViewController *firstPartViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyPartViewController"];
    
    PageDataModel *retrievedPageDataModel = self.storyPages[0];
    
    firstPartViewController.thisPageModel = retrievedPageDataModel;
    
    [self setViewControllers:@[firstPartViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(StoryPartViewController *)viewController {

    
    NSInteger index = [self.storyPages indexOfObject:viewController.thisPageModel];
    
    index--;
    
    if (index >= 0) {
        
        //        SomeContentViewController *controller = [[SomeContentViewController alloc] init];
        StoryPartViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"storyPartViewController"];
        
        PageDataModel *retrievedPageDataModel = self.storyPages[index];
        
        controller.thisPageModel = retrievedPageDataModel;
        //controller.view.backgroundColor = self.pages[index];
        return controller;
    }
    
    return nil;
}


- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(StoryPartViewController *)viewController {
    
    NSInteger index = [self.storyPages indexOfObject:viewController.thisPageModel];
    
    index++;
    
    if (index < [self.storyPages count]) {
        
        //        SomeContentViewController *controller = [[SomeContentViewController alloc] init];
        StoryPartViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"storyPartViewController"];
        
        PageDataModel *retrievedPageDataModel = self.storyPages[index];
        
        controller.thisPageModel = retrievedPageDataModel;
        //controller.view.backgroundColor = self.pages[index];
        return controller;
    }
    
    return nil;

}


@end
