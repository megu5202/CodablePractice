import Foundation

open class Operation: Foundation.Operation {

    fileprivate var _executing = false
    override open var isExecuting: Bool {
        get { return _executing }
        set {
            if _executing != newValue {
                willChangeValue(forKey: "isExecuting")
                _executing = newValue
                didChangeValue(forKey: "isExecuting")
            }
        }
    }

    fileprivate var _finished = false
    override open var isFinished: Bool {
        get { return _finished }
        set {
            if _finished != newValue {
                willChangeValue(forKey: "isFinished")
                _finished = newValue
                didChangeValue(forKey: "isFinished")

                if _finished == true {
                    isExecuting = false
                }
            }
        }
    }

    fileprivate var _cancelled = false
    override open var isCancelled: Bool {
        get { return _cancelled }
        set {
            if _cancelled != newValue {
                willChangeValue(forKey: "isCancelled")
                _cancelled = newValue
                didChangeValue(forKey: "isCancelled")
            }
        }
    }

    override open func cancel() {
        super.cancel()
        isCancelled = true
    }

    final override public func start() {
        guard isCancelled == false else {
            isFinished = true
            return
        }

        guard isExecuting == false else { return }

        isExecuting = true
        execute()
    }

    func execute() {
        main()
    }

    deinit {
        print("\(self) -- deinit")
    }
}
