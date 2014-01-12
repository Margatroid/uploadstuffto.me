# [uploadstuffto.me](http://uploadstuffto.me)

uploadstuffto.me is a clone of imgur.
[![Build Status](https://travis-ci.org/Margatroid/uploadstuffto.me.png)](https://travis-ci.org/Margatroid/uploadstuffto.me)

## Features

* Images can be shared with a unique short URL.
* Private images that cannot be attributed to a username.
* User galleries for public images and albums.
* Private and public albums for images with captions for each image.
* HTML5 multiple file upload and uploading from URL.
* Responsive layout with pure.
* Degrades gracefully when no JS is available.

## Installation

The only requirements you will need beforehand are git, bundler,
imagemagick (for thumbnail generation) and ruby 2.0.0p247 or above.

1. Clone repo.

        git clone https://github.com/Margatroid/uploadstuffto.me.git

2. Change directory to repo.

        cd uploadstuffto.me

3. Install required gems.

        bundle install

4. Setup development database. If you get an error about not being able
to find a JavaScript runtime, install NodeJS or add `therubyracer` to the
Gemfile and run bundler again.

        rake db:setup

5. Setup test database.

        RAILS_ENV=test rake db:setup

6. Run full test suite. Failing tests may be a sign that something
has gone wrong during the installation.

        rspec

7. Generate an invite for yourself so you can register a new account on the
development environment.

        rake 'invite:create[My first invite, 1]'

8. Start the development server. Go to `http://localhost:3000` in your browser.

        rails server
