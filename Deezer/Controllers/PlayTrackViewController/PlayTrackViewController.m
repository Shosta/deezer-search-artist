//
//  PlayTrackViewController.m
//  Deezer
//
//  Created by Rems on 18/01/2014.
//  Copyright (c) 2014 RemiLavedrine. All rights reserved.
//

#import "PlayTrackViewController.h"
#import "UIImageView+WebCache.h"

@interface PlayTrackViewController ()

@property (nonatomic, retain) NSDictionary *trackDict;
@property (nonatomic, retain) NSURL *artistImageUrl;
@property (nonatomic, retain) NSURL *albumCoverURL;

@property (nonatomic, retain) AVAudioPlayer *player;

@end

@implementation PlayTrackViewController


#pragma mark - Object

/**
 @brief Constructor.
 @author : Rémi Lavedrine
 @date : 18/01/2014
 @remarks : <#(optional)#>
 */
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
       artistImageUrl:(NSURL *)aArtistImageUrl
        albumCoverUrl:(NSURL *)aAlbumCoverURL
            trackDict:(NSDictionary *)aTrackDict {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.trackDict = aTrackDict;
        self.artistImageUrl = aArtistImageUrl;
        self.albumCoverURL = aAlbumCoverURL;
    }
    
    return self;
}


#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set the navigationBar title with the track's title.
    NSString *trackTitle = [self.trackDict objectForKey:kTrackTitleKey];
    [self.navigationItem setTitle:trackTitle];
    [self.currentlyPlayingLabel setText:@"Loading"];
    
    // Set the image for the track's album and the album's artist.
    [self.artistImageView setImageWithURL:self.artistImageUrl
                         placeholderImage:ARTIST_PLACEHOLDER_IMAGE];
    [self.albumCoverImageView setImageWithURL:self.albumCoverURL
                             placeholderImage:ALBUM_PLACEHOLDER_IMAGE];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Launch the track playing.
    [self playTrack];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self stopAudio];
}


#pragma mark - Play

/**
 @brief Play the preview for this track.
 @author : Rémi Lavedrine
 @date : 19/01/2014
 @remarks : <#(optional)#>
 */
- (void)playTrack {
    NSURL *trackPreviewUrl = [NSURL URLWithString:[self.trackDict objectForKey:kTrackPreviewKey]];
    NSData *soundData = [NSData dataWithContentsOfURL:trackPreviewUrl];
    self.player = [[AVAudioPlayer alloc] initWithData:soundData error:NULL];
    
    [self.player setDelegate:self];
    [self playAudio];
}


#pragma mark - Interactive Playing Actions

/**
 @brief Play the audio  through an action.
 @author : Rémi Lavedrine
 @date : 19/01/2014
 @remarks : <#(optional)#>
 */
- (IBAction)playAudio {
    [self.player play];
    
    NSString *trackTitle = [self.trackDict objectForKey:kTrackTitleKey];
    [self.currentlyPlayingLabel setText:[NSString stringWithFormat:@"Currently playing\n%@", trackTitle]];
}

/**
 @brief Stop the audio  through an action.
 @author : Rémi Lavedrine
 @date : 19/01/2014
 @remarks : <#(optional)#>
 */
- (IBAction)stopAudio {
    [self.player stop];
    
    [self.currentlyPlayingLabel setText:@"Pause"];
}

@end
