# CRUD App

This is a simple Flutter-based CRUD (Create, Read, Update, Delete) application that allows users to manage products. The app interacts with a backend server to perform CRUD operations on a product database.

## Features

- **Create Products**: Add new products with details such as name, code, unit price, quantity, and total price.
- **Read Products**: View a list of all the products.
- **Update Products**: Modify the details of existing products.
- **Delete Products**: Remove a product from the list.

## Project Structure

```
├── lib
│   ├── models
│   │   └── product.dart            # Defines the Product model
│   ├── screens
│   │   ├── add_new_productScreen.dart  # Screen for adding a new product
│   │   ├── productlist_scrren.dart     # Screen displaying list of products
│   │   └── update_product_Screen.dart  # Screen for updating an existing product
│   ├── widgets
│   │   └── product_item.dart       # Widget to display individual product item
│   └── app.dart                    # Main app widget
├── main.dart                       # Application entry point
├── pubspec.yaml                    # Project configuration and dependencies
```
