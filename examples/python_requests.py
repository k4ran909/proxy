import sys
import os

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from sdk.python.fluxnat_proxy import FluxNatProxyClient

def main():
    client = FluxNatProxyClient()
    
    # 1. Check pool status
    stats = client.get_count()
    print(f"📊 Active Verified Proxies in Pool: {stats.get('count', 0)}")
    
    # 2. Fetch IP with auto-rotation
    print("🚀 Making rotating requests...")
    for i in range(3):
        res = client.request("https://httpbin.org/ip")
        print(f"Request #{i+1} Response: {res.json()}")

if __name__ == "__main__":
    main()
