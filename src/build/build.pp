node default {
  include phpfarm::php
  include phpfarm::php::extension::xdebug
  include phpfarm::php::extension::zend_debugger
}
