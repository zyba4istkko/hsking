//
//  WalkthroughPageViewController.m
//  pdd
//
//  Created by Иван Труфанов on 04.12.14.
//  Copyright (c) 2014 werbary. All rights reserved.
//

#import "WalkthroughPageViewController.h"
#import "ContentViewController.h"

@interface WalkthroughPageViewController () {
    NSArray *controllers;
}
@end

@implementation WalkthroughPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    controllers = @[@"step1",@"step2",@"step3",@"step4"];
    
    self.dataSource = self;
    self.delegate = self;
    self.view.backgroundColor = [UIColor clearColor];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.35 green:0.5 blue:0.61 alpha:1];
    pageControl.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1.0];
    
    ContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"dismiss_walkthrough" object:nil];
}
- (void) dismiss {
    ContentViewController *theCurrentViewController = (ContentViewController *)[self.viewControllers objectAtIndex:0];
    
    if (theCurrentViewController.pageIndex == controllers.count-1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIViewController *firstViewController = [self viewControllerAtIndex:controllers.count-1];
        [self setViewControllers:@[firstViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    }
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (ContentViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [controllers count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
- (ContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index >= controllers.count) {
        return nil;
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Walkthrough" bundle:[NSBundle mainBundle]];
    ContentViewController *viewController = (ContentViewController *)[storyboard instantiateViewControllerWithIdentifier:controllers[index]];
    viewController.pageIndex = index;
    return viewController;
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [controllers count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    if (self.viewControllers.count == 0 || !self.viewControllers) {
        return 0;
    }

    ContentViewController *theCurrentViewController = (ContentViewController *)[self.viewControllers objectAtIndex:0];
    return theCurrentViewController.pageIndex;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
