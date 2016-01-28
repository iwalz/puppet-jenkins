# This class should be considered private
#
class jenkins::config {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  create_resources( 'jenkins::sysconfig', $::jenkins::config_hash )
  if ! has_key($::jenkins::config_hash, 'JENKINS_HOME') {
    jenkins::sysconfig {'JENKINS_HOME':
      value => $::jenkins::localstatedir,
    }
  }

}
