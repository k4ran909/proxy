#!/usr/bin/env bash

echo "📊 Checking FluxNat Proxy Pool Stats:"
curl -s https://proxy.fluxnat.dev/count/
echo -e "\n"

echo "🚀 Fetching a fresh proxy:"
PROXY_IP=$(curl -s https://proxy.fluxnat.dev/get/ | grep -oE '"proxy":"[^"]+"' | cut -d'"' -f4)
echo "Using Proxy: $PROXY_IP"

echo "📡 Making request through rotating proxy:"
curl -s -x "http://$PROXY_IP" http://api.ipify.org
echo -e "\n"
