# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [X] Use ActiveRecord for storing information in a database -- set up ActiveRecord base in config/environment, all models inheret from ActiveRecord::Base
- [X] Include more than one model class (e.g. User, Post, Category) -- app has User, Recipe, and SavedRecipe models
- [X] Include at least one has_many relationship on your User model (e.g. User has_many Posts) -- User has many recipes they created as well as many recipes through saved recipes. Recipes belong to one user and also have many users through saved recipes.
- [X] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) -- Recipe belongs to user, saved recipes belongs to user and to recipe.
- [X] Include user accounts with unique login attribute (username or email) -- User sign-up form requires input, User model validates presence and uniqueness, custom error (flash message) shows up if user sign up cannot be persisted to the database.
- [X] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying -- Recipe has full CRUD, highlighted in recipe controller with commented-out text
- [X] Ensure that users can't modify content created by other users -- views use "if" statement to show edit and delete buttons only to the user that the recipe belongs to. Also the recipe controller only renders the edit page if the user's id matches the recipe id they try to edit, otherwise it redirects to the recipe's show page.
- [X] Include user input validations -- Models validate the presence of content, error (flash message) is shown if the record cannot be persisted to the database.
- [X] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) -- used Rack Flash for error messages
- [X] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code -- Looked at other students' README from previous cohorts and formatted mine to include similar information.

Confirm
- [X] You have a large number of small Git commits -- had one day of working where I forgot to commit for most of the day, unfortunately. Tried to commit as often as possible as soon as I realized my error.
- [X] Your commit messages are meaningful -- Yes
- [X] You made the changes in a commit that relate to the commit message -- Yesy
- [X] You don't include changes in a commit that aren't related to the commit message -- Yes