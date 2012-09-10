//
//  ViewController.m
//  MillenialMedia
//
//  Created by Martin Rosas on 9/6/12.
//  Copyright (c) 2012 Martin Rosas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation ViewController



@synthesize tableView;
@synthesize wordsArray=_wordsArray;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.responseData = [NSMutableData data];
    
    NSLog(@"ViewDidLoad");

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://pastebin.com/raw.php?i=14YC85u4"]];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    if(theConnection){
        self.wordsArray = [[NSMutableArray alloc]init];
    } else {
        NSLog(@"No Connection");
    }

}

- (void) connection:(NSURLConnection *)connection  didReceiveResponse:(NSURLResponse *)response {
    
    NSLog(@"ConnectionDidReceiveResponse");
        
    [self.responseData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    NSLog(@"ConnectionDidReceiveData");

    
    [self.responseData appendData:data];
}


- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSString *errorDescription = [error description];
    
    NSLog(@"Connection failed: %@", errorDescription);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    
    // Conversion of data to String //
    
    NSString *stringFromData = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",stringFromData);
    
    
    //Search for millenial within String //
    
    NSString *searchString = @"millennial";
    
    NSRange currentRange = {0,0};
    
    while (currentRange.location <= [stringFromData length]) {
        
    
        // get the range where we found 'millenial'
        currentRange = [stringFromData rangeOfString:searchString options:NSCaseInsensitiveSearch];
        
        
        if (currentRange.location < [stringFromData length]) {
            
            //get the word that matches the search term
            NSString *wordInstance = [stringFromData substringWithRange:currentRange];
    
            NSLog(@"%@",wordInstance);
    
            [self.wordsArray addObject:wordInstance];

        
            //get a new string where the new search will be performed
            NSString *newString = [stringFromData substringFromIndex:(currentRange.location + currentRange.length)];
    
            stringFromData = newString;
        }
    }
    
    [self.tableView reloadData];

}


//Table View methods.

- (NSInteger)tableView:(UITableView *)tView numberOfRowsInSection:(NSInteger)section{
    return self.wordsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"TableViewCellForRowAtIndexPath");

    
    UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:@"cell"];
    
    if( nil == cell ) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
        
    cell.textLabel.text = [self.wordsArray objectAtIndex:indexPath.row];
    
    return cell;
}

 
 
 - (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
        [tView deselectRowAtIndexPath:indexPath animated:YES];
 
 }


- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



@end







































