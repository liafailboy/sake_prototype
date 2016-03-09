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

- (void)setUpViewChangeButton {
    
    // intitalize image and button
    UIImage *buttonImage = [UIImage imageNamed:@"back_to_grid.png"];
    
    // initialize button
    UIButton *buttonForViewChange = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // set the location and the size of the button
    [buttonForViewChange setFrame:CGRectMake(17, 27, 30, 30)];
    
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

- (void)getSakeID {
    sakeIDNumber = (int)[defaults integerForKey:@"sakeID"];
}

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
    NSDictionary *sakeDictionary = [arrayOfSakeDictionary objectAtIndex:sakeIDNumber];
    
    // add imageView if it is already exist
    int sakeID = [[sakeDictionary objectForKey:@"SAKE_ID"] intValue];
    
    // add images if sake is drunk. Else, leave it brunk.
    if ([arrayOfDrunkSakeID containsObject:[NSNumber numberWithInt:sakeID]]) {
        
        // add detail of sake in first page of the view
        UIImageView *detailSakeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[NSString stringWithFormat:@"detail_sake_%d", sakeID] stringByAppendingString:@".png"]]];
        detailSakeImageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY);
        [scrollView addSubview:detailSakeImageView];
        
        // add picture in second page of the view
        UIImageView *detailPictureImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[NSString stringWithFormat:@"detail_picture_%d", sakeID] stringByAppendingString:@".png"]]];
        detailPictureImageView.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, 135);
        [scrollView addSubview:detailPictureImageView];
        
        // add sake label in second page of the view
        UIImageView *detailLabelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[NSString stringWithFormat:@"detail_label_%d", sakeID] stringByAppendingString:@".png"]]];
        detailLabelImageView.frame = CGRectMake(self.view.bounds.size.width, 135, self.view.bounds.size.width, 467);
        [scrollView addSubview:detailLabelImageView];
        
        // add text explanation in second page of the view
        UILabel *labelOfSakeDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width + 30, 235, self.view.bounds.size.width - 60, self.view.bounds.size.height - navigationBarY - 235)];
        
        labelOfSakeDetail.textAlignment = NSTextAlignmentLeft;
        
        [labelOfSakeDetail setFont:[UIFont fontWithName:@"HannariMincho" size:18.0]];
        
        labelOfSakeDetail.text = @"八海醸造（はっかいじょうぞう、英文名称:HAKKAISAN BREWERY CO.,LTD. ）は、新潟県南魚沼市長森に本社を置く企業。創業は1922年（大正11年）で、新潟の地酒を代表する銘柄『八海山』の酒蔵である。仕込水『雷電様の清水』など酒造りに最適の雪国魚沼の環境条件と「寒梅と八海山は兄弟蔵」と言われた酒造りの技で、淡麗辛口の酒質評価が高い食中酒。製造方針は、「大吟醸酒製造技術の全酒類製造への応用」。新潟県内では、朝日酒造（売上高81億）・菊水酒造（売上51億）に次ぐ業界3位である。清酒以外では、発酵食品企業として『米・麹・発酵』をコンセプトにしている。";
        
        labelOfSakeDetail.lineBreakMode = NSLineBreakByWordWrapping;
        labelOfSakeDetail.numberOfLines = 0;
        [labelOfSakeDetail sizeToFit];
        
        [scrollView addSubview:labelOfSakeDetail];
        
    } else {
        
        // initialize labels for sake information
        UILabel *labelOfSakeName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
        UILabel *labelOfSakePre = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
        UILabel *labelOfSakeCity = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
        UILabel *labelOfSakeCom = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
        UILabel *labelOfSakeAci = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
        UILabel *labelOfSakeMeter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
        
        // set the location of each label
        labelOfSakeName.center = CGPointMake(contentSize.width / 6, contentSize.height / 2);
        labelOfSakePre.center = CGPointMake(contentSize.width / 2 , contentSize.height / 2 - 50);
        labelOfSakeCity.center = CGPointMake(contentSize.width / 2, contentSize.height / 2);
        labelOfSakeCom.center = CGPointMake(contentSize.width / 2, contentSize.height / 2 + 50);
        labelOfSakeAci.center = CGPointMake(contentSize.width * 5 / 6, contentSize.height / 2 - 25);
        labelOfSakeMeter.center = CGPointMake(contentSize.width * 5 / 6, contentSize.height / 2 + 25);
        
        // set the alignment of labels to center
        labelOfSakeName.textAlignment = NSTextAlignmentCenter;
        labelOfSakePre.textAlignment = NSTextAlignmentCenter;
        labelOfSakeCity.textAlignment = NSTextAlignmentCenter;
        labelOfSakeCom.textAlignment = NSTextAlignmentCenter;
        labelOfSakeAci.textAlignment = NSTextAlignmentCenter;
        labelOfSakeMeter.textAlignment = NSTextAlignmentCenter;
        
        // adjust the font size to the width of the label
        [labelOfSakeName setFont:[UIFont fontWithName:@"HannariMincho" size:48.0]];
        [labelOfSakePre setFont:[UIFont fontWithName:@"HannariMincho" size:48.0]];
        [labelOfSakeCity setFont:[UIFont fontWithName:@"HannariMincho" size:48.0]];
        [labelOfSakeCom setFont:[UIFont fontWithName:@"HannariMincho" size:48.0]];
        [labelOfSakeAci setFont:[UIFont fontWithName:@"HannariMincho" size:48.0]];
        [labelOfSakeMeter setFont:[UIFont fontWithName:@"HannariMincho" size:48.0]];
        
        // adjust the font size if it does not fit the width
        labelOfSakeName.adjustsFontSizeToFitWidth = YES;
        labelOfSakePre.adjustsFontSizeToFitWidth = YES;
        labelOfSakeCity.adjustsFontSizeToFitWidth = YES;
        labelOfSakeCom.adjustsFontSizeToFitWidth = YES;
        labelOfSakeAci.adjustsFontSizeToFitWidth = YES;
        labelOfSakeMeter.adjustsFontSizeToFitWidth = YES;
        
        
        // set the text to label from sake dictionary
        labelOfSakeName.text = [sakeDictionary objectForKey:@"NAME"];
        labelOfSakePre.text = [NSString stringWithFormat:@"都道府県: %@",[sakeDictionary objectForKey:@"PREFECTURE"]];
        labelOfSakeCity.text = [NSString stringWithFormat:@"都市: %@",[sakeDictionary objectForKey:@"CITY"]];
        labelOfSakeCom.text = [NSString stringWithFormat:@"醸造元: %@",[sakeDictionary objectForKey:@"COMPANY"]];
        labelOfSakeAci.text = [NSString stringWithFormat:@"酸度: %@", [sakeDictionary objectForKey:@"ACIDITY"]];
        labelOfSakeMeter.text = [NSString stringWithFormat:@"日本酒度: %@", [sakeDictionary objectForKey:@"SAKE_METER"]];
        
        // add labels to the view
        [scrollView addSubview:labelOfSakeName];
        [scrollView addSubview:labelOfSakePre];
        [scrollView addSubview:labelOfSakeCity];
        [scrollView addSubview:labelOfSakeCom];
        [scrollView addSubview:labelOfSakeAci];
        [scrollView addSubview:labelOfSakeMeter];
    }
    
    UIImageView *graphImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"graph.png"]];
    graphImage.frame = CGRectMake(0, 0, 375, 249);
    graphImage.center = CGPointMake(contentSize.width * 5 / 6, contentSize.height / 2);
    [scrollView addSubview:graphImage];
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
