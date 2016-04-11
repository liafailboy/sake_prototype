//
//  detailViewController.h
//  sake_prototype
//
//  Created by Shotaro Watanabe on 3/2/16.
//  Copyright © 2016 liafailboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ASAnyCurlController.h"
#import <Parse/Parse.h>

@interface detailViewController : UIViewController <UIScrollViewDelegate> {
    int sakeIDNumber;
    int sakeID;
    
    UIScrollView *scrollView;
    
    NSMutableArray *arrayOfSakeDictionary;
    NSMutableArray *arrayOfDrunkSakeID;

    NSUserDefaults *defaults;
    
    CGSize contentSize;
    
}

@end
