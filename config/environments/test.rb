Rails.application.configure do
  config.image_urls = {
    weight_lifting: "http://www.officialcollegelife.com/wp-content/uploads/2013/02/alabama-weight-room.jpg",
    basketball: "http://betterlivingpatios.com/wp-content/uploads/2014/04/Custom-Lighting-Ideas-for-Modern-Outdoor-Patio-Basketball-Court.jpg",
    tennis: "http://www.bbc.co.uk/blogs/webwise/blog-tennis.jpg",
    spin: "http://heuserhealth.com/wp-content/uploads/2014/01/iStock_000012790937Medium.jpg",
    running: "https://res.cloudinary.com/mapmyfitness/image/upload/f167687b598b4deb85a33a0af8d0083c",
    soccer: "http://rezatehranicohen.info/wp-content/uploads/rezatehranicohen-info/sites/593/Document.jpeg",
    crossfit: "http://crossfitmonarchy.com/wp-content/uploads/2013/01/1BAPOD-Wallpaper-GoalsAchievement-1024x681-1.jpg",
    yoga: "http://cdn.funcheap.com/wp-content/uploads/2015/08/Yoga-Class-Beach-6601.jpg",
    hiking: "http://www.lakearrowhead.com/img/hiking/hikers3.jpg",
    racquetball: "http://www.thejungleclub.com/wp-content/uploads/2014/12/racqtball-play.jpg"
  }
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static file server for tests with Cache-Control for performance.
  config.serve_static_files   = true
  config.static_cache_control = 'public, max-age=3600'

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Randomize the order test cases are executed.
  config.active_support.test_order = :random

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
