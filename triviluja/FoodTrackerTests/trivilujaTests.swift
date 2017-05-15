import XCTest
@testable import triviluja

class trivilujaTests: XCTestCase {
    
    //MARK: preguntas Class Tests
    
    
    // Confirm that the pregunta initializer returns a pregunta object when passed valid parameters.
    func testpreguntaInitializationSucceeds() {
        
        // Zero rating
        let zeroRatingMeal = Puntuacion.init(fecha: "Zero", puntos: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        // Highest positive rating
        let positiveRatingMeal = Puntuacion.init(fecha: "Positive", puntos: 5)
        XCTAssertNotNil(positiveRatingMeal)
        
        
    }
    
    
    
    // Confirm that the pregunta initialier returns nil when passed an empty name.
    func testpreguntalInitializationFails() {
        
        // Negative rating
        let negativeRatingMeal = Puntuacion.init(fecha: "Negative", puntos: -1)
        XCTAssertNil(negativeRatingMeal)
        
        // Empty String
        let emptyStringMeal = Puntuacion.init(fecha: "", puntos: 0)
        XCTAssertNil(emptyStringMeal)
        
        // Rating exceeds maximum
        let largeRatingMeal = Puntuacion.init(fecha: "Large", puntos: 60000)
        XCTAssertNil(largeRatingMeal)
    }
    

    


    
}
