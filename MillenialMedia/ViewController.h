//
//  ViewController.h
//  MillenialMedia
//
//  Created by Martin Rosas on 9/6/12.
//  Copyright (c) 2012 Martin Rosas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray   *wordsArray;

@end
