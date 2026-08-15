"""
FluxNat Rotating Proxy Client SDK for Python
https://proxy.fluxnat.dev
"""

import requests
from typing import Optional, Dict

class FluxNatProxyClient:
    def __init__(self, base_url: str = "https://proxy.fluxnat.dev"):
        self.base_url = base_url.rstrip("/")
        self.get_url = f"{self.base_url}/get/"
        self.count_url = f"{self.base_url}/count/"
        self.del_url = f"{self.base_url}/delete/?proxy="

    def get_proxy(self) -> Optional[str]:
        """Fetch a single live, validated proxy IP:PORT string."""
        try:
            res = requests.get(self.get_url, timeout=5).json()
            return res.get("proxy")
        except Exception:
            return None

    def get_count(self) -> Dict:
        """Fetch total active proxies and breakdown stats."""
        try:
            return requests.get(self.count_url, timeout=5).json()
        except Exception:
            return {}

    def delete_proxy(self, proxy_ip: str) -> bool:
        """Delete a dead proxy from the pool."""
        try:
            requests.get(f"{self.del_url}{proxy_ip}", timeout=5)
            return True
        except Exception:
            return False

    def request(self, url: str, method: str = "GET", max_retries: int = 3, timeout: int = 10, **kwargs) -> requests.Response:
        """Make an HTTP request with automatic proxy rotation & dead-proxy purging."""
        for attempt in range(max_retries):
            proxy = self.get_proxy()
            if not proxy:
                continue

            proxies = {
                "http": f"http://{proxy}",
                "https": f"http://{proxy}"
            }

            try:
                response = requests.request(method=method, url=url, proxies=proxies, timeout=timeout, **kwargs)
                return response
            except Exception as e:
                # Purge dead proxy on network/timeout failure
                self.delete_proxy(proxy)

        raise requests.RequestException(f"Failed to fetch {url} after {max_retries} rotating proxy attempts.")
