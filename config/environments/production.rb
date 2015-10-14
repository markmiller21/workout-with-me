Rails.application.configure do
  config.image_urls = {
    weight_lifting: "http://www.officialcollegelife.com/wp-content/uploads/2013/02/alabama-weight-room.jpg",
    basketball: "http://betterlivingpatios.com/wp-content/uploads/2014/04/Custom-Lighting-Ideas-for-Modern-Outdoor-Patio-Basketball-Court.jpg",
    tennis: "http://ferrisracquetandfitness.com/wp-content/themes/DPCrqt/images/Facility_Placeholder.jpg",
    spin: "http://heuserhealth.com/wp-content/uploads/2014/01/iStock_000012790937Medium.jpg",
    running: "https://res.cloudinary.com/mapmyfitness/image/upload/f167687b598b4deb85a33a0af8d0083c",
    soccer: "http://rezatehranicohen.info/wp-content/uploads/rezatehranicohen-info/sites/593/Document.jpeg",
    crossfit: "http://crossfitmonarchy.com/wp-content/uploads/2013/01/1BAPOD-Wallpaper-GoalsAchievement-1024x681-1.jpg",
    yoga: "http://cdn.funcheap.com/wp-content/uploads/2015/08/Yoga-Class-Beach-6601.jpg",
    hiking: "http://www.lakearrowhead.com/img/hiking/hikers3.jpg",
    racquetball: "http://www.thejungleclub.com/wp-content/uploads/2014/12/racqtball-play.jpg"
  }
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like
  # NGINX, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
