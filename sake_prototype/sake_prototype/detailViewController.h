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

@interface detailViewController : UIViewController <UIScrollViewDelegate, UITextViewDelegate> {
    int sakeIDNumber;
    int sakeID;
    
    UIScrollView *scrollView;
    
    UIImageView *graphImage;
    UIImageView *sakePinImage;
    
    UIView *alertViewB;
    UIView *alertViewF;
    
    UITextView *commentTextView;
    
    NSMutableArray *arrayOfSakeDictionary;
    NSMutableArray *arrayOfDrunkSakeID;
    
    NSDictionary *sakeDictionary;

    NSUserDefaults *defaults;
    
    CGSize contentSize;
    
    BOOL pinAdded;
}

@end
