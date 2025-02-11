# @summary Configure a Bacula Storage Daemon Autochanger
#
# This define creates a storage autochanger declaration.
# @param name            Bacula director configuration for Autochanger option 'Name'
# @param device          Bacula director configuration for Autochanger option 'Device'
# @param changer_device  Bacula director configuration for Autochanger option 'Changer Device'
# @param changer_command Bacula director configuration for Autochanger option 'Changer Command'
#
define bacula::storage::autochanger (
  String[1]            $autochanger_name = $name,
  String[1]            $device           = undef,
  Stdlib::Absolutepath $changer_device   = undef,
  String[1]            $changer_command  = '/etc/bacula/scripts/mtx-changer %c %o %S %a %d',
  Stdlib::Absolutepath $conf_dir         = $bacula::conf_dir,
) {
  $epp_autochanger_variables = {
    autochanger_name => $autochanger_name,
    media_type       => $media_type,
    device           => $device,
    changer_device   => $changer_device,
    changer_command  => $changer_command,
  }

  concat::fragment { "bacula-storage-autochanger-${name}":
    target  => "${conf_dir}/bacula-sd.conf",
    content => epp('bacula/bacula-sd-autochanger.epp', $epp_autochanger_variables),
  }
}
