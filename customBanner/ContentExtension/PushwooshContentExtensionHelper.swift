//
//  PushwooshContentExtensionHelper.swift
//  ContentExtension
//
//  Created by André Kis on 18.11.25.
//

import UIKit
import UserNotifications

public class PushwooshContentExtensionHelper {

    public static func handleContentExtension(
        request: UNNotificationRequest,
        in viewController: UIViewController,
        completion: @escaping (Bool) -> Void
    ) {
        guard let imageURL = extractExpandedImageURL(from: request) else {
            completion(false)
            return
        }

        let title = request.content.title
        let body = request.content.body

        loadImage(from: imageURL) { image in
            DispatchQueue.main.async {
                if let image = image {
                    self.displayRichContent(
                        image: image,
                        title: title,
                        body: body,
                        in: viewController
                    )
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }

    private static func extractExpandedImageURL(from request: UNNotificationRequest) -> URL? {
        let userInfo = request.content.userInfo

        guard let aps = userInfo["aps"] as? [String: Any],
              let urlString = aps["ios_expanded_image_url"] as? String,
              let url = URL(string: urlString) else {
            return nil
        }

        return url
    }

    private static func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }

    private static func displayRichContent(
        image: UIImage,
        title: String,
        body: String,
        in viewController: UIViewController
    ) {
        viewController.view.subviews.forEach { $0.removeFromSuperview() }

        // Background image
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(imageView)

        // Gradient overlay
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.3).cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]

        let gradientView = UIView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.layer.addSublayer(gradientLayer)
        viewController.view.addSubview(gradientView)

        // Content container
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 16
        contentStack.alignment = .leading
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(contentStack)

        // Title label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.shadowColor = .black
        titleLabel.shadowOffset = CGSize(width: 0, height: 1)
        contentStack.addArrangedSubview(titleLabel)

        // Body label
        let bodyLabel = UILabel()
        bodyLabel.text = body
        bodyLabel.font = .systemFont(ofSize: 15, weight: .regular)
        bodyLabel.textColor = .white
        bodyLabel.numberOfLines = 3
        bodyLabel.shadowColor = .black
        bodyLabel.shadowOffset = CGSize(width: 0, height: 1)
        contentStack.addArrangedSubview(bodyLabel)

        // Buttons container
        let buttonsStack = UIStackView()
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 12
        buttonsStack.distribution = .fillEqually
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(buttonsStack)

        // View Details button
        let viewButton = createButton(title: "View Details", isPrimary: true)
        buttonsStack.addArrangedSubview(viewButton)

        // Dismiss button
        let dismissButton = createButton(title: "Later", isPrimary: false)
        buttonsStack.addArrangedSubview(dismissButton)

        // Constraints
        let contentTopConstraint = contentStack.topAnchor.constraint(greaterThanOrEqualTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: 20)
        contentTopConstraint.priority = .defaultLow

        NSLayoutConstraint.activate([
            // Image view - full screen
            imageView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),

            // Gradient overlay - full screen
            gradientView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),

            // Content stack - bottom area with top limit
            contentTopConstraint,
            contentStack.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -24),

            // Buttons stack - bottom
            buttonsStack.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 20),
            buttonsStack.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -20),
            buttonsStack.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonsStack.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Update gradient frame
        DispatchQueue.main.async {
            gradientLayer.frame = gradientView.bounds
        }
    }

    private static func createButton(title: String, isPrimary: Bool) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true

        if isPrimary {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
        } else {
            button.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            button.setTitleColor(.white, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        }

        return button
    }
}
