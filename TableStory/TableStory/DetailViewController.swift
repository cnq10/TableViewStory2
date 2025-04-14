//
//  DetailViewController.swift
//  TableStory
//
//  Created by Olivia Korte on 3/23/25.
//

import UIKit
import MapKit



class DetailViewController: UIViewController {
    var item: Item?
    
    
    
    @IBOutlet weak var detailName: UILabel!
    
    @IBOutlet weak var detailDesc: UILabel!
    
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var neighborhood: UILabel!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item {
            detailName.text = item.name
            detailDesc.text = item.desc
            neighborhood.text = item.neighborhood
            detailImage.image = UIImage(named: item.imageName)
        } else {
            print("Item is nil") // Check if 'item' is being passed correctly
        }
            
            // code for map
            let coordinate = CLLocationCoordinate2D(latitude: item!.lat, longitude: item!.long)
            
            // Create a region centered on your coordinate with a certain span
            let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            // Set the region of the map view
            mapView.setRegion(region, animated: true)
            
            // Create a map annotation for your location
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = item?.name
            
            // Add the annotation to the map view
            mapView.addAnnotation(annotation)

            
        }
        
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }

