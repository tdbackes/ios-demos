import UIKit

class BottomBar: UIView {

    private let scrollView = UIScrollView()
    private var models: [Model]!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(frame: CGRect, models: [Model]) {
        super.init(frame: frame)
        self.models = models
        getModels()
        setUpViews()
        setUpLayout()
    }
    
    private func getModels() {
        let modelFactory = ModelFactory()
        models = modelFactory.parseJSON()
    }

    private func setUpViews() {
        addModelButtons()
        addSubview(scrollView)
    }

    private func setUpLayout() {
        applyConstraint(for: .top)
        applyConstraint(for: .right)
        applyConstraint(for: .bottom)
        applyConstraint(for: .left)
    }
    
    private func applyConstraint(for attribute: NSLayoutAttribute) {
        let constraint = NSLayoutConstraint(item: scrollView,
                                  attribute: attribute,
                                  relatedBy: .equal,
                                  toItem: self,
                                  attribute: attribute,
                                  multiplier: 1,
                                  constant: 0)
        
        scrollView.addConstraint(constraint)
    }

    func addModelButtons() {
        let height = scrollView.bounds.height
        let width = scrollView.bounds.width/4
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        models.forEach { model in
            let modelButton = UIButton(frame: frame)
            modelButton.backgroundColor = .lightGray
            modelButton.setTitle(model.fileName, for: .normal)
            scrollView.addSubview(modelButton)
        }
    }
}