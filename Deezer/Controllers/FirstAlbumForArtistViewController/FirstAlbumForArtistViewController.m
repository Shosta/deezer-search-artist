//
//  FirstAlbumForArtistViewController.m
//  Deezer
//
//  Created by Rems on 18/01/2014.
//  Copyright (c) 2014 RemiLavedrine. All rights reserved.
//

#import "FirstAlbumForArtistViewController.h"
#import "DeezerSession.h"
#import "UIImageView+WebCache.h"
#import "PlayTrackViewController.h"

@interface FirstAlbumForArtistViewController ()

@property (nonatomic, retain) NSMutableArray *tracksArray;
@property (nonatomic, retain) NSDictionary *artistDict;
@property (nonatomic, retain) NSURL *albumCoverURL;

@end

@implementation FirstAlbumForArtistViewController


#pragma mark - Object

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil artistDict:(NSDictionary *)aArtistDict {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.artistDict = aArtistDict;
        self.tracksArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return self;
}


#pragma mark - View

/**
 @brief Set a white view as a footer for the remaining height if there is not enough tracks to be over the album cover.
 @author : Rémi Lavedrine
 @date : 18/01/2014
 @remarks : <#(optional)#>
 */
- (void)addFooterOnTableView {
    float footerHeight = 0;
    
    float tableViewSecondSectionOrigin = 64 + self.albumDetailContainerView.frame.size.height;
    float rowsHeight = self.tracksArray.count * 44;
    
    if (self.view.frame.size.height > tableViewSecondSectionOrigin + rowsHeight) {
        footerHeight = self.view.frame.size.height - (tableViewSecondSectionOrigin + rowsHeight);
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, footerHeight)];
    [view setBackgroundColor:[UIColor whiteColor]];
    self.albumTracksForArtistTableView.tableFooterView = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set the navigationBar title with the artist's name.
    NSString *artistName = [self.artistDict objectForKey:kArtistNameKey];
    [self.navigationItem setTitle:artistName];
    
    // Search for one of the artist's album.
    [self searchArtistAlbum:[self.artistDict objectForKey:kArtistIdKey]];
    
    // Set the image for the artist.
    [self.artistImageView setImageWithURL:[self.artistDict objectForKey:kArtistImageUrlKey]
                         placeholderImage:ARTIST_PLACEHOLDER_IMAGE];
    
    
    // Set a white view as a footer.
    [self addFooterOnTableView];
}


//! Search Artist section numbers.
typedef enum{
    AlbumDetailCellSection = 0,
    AlbumTracksResultCellSection = 1,
    AlbumCellSectionCount
}ArtistsCellSectionNumbers;

#pragma mark - Header Height

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    float headerHeight = 0.0;
    
    switch (section) {
        case AlbumDetailCellSection:
            headerHeight = self.albumDetailContainerView.frame.size.height;
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
        case AlbumDetailCellSection:
            headerView = self.albumDetailContainerView;
            break;
            
        default:
            break;
    }
    
    return headerView;
}


#pragma mark - Cell Count

- (int)numberOfSectionsInTableView:(UITableView *)tableView{
    return AlbumCellSectionCount;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int rowNumber = 0;
    switch (section) {
        case AlbumCellSectionCount:
            rowNumber = 0;
            break;
            
        case AlbumTracksResultCellSection:
            rowNumber = self.tracksArray.count;
            break;
            
        default:
            break;
    }
    
    return rowNumber;
}


#pragma mark - Cell

/**
 @brief Configure the cell according to the track's dictionary object.
 @author : Rémi Lavedrine
 @date : 18/01/2014
 @remarks : <#(optional)#>
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSString *trackName = [[self.tracksArray objectAtIndex:indexPath.row] objectForKey:kTrackTitleKey];
    [cell.textLabel setText:trackName];
}

/**
 @brief Create the cells for the Album's Tracks.
 @author : Rémi Lavedrine
 @date : 18/01/2014
 @remarks : <#(optional)#>
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"TrackCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


#pragma mark - Cell Selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == AlbumTracksResultCellSection) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        // Push the PlayViewController for the selected track.
        NSDictionary *trackDict = [self.tracksArray objectAtIndex:indexPath.row];
        PlayTrackViewController *playViewController = [[PlayTrackViewController alloc] initWithNibName:@"PlayTrackViewController"
                                                                                                bundle:nil
                                                                                        artistImageUrl:[self.artistDict objectForKey:kArtistImageUrlKey]
                                                                                         albumCoverUrl:self.albumCoverURL
                                                                                             trackDict:trackDict];
        [self.navigationController pushViewController:playViewController animated:YES];
    }
}


#pragma mark - Search Artist Album Tracks

/**
 @brief Get the artist albums. Get the first one if any and then download the tracks for them asynchronously and reload the Tracks TableView.
 @author : Rémi Lavedrine
 @date : 18/01/2014
 @remarks : <#(optional)#>
 */
- (IBAction)searchArtistAlbum:(NSString *)artistId {
    [[DeezerSession sharedInstance] searchAsynchronouslyArtistAlbum:artistId
                                                  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                                                      NSError* error;
                                                      
                                                      NSDictionary* json = [NSJSONSerialization
                                                                            JSONObjectWithData:data // 1
                                                                            options:kNilOptions
                                                                            error:&error];
                                                      BOOL isValidJSONObject = [NSJSONSerialization isValidJSONObject:json];
                                                      NSLog(@"Albums isValidJSONObject : %@", isValidJSONObject ? @"YES":@"NO");
                                                      
                                                      // Get the artist albums.
                                                      NSMutableArray *artistAlbumsArray = [NSMutableArray arrayWithArray:[json objectForKey:@"data"]];
                                                      
                                                      // Get the first one if any and then download the tracks for them asynchronously and reload the Tracks TableView.
                                                      if (artistAlbumsArray.count > 1 ) {
                                                          NSDictionary *artistFirstAlbumDict = [artistAlbumsArray objectAtIndex:0];
                                                          
                                                          self.albumCoverURL = [artistFirstAlbumDict objectForKey:kAlbumCoverKey];
                                                          [self.albumCoverImageView setImageWithURL:[artistFirstAlbumDict objectForKey:kAlbumCoverKey]
                                                                                   placeholderImage:ARTIST_PLACEHOLDER_IMAGE];
                                                          [self.albumTitleLabel setText:[artistFirstAlbumDict objectForKey:kAlbumTitleKey]];
                                                          
                                                          [self tracksForAlbum:[artistFirstAlbumDict objectForKey:kAlbumIdKey]];
                                                      }
                                                  }];
}

/**
 @brief Get the tracks for them asynchronously and reload the Tracks TableView.
 @author : Rémi Lavedrine
 @date : 18/01/2014
 @remarks : <#(optional)#>
 */
- (void)tracksForAlbum:(NSString *)albumId {
    [[DeezerSession sharedInstance] searchAsynchronouslyAlbumTracks:albumId
                                                  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                                                      NSError* error;
                                                      NSDictionary* json = [NSJSONSerialization
                                                                            JSONObjectWithData:data // 1
                                                                            options:kNilOptions
                                                                            error:&error];
                                                      BOOL isValidJSONObject = [NSJSONSerialization isValidJSONObject:json];
                                                      NSLog(@"Tracks isValidJSONObject : %@", isValidJSONObject ? @"YES":@"NO");
                                                      
                                                      [self.tracksArray removeAllObjects];
                                                      self.tracksArray = [NSMutableArray arrayWithArray:[json valueForKeyPath:@"tracks.data"]];
                                                      [self.albumTracksForArtistTableView reloadData];
                                                      [self addFooterOnTableView];
                                                  }];
}


@end
