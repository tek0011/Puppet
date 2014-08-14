
# Installs and manages Java on Windows machines.
# $source should be set to the name of the .exe that will be copied over.
# $package should be the name of the installed program. Easiest way to figure this out is to install manually, then look at installed program list.
# $file should be equal to the name of the files that get created by the install, such as 'jdk1.7.0_55'. Used to set the path.
#
define windows_java::setup (
  $ensure        = 'present',
  $source        = undef,
  $file          = undef,
  $package       = undef ) {

define obsolete_java {
    windows_path {
       $name:
           ensure    => absent,
           directory => "C:\\Program Files\\Java\\$name\\bin";
    }


  case $::osfamily {
    Windows  : { $supported = true }
    default : { fail("The ${module_name} module is not supported on ${::osfamily} based systems") }
  }

  # Validate parameters
  if ($source == undef) {
    fail('source parameter must be set')
  }

  if ($file == undef) {
    fail('file parameter must be set')
  }

  if ($package == undef) {
    fail('package parameter must be set')
  }

  # Validate input values for $ensure
  if !($ensure in ['present', 'absent']) {
    fail('ensure must either be present or absent')
  }

  if ($caller_module_name == undef) {
    $mod_name = $module_name
  } else {
    $mod_name = $caller_module_name
  }

  if ($ensure == 'present'){
    # ensures main directory exists
    file {'C:\Program Files\Java':
      ensure => directory,
    }

    # copies source executable over
    file { "C:\\Program Files\\Java\\$source":
      ensure             => present,
      source             => "puppet:///extra_files/java/windows/$source",
      before             => Package["$package"],
      source_permissions => ignore,
    }

    # Name of package must match name when installed
    package { "$package":
      ensure             => installed,
      source             => "C:\\Program Files\\java\\$source",
      install_options    => '/s',
    }

    # sets JAVA_HOME. If already existant, replaces it.
    windows_env { "JAVA_HOME=C:\\Program Files\\Java\\$file":
      mergemode => clobber,
    }

    # Removes current java paths from PATH
    #windows_path {'remove_java_path2':
    #  ensure     => absent,
    #  directory  => "C:\\Program Files\\Java\\$file\\bin",
    #}

    obsolete_java {'jdk1.7.0_51':
      ensure      => absent,
      directory   => "C:\\Program Files\\Java\\$file\\bin",
    }

    # Adds java to the path.
    windows_path {'javaPath':
      ensure      => present,
      directory   => "C:\\Program Files\\Java\\$file\\bin",
    }
  } else {

    package { 'remove-package':
      name   => "$package",
      ensure => absent,
    }

    windows_env { 'JAVA_HOME':
      ensure    => 'absent',
      mergemode => clobber,
    }

    windows_path {'remove_java_path':
     ensure    => absent,
     directory => "C:\\Program Files\\Java\\$file\\bin",
    }
  }
}
