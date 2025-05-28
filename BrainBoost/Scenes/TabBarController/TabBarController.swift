import UIKit

final class TabBarController: UITabBarController {

    static var height: CGFloat {
        Constants.isSE ? 45 : 70
    }

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .purpleNormal
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var indicatorViewCenterXConstraint: NSLayoutConstraint?

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundView.layer.cornerRadius = backgroundView.frame.height / 2
        indicatorView.layer.cornerRadius = indicatorView.frame.height / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages(pages: RootTabBarItem.allCases)

        tabBar.tintColor = .black
        tabBar.isHidden = true

        setupLayout()
        setupConstraints()
    }

    private func setupLayout() {
        backgroundView.addSubview(indicatorView)
        backgroundView.addSubview(stackView)

        view.addSubview(backgroundView)
    }

    private func setupPages(pages: [RootTabBarItem]) {
        for page in pages {
            let tabItem = createTabItem(item: page)
            stackView.addArrangedSubview(tabItem)
        }

        if let firstPage = stackView.arrangedSubviews.first as? RootTabBarView {
            firstPage.isActive = true
        }
    }

    private func createTabItem(item: RootTabBarItem) -> RootTabBarView {
        let tabView = RootTabBarView(item: item)

        tabView.onTap = {[weak self] selectedItem in
            guard let self else { return }

            self.stackView.arrangedSubviews.forEach {
                guard let tabBarItem = $0 as? RootTabBarView else { return }
                tabBarItem.isActive = tabBarItem == selectedItem
            }

            self.animateIndicator(to: selectedItem)
            self.selectedIndex = RootTabBarItem.tabIndex(of: item)
        }
        return tabView
    }

    private func animateIndicator(to item: UIView) {
        indicatorViewCenterXConstraint?.isActive = false
        indicatorViewCenterXConstraint = indicatorView.centerXAnchor.constraint(equalTo: item.centerXAnchor)
        indicatorViewCenterXConstraint?.isActive = true

        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5,
            options: [.curveEaseInOut]
        ) {
            self.view.layoutIfNeeded()
        }
    }

    private func setupConstraints() {
        guard let first = stackView.arrangedSubviews.first else { return }

        indicatorViewCenterXConstraint = indicatorView.centerXAnchor.constraint(
            equalTo: first.centerXAnchor
        )

        indicatorViewCenterXConstraint?.isActive = true

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            backgroundView.heightAnchor.constraint(equalToConstant: TabBarController.height),

            stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),

            indicatorView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            indicatorView.widthAnchor.constraint(equalTo: indicatorView.heightAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
        ])
    }
}
