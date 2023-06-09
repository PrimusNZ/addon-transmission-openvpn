#!/usr/bin/bashio

if [ ! -d /share/transmission-openvpn/config ]; then
  echo "Creating /share/transmission-openvpn/config"
  mkdir -p /share/transmission-openvpn/config
  chown -R abc:abc /share/transmission-openvpn/config
fi

if [ ! -d /media/Downloads/completed ]; then
  echo "Creating /media/Downloads/completed"
  mkdir -p /media/Downloads/completed
  chown -R abc:abc /media/Downloads/completed
fi

if [ ! -d /media/Downloads/incomplete ]; then
  echo "Creating /media/Downloads/incomplete"
  mkdir -p /media/Downloads/incomplete
  chown -R abc:abc /media/Downloads/incomplete
fi

if [ -d /share/transmission-openvpn/config/openvpn ]; then
  echo "Copying OpenVPN configurations"  
  cp -R /share/transmission-openvpn/config/openvpn/* /etc/openvpn/
fi

for k in $(bashio::jq "${__BASHIO_ADDON_CONFIG}" 'keys | .[]'); do
    export $k="$(bashio::config $k)"
done

/etc/openvpn/start.sh
