/**
 * FluxNat Rotating Proxy Client SDK for Node.js
 * https://proxy.fluxnat.dev
 */

const axios = require('axios');
const { HttpsProxyAgent } = require('https-proxy-agent');

class FluxNatProxyClient {
    constructor(baseUrl = 'https://proxy.fluxnat.dev') {
        this.baseUrl = baseUrl.replace(/\/$/, '');
        this.getUrl = `${this.baseUrl}/get/`;
        this.countUrl = `${this.baseUrl}/count/`;
        this.delUrl = `${this.baseUrl}/delete/?proxy=`;
    }

    async getProxy() {
        try {
            const { data } = await axios.get(this.getUrl, { timeout: 5000 });
            return data.proxy || null;
        } catch {
            return null;
        }
    }

    async getCount() {
        try {
            const { data } = await axios.get(this.countUrl, { timeout: 5000 });
            return data;
        } catch {
            return {};
        }
    }

    async deleteProxy(proxyIp) {
        try {
            await axios.get(`${this.delUrl}${proxyIp}`, { timeout: 5000 });
            return true;
        } catch {
            return false;
        }
    }

    async request(url, options = {}, retries = 3) {
        for (let i = 0; i < retries; i++) {
            const proxy = await this.getProxy();
            if (!proxy) continue;

            const agent = new HttpsProxyAgent(`http://${proxy}`);
            try {
                const response = await axios({
                    url,
                    httpsAgent: agent,
                    timeout: 10000,
                    ...options
                });
                return response.data;
            } catch (err) {
                await this.deleteProxy(proxy);
            }
        }
        throw new Error(`Failed to request ${url} after ${retries} rotating proxy attempts.`);
    }
}

module.exports = { FluxNatProxyClient };
