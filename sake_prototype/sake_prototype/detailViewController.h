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
    
    // sakeID to specify the sake refering to
    int sakeIDNumber;
    int sakeID;
    
    // scrollview for vertical scrolling
    UIScrollView *scrollView;
    
    UIImageView *graphImage;
    UIImageView *sakePinImage;
    
    // for the test part of registering new sake that user drunk
    UIView *alertViewB;
    UIView *alertViewF;
    
    // label on very top of the navigation bar
    UILabel *titleLabel;

    // for the test part of enable user to give their comment to new sake
    UITextView *commentTextView;
    
    NSMutableArray *arrayOfSakeDictionary;
    NSMutableArray *arrayOfDrunkSakeID;
    
    NSDictionary *sakeDictionary;

    NSUserDefaults *defaults;
    
    // size of the content's size for scrollview
    CGSize contentSize;
    
    // whether sake pin for evaluation has placed or not
    BOOL pinAdded;
}

@end
