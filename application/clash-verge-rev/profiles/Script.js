// CDN 基础路径
const metacubeGeositeBase =
	"https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@meta/geo/geosite/";
const metacubeGeoipBase =
	"https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@meta/geo/geoip/";
const metacubeClassicalBase =
	"https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@meta/geo/geosite/classical/";
const loyalsoldierBase =
	"https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/";
const iconBase =
	"https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/";


// ====== 自动生成的最佳DNS配置 ======
// 国内DNS
const domesticNameservers = [
  "https://223.5.5.5/dns-query", // 阿里DoH (13.1ms)
  "https://dns.alidns.com/dns-query", // AliDNS (14.7ms)
];

// 国外DNS
const foreignNameservers = [
  "https://dns.google/resolve", // Google (3.4ms)
  "https://dns.quad9.net/dns-query", // Quad9 (86.6ms)
  "https://cloudflare-dns.com/dns-query", // Cloudflare (91.7ms)
];

// DNS配置
const dnsConfig = {
	enable: true,
	listen: "0.0.0.0:1053",
	ipv6: true,
	"prefer-h3": true,
	"respect-rules": true,
	"use-system-hosts": false,
	"cache-algorithm": "arc",
	"enhanced-mode": "fake-ip",
	"fake-ip-range": "198.18.0.1/16",
	"fake-ip-filter": [
		// 本地主机/设备
		"+.lan",
		"+.local",
		"*.arpa",
		// NTP 时间同步
		"time.*.com",
		"time.*.gov",
		"time.*.edu.cn",
		"time.*.apple.com",
		"ntp.*.com",
		"+.pool.ntp.org",
		// STUN
		"stun.*.*",
		"stun.*.*.*",
		// Windows 网络检测
		"+.msftconnecttest.com",
		"+.msftncsi.com",
		// QQ 快速登录
		"localhost.ptlogin2.qq.com",
		"localhost.sec.qq.com",
		// 微信快速登录
		"localhost.work.weixin.qq.com",
	],
	"default-nameserver": ["223.5.5.5", "1.2.4.8"],
	nameserver: [...foreignNameservers],
	"proxy-server-nameserver": [...domesticNameservers],
	"direct-nameserver": [...domesticNameservers],
	"direct-nameserver-follow-policy": true,
	"nameserver-policy": {
		"geosite:private,cn": domesticNameservers,
	},
};
// 规则集通用配置
const ruleProviderCommon = {
	type: "http",
	format: "yaml",
	interval: 86400,
};
const mrsDomainBase = { ...ruleProviderCommon, behavior: "domain", format: "mrs" };
const mrsIpcidrBase = { ...ruleProviderCommon, behavior: "ipcidr", format: "mrs" };
const classicalBase = { ...ruleProviderCommon, behavior: "classical" };
// 规则集配置
const ruleProviders = {
	proxy: {
		...mrsDomainBase,
		url: `${metacubeGeositeBase}proxy.mrs`,
		path: "./ruleset/MetaCubeX/proxy.mrs",
	},
	direct: {
		...mrsDomainBase,
		url: `${metacubeGeositeBase}cn.mrs`,
		path: "./ruleset/MetaCubeX/cn.mrs",
	},
	private: {
		...mrsDomainBase,
		url: `${metacubeGeositeBase}private.mrs`,
		path: "./ruleset/MetaCubeX/private.mrs",
	},
	gfw: {
		...mrsDomainBase,
		url: `${metacubeGeositeBase}gfw.mrs`,
		path: "./ruleset/MetaCubeX/gfw.mrs",
	},
	"tld-not-cn": {
		...mrsDomainBase,
		url: `${metacubeGeositeBase}geolocation-!cn.mrs`,
		path: "./ruleset/MetaCubeX/geolocation-!cn.mrs",
	},
	cncidr: {
		...mrsIpcidrBase,
		url: `${metacubeGeoipBase}cn.mrs`,
		path: "./ruleset/MetaCubeX/geoip-cn.mrs",
	},
	lancidr: {
		...mrsIpcidrBase,
		url: `${metacubeGeoipBase}private.mrs`,
		path: "./ruleset/MetaCubeX/geoip-private.mrs",
	},
	// Loyalsoldier（无 MetaCubeX 替代品）
	applications: {
		...classicalBase,
		url: `${loyalsoldierBase}applications.txt`,
		path: "./ruleset/loyalsoldier/applications.yaml",
	},
	// MetaCubeX（MRS 格式，速度最快）
	openai: {
		...mrsDomainBase,
		url: `${metacubeGeositeBase}openai.mrs`,
		path: "./ruleset/MetaCubeX/openai.mrs",
	},
	anthropic: {
		...mrsDomainBase,
		url: `${metacubeGeositeBase}anthropic.mrs`,
		path: "./ruleset/MetaCubeX/anthropic.mrs",
	},
	"google-gemini": {
		...mrsDomainBase,
		url: `${metacubeGeositeBase}google-gemini.mrs`,
		path: "./ruleset/MetaCubeX/google-gemini.mrs",
	},
	xai: {
		...mrsDomainBase,
		url: `${metacubeGeositeBase}xai.mrs`,
		path: "./ruleset/MetaCubeX/xai.mrs",
	},
	perplexity: {
		...mrsDomainBase,
		url: `${metacubeGeositeBase}perplexity.mrs`,
		path: "./ruleset/MetaCubeX/perplexity.mrs",
	},
	"microsoft-cn": {
		...mrsDomainBase,
		url: "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/microsoft@cn.mrs",
		path: "./ruleset/MetaCubeX/microsoft@cn.mrs",
	},
	nsfw: {
		...classicalBase,
		url: `${metacubeClassicalBase}category-porn.yaml`,
		path: "./ruleset/MetaCubeX/category-porn.yaml",
	},
};
// 规则
const rules = [
	// 额外自定义规则
	"PROCESS-NAME,steam.exe,🔗 全局直连",
	// "PROCESS-NAME,OneDrive,🔗 全局直连",
	"DOMAIN-SUFFIX,googleapis.cn,⚙️ 节点选择", // Google服务
	"DOMAIN-SUFFIX,gstatic.com,⚙️ 节点选择", // Google静态资源
	"DOMAIN-SUFFIX,xn--ngstr-lra8j.com,⚙️ 节点选择", // Google Play下载服务
	"DOMAIN,v2rayse.com,⚙️ 节点选择", // V2rayse节点工具
	"RULE-SET,openai,🤖 AI服务",
	"RULE-SET,anthropic,🤖 AI服务",
	"RULE-SET,google-gemini,🤖 AI服务",
	"RULE-SET,xai,🤖 AI服务",
	"RULE-SET,perplexity,🤖 AI服务",
	"RULE-SET,nsfw,🔞 NSFW",
	"RULE-SET,private,🔗 全局直连",
	"RULE-SET,microsoft-cn,🔗 全局直连",
	"RULE-SET,proxy,⚙️ 节点选择",
	"RULE-SET,gfw,⚙️ 节点选择",
	"RULE-SET,tld-not-cn,⚙️ 节点选择",
	"RULE-SET,direct,🔗 全局直连",
	"RULE-SET,lancidr,🔗 全局直连,no-resolve",
	"RULE-SET,cncidr,🔗 全局直连,no-resolve",
	"RULE-SET,applications,🔗 全局直连",
	// 其他规则
	"GEOIP,LAN,🔗 全局直连,no-resolve",
	"GEOIP,CN,🔗 全局直连,no-resolve",
	"MATCH,🐟 漏网之鱼",
];
// 代理组通用配置
const groupBaseOption = {
	interval: 300,
	timeout: 3000,
	url: "https://www.google.com/generate_204",
	lazy: true,
	"max-failed-times": 3,
	hidden: false,
};
// 共享代理列表
const autoGroups = ["♻️ 延迟选优"];
const proxyLeadProxies = ["⚙️ 节点选择", ...autoGroups, "🔗 全局直连"];
const directSecondProxies = ["⚙️ 节点选择", "🔗 全局直连", ...autoGroups];
const directLeadProxies = ["🔗 全局直连", "⚙️ 节点选择", ...autoGroups];

const proxyGroupsConfig = [
	{
		...groupBaseOption,
		name: "⚙️ 节点选择",
		type: "select",
		proxies: autoGroups,
		"include-all": true,
		icon: `${iconBase}adjust.svg`,
	},
	{
		...groupBaseOption,
		name: "♻️ 延迟选优",
		type: "url-test",
		tolerance: 50,
		"include-all": true,
		icon: `${iconBase}speed.svg`,
	},
	{
		...groupBaseOption,
		name: "🤖 AI服务",
		type: "select",
		"include-all": true,
		"exclude-filter": "(?i)港|hk|hongkong|hong kong|俄|ru|russia|澳|macao",
		proxies: proxyLeadProxies,
		icon: `${iconBase}chatgpt.svg`,
	},
	{
		...groupBaseOption,
		name: "🔗 全局直连",
		type: "select",
		proxies: ["DIRECT", "⚙️ 节点选择", ...autoGroups],
		"include-all": true,
		icon: `${iconBase}link.svg`,
	},
	{
		...groupBaseOption,
		name: "🔞 NSFW",
		type: "select",
		"include-all": true,
		proxies: proxyLeadProxies,
		icon: `${iconBase}block.svg`,
	},
	{
		...groupBaseOption,
		name: "🐟 漏网之鱼",
		type: "select",
		proxies: proxyLeadProxies,
		"include-all": true,
		icon: `${iconBase}fish.svg`,
	},
];

// 程序入口
function main(config) {
	const proxyCount = config?.proxies?.length ?? 0;

	const pp = config?.["proxy-providers"];
	const proxyProviderCount =
		pp !== null && typeof pp === "object" ? Object.keys(pp).length : 0;

	if (proxyCount === 0 && proxyProviderCount === 0) {
		throw new Error("配置文件中未找到任何代理");
	}

	config["dns"] = dnsConfig;
	config["proxy-groups"] = proxyGroupsConfig;
	config["rule-providers"] = ruleProviders;
	config["rules"] = rules;
	if (Array.isArray(config["proxies"])) {
		config["proxies"].forEach((proxy) => {
			if (proxy) {
				proxy.udp = true;
			}
		});
	}
	return config;
}
