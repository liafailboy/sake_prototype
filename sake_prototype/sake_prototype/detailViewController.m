//
//  detailViewController.m
//  sake_prototype
//
//  Created by Shotaro Watanabe on 3/2/16.
//  Copyright © 2016 liafailboy. All rights reserved.
//

#import "detailViewController.h"

@interface detailViewController ()

@end

@implementation detailViewController

#define navigationBarY 65

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // get the store data of sake
    defaults = [NSUserDefaults standardUserDefaults];
    arrayOfSakeDictionary = [defaults mutableArrayValueForKey:@"arrayOfSakeDictionary"];
    arrayOfDrunkSakeID = [defaults objectForKey:@"drunkSakeID"];
    
    // get the sakeID from previous view
    [self getSakeID];
    
    // set the UIView for navigation bar
    [self setUpNavigationBar];
    
    // set the view change button
    [self setUpViewChangeButton];
    
    // set the scroll view
    [self setUpScrollView];
}

# pragma animation

- (void)animateDesign {

    // start animation
    [self animateBackDesign];
    
    //[self animateTileDesign];
    [NSTimer scheduledTimerWithTimeInterval:0.2f
                                     target:self
                                   selector:@selector(animateTileDesign)
                                   userInfo:nil
                                    repeats:NO];
    //[self animateSakeDesign];
    [NSTimer scheduledTimerWithTimeInterval:0.5f
                                     target:self
                                   selector:@selector(animateSakeDesign)
                                   userInfo:nil
                                    repeats:NO];
    //[self animateTagDesign];
    [NSTimer scheduledTimerWithTimeInterval:0.7f
                                     target:self
                                   selector:@selector(animateTagDesign)
                                   userInfo:nil
                                    repeats:NO];
    
    //[self animateStampDesign];
    [NSTimer scheduledTimerWithTimeInterval:1.1f
                                     target:self
                                   selector:@selector(animateStampDesign)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)animateBackDesign {
    // stay at the screen from the beginning
    UIImageView *backImage;
    if (sakeID < 10) {
        backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_0.png"]];
    } else if (sakeID < 17) {
        backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_1.png"]];
    } else if (sakeID < 24) {
        backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_2.png"]];
    }
    
    backImage.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY);
    [scrollView addSubview:backImage];
}

- (void)animateTileDesign {
    // move from up and down into the screen
    UIImageView *tileBotImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[NSString stringWithFormat:@"tileBot_%d", sakeID] stringByAppendingString:@".png"]]];
    tileBotImage.frame = CGRectMake(0, 160, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY);
    UIImageView *tileTopImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[NSString stringWithFormat:@"tileTop_%d", sakeID] stringByAppendingString:@".png"]]];
    tileTopImage.frame = CGRectMake(0, -160, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY);
    
    [scrollView addSubview:tileBotImage];
    [scrollView addSubview:tileTopImage];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    tileBotImage.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY);
    tileTopImage.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY);
    
    [UIView commitAnimations];
}

- (void)animateSakeDesign {
    // fade in sake bottle
    UIImageView *bottleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[NSString stringWithFormat:@"bottle_%d", sakeID] stringByAppendingString:@".png"]]];
    bottleImage.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY);
    
    bottleImage.alpha = 0;
    
    [scrollView addSubview:bottleImage];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    bottleImage.alpha = 1;
    
    [UIView commitAnimations];
}

- (void)animateTagDesign {
    // curl down to animate as if it is attached
    // location x = 27, y = 32
    UIImageView *tagImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[NSString stringWithFormat:@"tag_%d", sakeID] stringByAppendingString:@".png"]]];
    //tagImage.frame = CGRectMake(27, 32, 117, 302);
    
    //tagImage.alpha = 0;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(27, 32, 117, 302)];
    
    view.alpha = 0;
    
    [scrollView addSubview:view];
    
    [ASAnyCurlController animateTransitionDownFromView:view toView:tagImage duration:0.8 options:ASAnyCurlOptionBottomRight | ASAnyCurlOptionVertical completion:^{
        
    }];
    
    //[scrollView addSubview:tagImage];
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.8];
//    
//    tagImage.alpha = 1;
//    
//    [UIView commitAnimations];
}

- (void)animateStampDesign {
    
    UIImageView *stampImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stamp.png"]];
    stampImage.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY);
    
    stampImage.alpha = 0;
    
    [scrollView addSubview:stampImage];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.7];
    
    stampImage.alpha = 1;
    
    [UIView commitAnimations];
    
    UIButton *amazon = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *rakuten = [UIButton buttonWithType:UIButtonTypeCustom];
    
    amazon.frame = CGRectMake(27, 560, 32, 32);
    rakuten.frame = CGRectMake(78, 560, 32, 32);
    
    [amazon setImage:[UIImage imageNamed:@"amazon_logo.png"] forState:UIControlStateNormal];
    [rakuten setImage:[UIImage imageNamed:@"rakuten_logo.png"] forState:UIControlStateNormal];
    
    [amazon addTarget:self action:@selector(amazonLink:) forControlEvents:UIControlEventTouchUpInside];
    [rakuten addTarget:self action:@selector(rakutenLink:) forControlEvents:UIControlEventTouchUpInside];
    
    amazon.alpha = 0;
    rakuten.alpha = 0;
    
    [scrollView addSubview:amazon];
    [scrollView addSubview:rakuten];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.7];
    
    amazon.alpha = 1;
    rakuten.alpha = 1;
    
    [UIView commitAnimations];
}

# pragma setup navigationbar

- (void)setUpNavigationBar {
    
    // initialize navigation bar on the main screen
    UIView *statusBar = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 375, 20)];
    
    // set the background color of navigation bar to light gray
    statusBar.backgroundColor = [UIColor whiteColor];
    
    // add navigation bar into main screen
    [self.view addSubview:statusBar];
    
    // initialize navigation bar on the main screen
    UIView *navigationBar = [[UIView alloc]  initWithFrame:CGRectMake(0, 20, 375, 45)];
    
    // set the background color of navigation bar to light gray
    navigationBar.backgroundColor = [UIColor colorWithRed:0.125 green:0.125 blue:0.125 alpha:1];
    
    // add navigation bar into main screen
    [self.view addSubview:navigationBar];
}

# pragma setup button

- (void)setUpViewChangeButton {
    
    // intitalize image and button
    UIImage *buttonImage = [UIImage imageNamed:@"back_to_grid.png"];
    
    // initialize button
    UIButton *buttonForViewChange = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // set the location and the size of the button
    [buttonForViewChange setFrame:CGRectMake(20, 30, 25, 25)];
    
    // set the image of buttons
    [buttonForViewChange setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    // call action method when button is pushed
    [buttonForViewChange addTarget:self action:@selector(backToMainButtonPushed:)
                  forControlEvents:UIControlEventTouchUpInside];
    
    // add the buttons to the scrollview
    [self.view addSubview:buttonForViewChange];
}

- (void)backToMainButtonPushed:(UIButton *) button {
    // initiazlize animation effect to push new view controller from right to left
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromBottom;
    
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

# pragma setup data

- (void)getSakeID {
    sakeIDNumber = (int)[defaults integerForKey:@"sakeID"];
}

# pragma setup scrollview

- (void)setUpScrollView {
    
    // initialize scrollView to make page based view
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, navigationBarY, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY)];
        
    // set the size of the content to the width of screen with three pages
    contentSize = CGSizeMake(self.view.bounds.size.width * 3
                             ,self.view.bounds.size.height - navigationBarY);
    scrollView.contentSize = contentSize;
    
    // set the delegate of scrollview to self
    scrollView.delegate = self;
    
    // set the scrollView to page based
    scrollView.pagingEnabled = YES;
    
    // disable bounce
    scrollView.bounces = NO;
    
    [self addInformationOnScrollView];
    
    // add scrollView to main screen
    [self.view addSubview:scrollView];
}

- (void)addInformationOnScrollView {
    
    // get the sake date from shared array from previous view
    sakeDictionary = [arrayOfSakeDictionary objectAtIndex:sakeIDNumber];
    
    // add imageView if it is already exist
    sakeID = [[sakeDictionary objectForKey:@"SAKE_ID"] intValue];
    
    // animate or add picture in first page of the view
    [self setFirstPageOfScrollView];
    
    // add picture in second page of the view
    [self setSecondPageOfScrollView];
    
    // add picture in third page of the view
    [self setThirdPageOfScrollView];
}

- (void)setFirstPageOfScrollView {
    // add images if sake is drunk. Else, leave it blank.
    if (sakeID < 25) {
        [self animateDesign];
    } else {
        // add detail of sake in first page of the view
        UIImageView *detailSakeUnknownImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_sake_unknown.png"]];
        detailSakeUnknownImageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY);
        [scrollView addSubview:detailSakeUnknownImageView];
        
        // button to release
        UIButton *release = [UIButton buttonWithType:UIButtonTypeCustom];
        
        release.frame = CGRectMake(277, 508, 84, 85);
        
        [release setImage:[UIImage imageNamed:@"release_button.png"] forState:UIControlStateNormal];
        
        [release addTarget:self action:@selector(release:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:release];
        
        scrollView.scrollEnabled = NO;
        
        // add amazon and rakuten link to buy sake
        [self addAmazonRakutenButton];
        
    }
}

- (void)setSecondPageOfScrollView {
    
    UIImageView *detailPictureImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[NSString stringWithFormat:@"detail_picture_%d", 24] stringByAppendingString:@".png"]]];
    detailPictureImageView.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, 135);
    [scrollView addSubview:detailPictureImageView];
    
    // add sake label in second page of the view
    UIImageView *detailLabelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_label"]];
    detailLabelImageView.frame = CGRectMake(self.view.bounds.size.width, 135, self.view.bounds.size.width, 467);
    [scrollView addSubview:detailLabelImageView];
    
    // add text explanation in second page of the view
    UILabel *labelOfSake = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    
    labelOfSake.center = CGPointMake(self.view.bounds.size.width * 3 / 2, 210);
    
    // intitlize the label for the detail of sake with left alignment
    labelOfSake.textAlignment = NSTextAlignmentCenter;
    
    [labelOfSake setFont:[UIFont fontWithName:@"lmroman10-regular" size:18.0]];
    
    NSString *sakeName = [sakeDictionary objectForKey:@"NAMEENG"];
    
    // HAVE TO BE CHANGED ACCORDING TO THE EXPLANATION OF THE SPECIFIC SAKE
    labelOfSake.text = [NSString stringWithFormat:@"- %@ -", sakeName];
    
    // add text explanation in second page of the view
    UILabel *labelOfSakeDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width + 30, 220, self.view.bounds.size.width - 60, self.view.bounds.size.height - navigationBarY - 235)];
    
    // intitlize the label for the detail of sake with left alignment
    labelOfSakeDetail.textAlignment = NSTextAlignmentLeft;
    
    [labelOfSakeDetail setFont:[UIFont fontWithName:@"HannariMincho" size:18.0]];
    
    // HAVE TO BE CHANGED ACCORDING TO THE EXPLANATION OF THE SPECIFIC SAKE
    NSString *labelText = [sakeDictionary objectForKey:@"DETAILJP"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    labelOfSakeDetail.attributedText = attributedString;
    
    // initialize label of sake
    labelOfSakeDetail.lineBreakMode = NSLineBreakByWordWrapping;
    
    labelOfSakeDetail.numberOfLines = 0;
    
    //[labelOfSakeDetail sizeToFit];
    
    // add the detailed explanation label to the scroll view
    [scrollView addSubview:labelOfSake];
    [scrollView addSubview:labelOfSakeDetail];
}

- (void)setThirdPageOfScrollView {
    // initialize the image of graph of acidity and sake meter
    UIImageView *graphImageThirdPage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"graph.png"]];
    graphImageThirdPage.frame = CGRectMake(0, 0, 375, 249);
    graphImageThirdPage.center = CGPointMake(contentSize.width * 5 / 6, contentSize.height / 2);
    
    // add the graph to scrollview
    [scrollView addSubview:graphImageThirdPage];
    
    // initialize the image of pin with specific location in the graph
    UIImageView *sakePinImageThirdPage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sake_pin.png"]];
    sakePinImageThirdPage.frame = CGRectMake(0, 0, 30, 30);
    sakePinImageThirdPage.center = CGPointMake(contentSize.width * 5 / 6 + (0 - [[sakeDictionary objectForKey:@"SAKE_METER"] floatValue] * 37.5 / 2), contentSize.height / 2 + (1.5 - [[sakeDictionary objectForKey:@"ACIDITY"] floatValue]) * 249);
    
    // add the pin to scrollview on top of the graph
    [scrollView addSubview:sakePinImageThirdPage];
}

# pragma amazon, rakuten button

- (void)addAmazonRakutenButton {
    // add amazon and rakuten link to buy sake
    UIButton *amazon = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *rakuten = [UIButton buttonWithType:UIButtonTypeCustom];
    
    amazon.frame = CGRectMake(27, 560, 32, 32);
    rakuten.frame = CGRectMake(78, 560, 32, 32);
    
    [amazon setImage:[UIImage imageNamed:@"amazon_logo.png"] forState:UIControlStateNormal];
    [rakuten setImage:[UIImage imageNamed:@"rakuten_logo.png"] forState:UIControlStateNormal];
    
    [amazon addTarget:self action:@selector(amazonLink:) forControlEvents:UIControlEventTouchUpInside];
    [rakuten addTarget:self action:@selector(rakutenLink:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:amazon];
    [scrollView addSubview:rakuten];
}

- (void)amazonLink:(UIButton*) button {
    NSLog(@"Go to safari with amazon link");
    [self openUIWebViewWithURL:@"http://amzn.to/1ULPQRX"];
}

- (void)rakutenLink:(UIButton*) button {
    NSLog(@"Go to safari with rakuten link");
    [self openUIWebViewWithURL:@"http://bit.ly/1S0vXD5"];
}

- (void)openUIWebViewWithURL:(NSString*) urlString {
    
    [defaults setObject:urlString forKey:@"webURL"];
    
    UIViewController *wVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"webViewController"];
    
    // initiazlize animation effect to push new view controller from right to left
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:wVC animated:NO completion:nil];
}

# pragma add new sake button

- (void)release:(UIButton*) button {
    NSLog(@"Sake released");
    
    scrollView.scrollEnabled = NO;
    
    alertViewB = [[UIView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 300) / 2, (self.view.bounds.size.height - 450) / 2, 300, 450)];
    alertViewF = [[UIView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 250) / 2, (self.view.bounds.size.height - 400) / 2, 250, 400)];
    
    alertViewB.backgroundColor = [[UIColor alloc] initWithRed:156.0/255 green:102.0/255 blue:31.0/255 alpha:1.0];
    alertViewF.backgroundColor = [[UIColor alloc] initWithRed:238.0/255 green:197.0/255 blue:145.0/255 alpha:1.0];

    [self.view addSubview:alertViewB];
    [self.view addSubview:alertViewF];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 50)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"新しいお酒の登録";
    [alertViewF addSubview:titleLabel];
    
    graphImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"graph.png"]];
    graphImage.frame = CGRectMake(0, 60, 250, 166);
    graphImage.userInteractionEnabled = YES;
    [alertViewF addSubview:graphImage];
    
    sakePinImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sake_pin.png"]];
    sakePinImage.frame = CGRectMake(0, 0, 30, 30);
    pinAdded = NO;
    
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 226, 250, 50)];
    commentLabel.textAlignment = NSTextAlignmentLeft;
    commentLabel.text = @"コメント";
    [alertViewF addSubview:commentLabel];
    
    commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 276, 250, 80)];
    commentTextView.delegate = self;
    commentTextView.editable = YES;
    commentTextView.backgroundColor = [UIColor whiteColor];
    [alertViewF addSubview:commentTextView];
    
    UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *buttonSubmit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    buttonCancel.frame = CGRectMake(0, 355, 125, 50);
    buttonSubmit.frame = CGRectMake(125, 355, 125, 50);
    
    [buttonCancel setTitle:@"キャンセル" forState:UIControlStateNormal];
    [buttonSubmit setTitle:@"登録" forState:UIControlStateNormal];
    
    [buttonCancel addTarget:self action:@selector(cancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonSubmit addTarget:self action:@selector(submitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [alertViewF addSubview:buttonCancel];
    [alertViewF addSubview:buttonSubmit];
}

- (void)cancelButton:(UIButton*) button {
    NSLog(@"cancel submission");
    // called when sake register is cancelled
    [alertViewF removeFromSuperview];
    [alertViewB removeFromSuperview];
    
    scrollView.scrollEnabled = YES;
}

- (void)submitButton:(UIButton*) button {
    NSLog(@"register new sake");
    // called when user pressed submit button to register new sake
    // [commentTextView text] gives text in the text field
    [alertViewF removeFromSuperview];
    [alertViewB removeFromSuperview];
    
    scrollView.scrollEnabled = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:graphImage];
    
    if (touch.view == graphImage) {
        if (pinAdded == NO) {
            sakePinImage.center = touchLocation;
            [graphImage addSubview:sakePinImage];
        } else {
            sakePinImage.center = touchLocation;
        }
    }
    pinAdded = YES;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:graphImage];
    
    if (touchLocation.x <= 0) {
        touchLocation.x = 1;
    }
    if (touchLocation.x >= 250) {
        touchLocation.x = 249;
    }
    if (touchLocation.y <= 0) {
        touchLocation.y = 1;
    }
    if (touchLocation.y >= 166) {
        touchLocation.y = 165;
    }
    
    if (touch.view == graphImage) {
        sakePinImage.center = touchLocation;
    }
    
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

@end
