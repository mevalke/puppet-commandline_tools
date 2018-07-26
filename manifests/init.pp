class commandline_tools { 
  $script_content = @(EOF)
    #!/bin/sh

    /usr/bin/touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    PROD=$(/usr/sbin/softwareupdate -l | /usr/bin/grep "\*.*Command Line" | /usr/bin/head -n 1 | /usr/bin/awk -F"*" '{print $2}' | /usr/bin/sed -e 's/^ *//' | /usr/bin/tr -d '\n')
    /usr/sbin/softwareupdate -i "$PROD" > /dev/null

    exit 0

    | EOF

  file {'/Library/Scripts/cl_tools':
    ensure  => file,
    mode    => '0755',
    content => inline_epp($script_content),
  }

  exec {'Installing Commandline Tools':
    command   => '/Library/Scripts/cl_tools && /bin/echo "Commandline Tools installed successfully." || /bin/echo "Installation of Commandline Tools failed."',
    logoutput => true,
    creates   => '/Library/Developer/CommandLineTools',
    require   => File['/Library/Scripts/cl_tools'],
  }
}

