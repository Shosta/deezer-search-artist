//
//  SearchArtistViewController.m
//  Deezer
//
//  Created by Rems on 18/01/2014.
//  Copyright (c) 2014 RemiLavedrine. All rights reserved.
//

#import "SearchArtistViewController.h"
#import "FirstAlbumForArtistViewController.h"
#import "DeezerSession.h"
#import "UIImageView+WebCache.h"

@interface SearchArtistViewController ()

@property (nonatomic, retain) NSMutableArray *artistsArray;

@end

@implementation SearchArtistViewController


#pragma mark - Object

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.artistsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return self;
}


#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set the navigationBar title.
    [self.navigationItem setTitle:@"Deezer"];
    
    [self.searchArtistTextField becomeFirstResponder];
}


#pragma mark - Header Height

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    float headerHeight = 0.0;
    
    switch (section) {
        case SearchArtistCellSection:
            headerHeight = self.searchingArtistContainerView.frame.size.height;
            break;
            
        default:
            break;
    }
    
    return headerHeight;
}


#pragma mark - Header

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    switch (section) {
        case SearchArtistCellSection:
            headerView = self.searchingArtistContainerView;
            break;
            
        default:
            break;
    }
    
    return headerView;
}


#pragma mark - Cell Count

//! Search Artist section numbers.
typedef enum{
    SearchArtistCellSection = 0,
    SearchArtistsResultCellSection = 1,
    SearchArtistsCellSectionCount
}ArtistsCellSectionNumbers;

- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return SearchArtistsCellSectionCount;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rowNumber = 0;
    switch (section) {
        case SearchArtistCellSection:
            rowNumber = 0;
            break;
            
        case SearchArtistsResultCellSection:
            rowNumber = self.artistsArray.count;
            break;
            
        default:
            break;
    }
    
    return rowNumber;
}


#pragma mark - Cell

/**
 @brief Configure the cell according to the artist dictionary object.
 @author : Rémi Lavedrine
 @date : 18/01/2014
 @remarks : <#(optional)#>
 */
- (void)configureCell:(UITableViewCell *)cell atIndex:(int)index {
    NSDictionary *artistDict = self.artistsArray[index];
    
    NSString *artistName = [artistDict objectForKey:kArtistNameKey];
    [cell.textLabel setText:artistName];
    
    [cell.imageView setImageWithURL:[artistDict objectForKey:kArtistImageUrlKey]
                   placeholderImage:ARTIST_PLACEHOLDER_IMAGE];
}

/**
 @brief Create the cells for the Artists.
 @author : Rémi Lavedrine
 @date : 18/01/2014
 @remarks : <#(optional)#>
 */
- (UITableViewCell *)tableView:(UITableView *)tableView artistCellForRowAtIndex:(int)index {
    NSString *CellIdentifier = @"ArtistCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    // Configure the cell.
    [self configureCell:cell atIndex:index];
    
    return cell;
}

/**
 @brief Create the cells for the Artist.
 @author : Rémi Lavedrine
 @date : 18/01/2014
 @remarks : <#(optional)#>
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case SearchArtistsResultCellSection:
            cell = [self tableView:tableView artistCellForRowAtIndex:indexPath.row];
            break;
            
        default:
            break;
    }
    
    return cell;
}


#pragma mark - Cell Selection

/**
 @brief Push the AlbumViewController for an artist.
 @author : Rémi Lavedrine
 @date : 19/01/2014
 @remarks : <#(optional)#>
 */
- (void)pushAlbumViewControllerForArtist:(NSDictionary *)artistDict {
    FirstAlbumForArtistViewController *controller = [[FirstAlbumForArtistViewController alloc] initWithNibName:@"FirstAlbumForArtistViewController"
                                                                                                        bundle:nil
                                                                                                    artistDict:artistDict];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *artistDict = nil;
    
    switch (indexPath.section) {
        case SearchArtistsResultCellSection:
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            artistDict = [self.artistsArray objectAtIndex:indexPath.row];
            [self pushAlbumViewControllerForArtist:artistDict];
            break;
            
        default:
            break;
    }
}


#pragma mark - Search Artist Action

/**
 @brief Remove the Keyboard and search asynchronously for the Artist.
 @author : Rémi Lavedrine
 @date : 18/01/2014
 @remarks : <#(optional)#>
 */
- (IBAction)searchArtist {
    [self.searchArtistTextField resignFirstResponder];
    
    // Show the spinner to notify the user that something is processing.
    [self.searchArtistButton setHidden:YES];
    [self.searchArtistRequestActivityIndicator setHidden:NO];
    
    // Search asychronously for the artists.
    [[DeezerSession sharedInstance] searchAsynchronouslyArtist:self.searchArtistTextField.text
                                             completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                                                 if (connectionError == nil) {
                                                     NSError* error;
                                                     NSDictionary* json = [NSJSONSerialization
                                                                           JSONObjectWithData:data // 1
                                                                           options:kNilOptions
                                                                           error:&error];
                                                     BOOL isValidJSONObject = [NSJSONSerialization isValidJSONObject:json];
                                                     NSLog(@"GET isValidJSONObject : %@", isValidJSONObject ? @"YES":@"NO");
                                                     
                                                     if (isValidJSONObject) {
                                                         NSLog(@"Response = %@", json);
                                                         
                                                         [self.artistsArray removeAllObjects];
                                                         self.artistsArray = [NSMutableArray arrayWithArray:[json objectForKey:@"data"]];
                                                         
                                                         [self.artistsTableView reloadData];
                                                         [self.searchArtistButton setHidden:NO];
                                                         [self.searchArtistRequestActivityIndicator setHidden:YES];
                                                     }
                                                 } else {
                                                     NSLog(@"Error");
                                                 }
                                             }];
}


@end
