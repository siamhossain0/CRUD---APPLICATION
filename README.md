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
## Getting Started

### Prerequisites

To run this project, you need to have Flutter installed. If Flutter is not installed on your machine, follow the instructions [here](https://flutter.dev/docs/get-started/install).

### Installation

1. Clone this repository:

```bash
git clone https://github.com/your-username/crudapp.git
```

2. Navigate to the project directory:

```bash
cd crudapp
```

3. Install the required dependencies:

```bash
flutter pub get
```

4. Run the application:

```bash
flutter run
```

### Backend Setup

The application interacts with a REST API hosted at `http://164.68.107.70:6060/api/v1/`. Ensure that this API is running and accessible.
API endpoints used in this project:

- `GET /api/v1/ReadProduct`: Fetches the list of products.
- `POST /api/v1/CreateProduct`: Creates a new product.
- `POST /api/v1/UpdateProduct/{id}`: Updates an existing product.
- `GET /api/v1/DeleteProduct/{id}`: Deletes a product.

