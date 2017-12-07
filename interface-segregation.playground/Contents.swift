import Foundation

protocol Acceleratable {
    var speed: Float { get set }
}

protocol Speedometer {
    var speed: Float { get }
}

protocol Transmission {
    var currentGear: Int { get }
    var numberOfGears: Int { get }
    
    func shiftUp()
    func shiftDown()
}

protocol Radio {
    var radioOn: Bool { get }
    var radioStation: String { get }
}

class SixSpeedTransmission: Transmission {
    var currentGear: Int = 1
    var numberOfGears: Int { return 6 }
    
    func shiftUp() {
        guard currentGear < numberOfGears else { return }
        currentGear += 1
    }
    
    func shiftDown() {
        guard currentGear > 1 else { return }
        currentGear -= 1
    }
}

class Car: Speedometer, Acceleratable, Radio {
    var speed: Float = 0
    var headlightsOn: Bool = false
    var brightsOn: Bool = false
    var radioOn: Bool = false
    var radioStation: String = "97.1"
    
    var transmission = SixSpeedTransmission()
}

class SpeedRegulator {
    var car: Acceleratable
    let maxSpeed: Float
    
    init(car: Acceleratable, maxSpeed: Float) {
        self.car = car
        self.maxSpeed = maxSpeed
    }
    
    func update() {
        if car.speed > maxSpeed {
            car.speed = maxSpeed
        }
    }
}

class TransmissionController {
    let transmission: Transmission
    let speedometer: Speedometer
    
    init(transmission: Transmission, speedometer: Speedometer) {
        self.transmission = transmission
        self.speedometer = speedometer
    }
    
    func update() {
        if speedometer.speed > maxSpeed(for: transmission.currentGear) {
            transmission.shiftUp()
        } else if transmission.currentGear > 1 && speedometer.speed < maxSpeed(for: transmission.currentGear - 1) {
            transmission.shiftDown()
        }
    }
    
    private func maxSpeed(for gear: Int) -> Float {
        return Float(gear) * 17.5
    }
}

class RadioController {
    init(radio: Radio) {
        //
    }
}

let car = Car()
let txController = TransmissionController(transmission: car.transmission, speedometer: car)
car.speed = 36
print("Gear: \(car.transmission.currentGear)")
txController.update()
print("Gear: \(car.transmission.currentGear)")
txController.update()
print("Gear: \(car.transmission.currentGear)")
txController.update()
print("Gear: \(car.transmission.currentGear)")
