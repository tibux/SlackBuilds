config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/nxagent/keystrokes.cfg.new
config etc/x2go/keystrokes.cfg.new

if [ ! "$(grep /usr/lib@LIBDIRSUFFIX@/nx /etc/ld.so.conf)" ]; then
  echo "/usr/lib@LIBDIRSUFFIX@/nx" >> /etc/ld.so.conf
fi
ldconfig
