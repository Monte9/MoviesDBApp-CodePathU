//
//  MovieInfoViewController.swift
//  Project1-FlickM
//
//  Created by Monte's Pro 13" on 1/18/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit
import MBProgressHUD

class MovieInfoViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie : NSDictionary!
    var detailMovie : NSDictionary!
    var movieID : Int!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var movieLengthLabel: UILabel!
    
    @IBOutlet weak var tagIineLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var popularLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: 800)
            //infoView.frame.origin.y + infoView.frame.size.height)

        movieID = movie["id"] as! Int
        print(movieID)
        
        getMovieInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMovieInfo() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            if (responseDictionary["status_code"] == nil ) {
                                
                                self.detailMovie = responseDictionary
                                print("Connection to API successful! here....")
                                print(self.detailMovie)
                            
                                //set all the labels
                                
                                self.titleLabel.text = self.detailMovie["title"] as? String
                                self.overviewLabel.text = self.detailMovie["overview"] as? String
                                self.overviewLabel.sizeToFit()
                                
                                self.popularLabel.text = String(self.detailMovie["popularity"] as! Int * 10) +  " %"
                                self.ratingLabel.text = String(self.detailMovie["vote_average"] as! Int) + "/10"
                                
                                self.movieLengthLabel.text = String(self.detailMovie["runtime"] as! Int) + " mins"
                                
                                self.tagIineLabel.text = self.detailMovie["tagline"] as! String
                                
                              //  self.genreLabel.text = self.detailMovie["genres.name"] as? String
                                print(self.detailMovie["genres"])
                                
                                let baseImageURL = "http://image.tmdb.org/t/p/w500/"
                                
                                if let imagePath = self.detailMovie["backdrop_path"] as? String {
                                    let imageURL = NSURL(string: baseImageURL + imagePath)
                                    self.posterImageView.setImageWithURL(imageURL!)
                                }

                                
                            }
                            else {
                                print("error")
                            }
                            // Hide HUD once network request comes back (must be done on main UI thread)
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                    }
                }
        });
        task.resume()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
