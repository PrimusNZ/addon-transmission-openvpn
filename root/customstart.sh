#!/usr/bin/bashio

if [ ! -d /share/transmission-openvpn/config ]; then
  echo "Creating /share/transmission-openvpn/config"
  mkdir -p /share/transmission-openvpn/config
  chown -R abc:abc /share/transmission-openvpn/config
fi

if [ ! -d /share/downloads/completed ]; then
  echo "Creating /share/downloads/completed"
  mkdir -p /share/downloads/completed
  chown -R abc:abc /share/downloads/completed
fi

if [ ! -d /share/downloads/incomplete/torrent ]; then
  echo "Creating /share/downloads/incomplete/torrent"
  mkdir -p /share/downloads/incomplete/torrent
  chown -R abc:abc /share/downloads/incomplete/torrent
fi

if [ -d /share/transmission-openvpn/config/openvpn ]; then
  echo "Copying OpenVPN configurations"  
  cp -R /share/transmission-openvpn/config/openvpn/* /etc/openvpn/
fi

for k in $(bashio::jq "${__BASHIO_ADDON_CONFIG}" 'keys | .[]'); do
    export $k="$(bashio::config $k)"
done

/etc/openvpn/start.sh
