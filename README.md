#  MovieList

A simple project that displays movies.

# Description

The Movie List project is a simple project to list movies and make favourite list. 
The project consists of a TMDB api to fetch movoes and use coredata to save favorite list.

# Getting started

1. Make sure you have the OS version 14.0 or above installed on your computer.
2. Download the MovieList project files from the repository.
3. Open the MovieList.xcodeproj.
4. Run the active scheme.
5. You should see the list of movies as the home page with search bar and favourite button.
6. click the movie to see detail page and button to save movies to the favorite list.

# Architecture

1. Movie List project is implemented using the Model-View-Controller (MVC) architecture pattern.
2. Model has any necessary data or business logic needed to generate the Movie List.
3. View is responsible for displaying the list to the user, such as details of the movie.
4. Controller handles any user input or interactions and update the Model and View as needed.
5. Project have a rest api service and coredata for fetch, save and delete data and user interface also.

# Structure
"Common": Files or resources that are shared across multiple parts of the project. Such as utility classes, global constants, or reusable Ul elements.
"Modules": The source code files for a specific module. Files within a module folder are organized into subfolders, such as "Views" or "Models".
"Resources": Non-code files that are used by the project. These can include core data databsae, and other types of assets.
"Service": Files or classes related to communicating with an external API. This could include code for making HTTP requests to a web server, parsing responses, and handling any errors that may occur.
