Tinder gets you started. 
========================

Current version: Rails 3.2.8

Tinder currently includes:
--------------------------

* Devise authentication 
* CanCan authorization based on user roles
* Blogging with comments using Redcarpet markdown
* Rspec and capybara tests with guard and launchy for on-the-fly testing and debugging
* formalize UI
* modernizr JS library for handling old browsers
* HTML5 markup with responsive grid-based layouta

Things when launching a new site with Tinder
--------------------------------------------

* Update initial settings in /config/settings.yml and each setting file in /config/settings/*.yml
* Create git-ignored local settings (such as omniauth keys and secretes) with /config/settings/<environment>.local.yml
* Add your capybara deploy script
