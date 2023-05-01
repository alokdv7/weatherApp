////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////
///
import UIKit
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = {
        let instance = CoreDataManager()
        // setup code
        return instance
    }()
    
    private init() {}
    
    func saveWeatherModel(cityname:String,temp:Double,image:String,lat:Double,lon:Double) {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let weatherEntity = NSEntityDescription.entity(forEntityName: "WeatherEntity", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        let weather = NSManagedObject(entity: weatherEntity, insertInto: managedContext)
        weather.setValue(cityname, forKey: "cityName")
        weather.setValue(temp, forKey: "temp")
        weather.setValue(image, forKey: "image")
        weather.setValue(lat, forKey: "lat")
        weather.setValue(lon, forKey: "long")
        
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    func retriveWeatherModel() -> [WeatherEntity] {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherEntity")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result as! [WeatherEntity]
            
        } catch {
            
            print("Failed")
        }
        return []
    }
    func checkWeatherModel(cityName : String) -> Bool {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "WeatherEntity")
        fetchRequest.predicate = NSPredicate(format: "cityName = %@", cityName)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0{
                return true
            }
            else{
                return false
            }
            
        } catch {
            
            print("Failed")
        }
        return false
    }
    
    
    func updateCityName(cityName: String,temp:Double,image:String){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "WeatherEntity")
        fetchRequest.predicate = NSPredicate(format: "cityName = %@", cityName)
        do{
            let model = try managedContext.fetch(fetchRequest)
            let objectUpdate = model[0] as! NSManagedObject
            objectUpdate.setValue(temp, forKey: "temp")
            objectUpdate.setValue(image, forKey: "image")
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        
    }
    
}
