//
//  detailViewController.h
//  sake_prototype
//
//  Created by Shotaro Watanabe on 3/2/16.
//  Copyright © 2016 liafailboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface detailViewController : UIViewController <UIScrollViewDelegate> {
    int sakeIDNumber;
    
    UIScrollView *scrollView;
    
    NSMutableArray *arrayOfSakeDictionary;

    NSUserDefaults *defaults;
    
    CGSize contentSize;
}

@end
