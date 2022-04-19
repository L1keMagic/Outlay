import Foundation

class ExpenceRepository {
    static let shared = ExpenceRepository()
    var expences: Expences = []
    func getExpences() -> Expences {
        // this condition will be removed when we add 'add' functionality
        if(expences.isEmpty) {
            let currectDate = DateManager()
            expences.append(Expence(id: 1,
                                    title: "Хлеб",
                                    price: 100,
                                    categoryId: nil,
                                    creationDate: currectDate.getCurrentDate()))
            expences.append(Expence(id: 2,
                                    title: "Соль",
                                    price: 15000,
                                    categoryId: nil,
                                    creationDate: currectDate.getCurrentDate()))
            expences.append(Expence(id: 1,
                                    title: "Пицца",
                                    price: 123,
                                    categoryId: nil,
                                    creationDate: currectDate.getCurrentDate()))
        }
        return expences
    }
}
