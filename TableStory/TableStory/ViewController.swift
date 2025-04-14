import UIKit
import MapKit



// Define the data model for items in the table view
struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    let data = [
        Item(name: "Flowers Hall", neighborhood: "Texas State University Campus", desc: "A historic campus building with quiet study areas and nearby greenspaces.", lat: 29.889057106627064, long: -97.94024557510834, imageName: "flowershall"),
        Item(name: "Albert B. Alkek Library", neighborhood: "Texas State University Campus", desc: "A multi-level library packed with study nooks and creative spaces.", lat: 29.889664752388345, long: -97.94289662026559, imageName: "alkek"),
        Item(name: "New Braunfels Coffee", neighborhood: "489 Main Plaza, New Braunfels, TX 78130", desc: "A cozy coffee shop that is perfect for getting work done!", lat: 29.70377900090141, long: -98.12471149768001, imageName: "nbcafe"),
        Item(name: "San Marcos River", neighborhood: "650 River Rd, San Marcos, TX 78666", desc: "Discover a outdoor escape with shaded areas perfect for working outdoors!", lat: 29.91326623826592, long: -97.93792334153291, imageName: "park"),
        Item(name: "How to Find the Right Spot", neighborhood: "your home", desc: "Find your ideal work spot at home or in your backyard!", lat: 0, long: 0, imageName: "korte.backyard")
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        print("MapView is \(mapView == nil ? "nil" : "connected")")
        
        tableView.rowHeight = 80 // Adjust the height as needed

        // Set initial map center and zoom
        let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: true)

        // ✅ Store valid annotations
        var annotations = [MKPointAnnotation]()

        for item in data {
            // ✅ Skip (0,0) to prevent it from adding an unwanted pin
            if item.lat == 0 && item.long == 0 {
                print("Skipping annotation for \(item.name) because coordinates are (0,0)")
                continue
            }

            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
            annotation.title = item.name
            annotations.append(annotation)
        }

        // ✅ Add all annotations and adjust the map to fit them
        DispatchQueue.main.async {
            self.mapView.addAnnotations(annotations)
            self.mapView.showAnnotations(annotations, animated: true) // Ensures all pins are visible
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "theTable", for: indexPath)
        let item = data[indexPath.row]
        
        // Set text and increase font size
        cell.textLabel?.text = item.name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 22) // Makes the name bigger
        cell.textLabel?.numberOfLines = 2 // Allows text to wrap if it's long

        // Set detail text and adjust font size
        cell.detailTextLabel?.text = item.neighborhood
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16) // Makes details readable

        // Configure image view
        if let imageView = cell.imageView {
            let image = UIImage(named: item.imageName)
            imageView.image = image
            imageView.layer.cornerRadius = 10
            imageView.layer.borderWidth = 5
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.clipsToBounds = true // Ensures rounded corners are visible
        }


        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = data[indexPath.row]
        performSegue(withIdentifier: "ShowDetailSegue", sender: selectedItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                // Pass the selected item to the detail view controller
                detailViewController.item = selectedItem
            }
        }
    }
    
}
    
