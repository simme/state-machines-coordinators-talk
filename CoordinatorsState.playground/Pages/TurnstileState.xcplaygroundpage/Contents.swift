//: Playground - noun: a place where people can play

enum TurnstileState: StateType {
    case locked(currentCredit: Int)
    case open
    indirect case broken(previousState: TurnstileState)

    enum Event {
        case insertCoin(amount: Int)
        case admitPerson
        case turnstileBroke
        case repairsComplete
    }

    enum Command {
        case soundAlarm
        case closeDoors
        case openDoors
    }

    static let initialState: TurnstileState = .locked(currentCredit: 0)

    private static let farePrice = 50

    mutating func handle(_ event: Event) -> Command? {
        switch (self, event) {
        case (.locked(let credit), .insertCoin(let amount)):
            let newCredit = credit + amount
            if newCredit >= TurnstileState.farePrice {
                self = .open
                return .openDoors
            } else {
                self = .locked(currentCredit: newCredit)
            }

        case (.locked, .admitPerson):
            return .soundAlarm

        case (.locked, .turnstileBroke),
             (.open, .turnstileBroke):
            self = .broken(previousState: self)

        case (.open, .admitPerson):
            self = .locked(currentCredit: 0)
            return .closeDoors

        case (.broken(let previous), .repairsComplete):
            self = previous

        default:
            fatalError("Event not valid with current state.")
        }

        return nil
    }
}
