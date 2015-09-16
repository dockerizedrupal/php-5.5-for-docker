class build {
  require build::user

  include build::php55
  include build::php55::extensions
  include build::freetds
  include build::composer
  include build::drush
  include build::phpcs
  include build::phpcs::phpcompatibility
  include build::phpcs::coder
  include build::postfix
  include build::cron
}
