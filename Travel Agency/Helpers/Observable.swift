import Foundation

final class Observable<T> {
  
  var value: T? {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.listener?(self?.value)
      }
    }
  }
  
  init(_ value: T?) {
    self.value = value
  }
  
  private var listener: ((T?) -> Void)?
  
  func bind(_ listener: @escaping ((T?) -> Void)) {
    listener(value)
    self.listener = listener
  }
}
