// CDN 基础路径
const metacubeBase =
	"https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@meta/geo/geosite/classical/";
const loyalsoldierBase =
	"https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/";

// 国内DNS服务器
const domesticNameservers = [
	"https://223.5.5.5/dns-query", // 阿里 DoH
	"https://dns.alidns.com/dns-query", // 阿里云
	"https://doh.pub/dns-query", // 腾讯 DoH
];
// 国外DNS服务器
const foreignNameservers = [
	"https://1.1.1.1/dns-query", // Cloudflare
	"https://8.8.8.8/dns-query#ecs=1.1.1.1/24&ecs-override=true", // Google
	"https://9.9.9.9/dns-query", // Quad9
	"tls://1.1.1.1:853", // Cloudflare DoT
	"tls://8.8.8.8:853", // Google DoT
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
// 规则集配置
const ruleProviders = {
	// Loyalsoldier
	apple: {
		...ruleProviderCommon,
		behavior: "domain",
		url: `${loyalsoldierBase}apple.txt`,
		path: "./ruleset/loyalsoldier/apple.yaml",
	},
	google: {
		...ruleProviderCommon,
		behavior: "domain",
		url: `${loyalsoldierBase}google.txt`,
		path: "./ruleset/loyalsoldier/google.yaml",
	},
	proxy: {
		...ruleProviderCommon,
		behavior: "domain",
		url: `${loyalsoldierBase}proxy.txt`,
		path: "./ruleset/loyalsoldier/proxy.yaml",
	},
	direct: {
		...ruleProviderCommon,
		behavior: "domain",
		url: `${loyalsoldierBase}direct.txt`,
		path: "./ruleset/loyalsoldier/direct.yaml",
	},
	private: {
		...ruleProviderCommon,
		behavior: "domain",
		url: `${loyalsoldierBase}private.txt`,
		path: "./ruleset/loyalsoldier/private.yaml",
	},
	gfw: {
		...ruleProviderCommon,
		behavior: "domain",
		url: `${loyalsoldierBase}gfw.txt`,
		path: "./ruleset/loyalsoldier/gfw.yaml",
	},
	"tld-not-cn": {
		...ruleProviderCommon,
		behavior: "domain",
		url: `${loyalsoldierBase}tld-not-cn.txt`,
		path: "./ruleset/loyalsoldier/tld-not-cn.yaml",
	},
	cncidr: {
		...ruleProviderCommon,
		behavior: "ipcidr",
		url: `${loyalsoldierBase}cncidr.txt`,
		path: "./ruleset/loyalsoldier/cncidr.yaml",
	},
	lancidr: {
		...ruleProviderCommon,
		behavior: "ipcidr",
		url: `${loyalsoldierBase}lancidr.txt`,
		path: "./ruleset/loyalsoldier/lancidr.yaml",
	},
	applications: {
		...ruleProviderCommon,
		behavior: "classical",
		url: `${loyalsoldierBase}applications.txt`,
		path: "./ruleset/loyalsoldier/applications.yaml",
	},
	// MetaCubeX
	openai: {
		...ruleProviderCommon,
		behavior: "classical",
		url: `${metacubeBase}openai.yaml`,
		path: "./ruleset/MetaCubeX/openai.yaml",
	},
	pikpak: {
		...ruleProviderCommon,
		behavior: "classical",
		url: `${metacubeBase}pikpak.yaml`,
		path: "./ruleset/MetaCubeX/pikpak.yaml",
	},
	anthropic: {
		...ruleProviderCommon,
		behavior: "classical",
		url: `${metacubeBase}anthropic.yaml`,
		path: "./ruleset/MetaCubeX/anthropic.yaml",
	},
	"google-gemini": {
		...ruleProviderCommon,
		behavior: "classical",
		url: `${metacubeBase}google-gemini.yaml`,
		path: "./ruleset/MetaCubeX/google-gemini.yaml",
	},
	xai: {
		...ruleProviderCommon,
		behavior: "classical",
		url: `${metacubeBase}xai.yaml`,
		path: "./ruleset/MetaCubeX/xai.yaml",
	},
	perplexity: {
		...ruleProviderCommon,
		behavior: "classical",
		url: `${metacubeBase}perplexity.yaml`,
		path: "./ruleset/MetaCubeX/perplexity.yaml",
	},
	microsoft: {
		...ruleProviderCommon,
		behavior: "classical",
		url: `${metacubeBase}microsoft.yaml`,
		path: "./ruleset/MetaCubeX/microsoft.yaml",
	},
};
// 规则
const rules = [
	// 额外自定义规则
	"PROCESS-NAME,steam.exe,🐬 自定义直连",
	// "PROCESS-NAME,OneDrive,🐬 自定义直连",
	"DOMAIN-SUFFIX,linux.do,🐬 自定义直连",
	"DOMAIN-SUFFIX,vluv.space,🐬 自定义直连",
	"DOMAIN-SUFFIX,workos.com,🐳 自定义代理",
	"DOMAIN-SUFFIX,immersivetranslate.com,🐳 自定义代理",
	"DOMAIN-SUFFIX,bing.com,🐳 自定义代理",
	"DOMAIN-SUFFIX,googleapis.cn,⚙️ 节点选择", // Google服务
	"DOMAIN-SUFFIX,gstatic.com,⚙️ 节点选择", // Google静态资源
	"DOMAIN-SUFFIX,xn--ngstr-lra8j.com,⚙️ 节点选择", // Google Play下载服务
	"DOMAIN,v2rayse.com,⚙️ 节点选择", // V2rayse节点工具
	// MetaCubeX 规则集
	"RULE-SET,openai,🤖 AI服务",
	"RULE-SET,pikpak,🅿️ PikPak",
	"RULE-SET,anthropic,🤖 AI服务",
	"RULE-SET,google-gemini,🤖 AI服务",
	"RULE-SET,xai,🤖 AI服务",
	"RULE-SET,perplexity,🤖 AI服务",
	// Loyalsoldier 规则集
	"RULE-SET,private,🔗 全局直连",
	"RULE-SET,microsoft,Ⓜ️ 微软服务",
	"RULE-SET,apple,🍎 苹果服务",
	"RULE-SET,google,📢 谷歌服务",
	"RULE-SET,proxy,⚙️ 节点选择",
	"RULE-SET,gfw,⚙️ 节点选择",
	"RULE-SET,tld-not-cn,⚙️ 节点选择",
	"RULE-SET,direct,🔗 全局直连",
	"RULE-SET,lancidr,🔗 全局直连,no-resolve",
	"RULE-SET,cncidr,🔗 全局直连,no-resolve",
	"RULE-SET,applications,🔗 全局直连", // 在 telegramcidr 之后，避免 Telegram 被直连
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

const proxyGroupsConfig = [
	{
		...groupBaseOption,
		name: "⚙️ 节点选择",
		type: "select",
		proxies: [
			"♻️ 延迟选优",
			"🚑 故障转移",
			"⚖️ 负载均衡(散列)",
			"☁️ 负载均衡(轮询)",
		],
		"include-all": true,
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/adjust.svg",
	},
	{
		...groupBaseOption,
		name: "♻️ 延迟选优",
		type: "url-test",
		tolerance: 50,
		"include-all": true,
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/speed.svg",
	},
	{
		...groupBaseOption,
		name: "🚑 故障转移",
		type: "fallback",
		"include-all": true,
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/ambulance.svg",
	},
	{
		...groupBaseOption,
		name: "⚖️ 负载均衡(散列)",
		type: "load-balance",
		strategy: "consistent-hashing",
		"include-all": true,
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/merry_go.svg",
	},
	{
		...groupBaseOption,
		name: "☁️ 负载均衡(轮询)",
		type: "load-balance",
		strategy: "round-robin",
		"include-all": true,
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/balance.svg",
	},
	{
		...groupBaseOption,
		name: "🤖 AI服务",
		type: "select",
		"include-all": true,
		"exclude-filter": "(?i)港|hk|hongkong|hong kong|俄|ru|russia|澳|macao",
		proxies: [
			"⚙️ 节点选择",
			"♻️ 延迟选优",
			"🚑 故障转移",
			"⚖️ 负载均衡(散列)",
			"☁️ 负载均衡(轮询)",
			"🔗 全局直连",
		],
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/chatgpt.svg",
	},
	{
		...groupBaseOption,
		name: "🅿️ PikPak",
		type: "select",
		proxies: [
			"⚙️ 节点选择",
			"🔗 全局直连",
			"♻️ 延迟选优",
			"🚑 故障转移",
			"⚖️ 负载均衡(散列)",
			"☁️ 负载均衡(轮询)",
		],
		"include-all": true,
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/link.svg",
	},
	{
		...groupBaseOption,
		name: "📲 电报消息",
		type: "select",
		proxies: [
			"⚙️ 节点选择",
			"♻️ 延迟选优",
			"🚑 故障转移",
			"⚖️ 负载均衡(散列)",
			"☁️ 负载均衡(轮询)",
			"🔗 全局直连",
		],
		"include-all": true,
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/telegram.svg",
	},
	{
		...groupBaseOption,
		name: "📢 谷歌服务",
		type: "select",
		proxies: [
			"⚙️ 节点选择",
			"♻️ 延迟选优",
			"🚑 故障转移",
			"⚖️ 负载均衡(散列)",
			"☁️ 负载均衡(轮询)",
			"🔗 全局直连",
		],
		"include-all": true,
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/google.svg",
	},
	{
		...groupBaseOption,
		name: "🍎 苹果服务",
		type: "select",
		proxies: [
			"⚙️ 节点选择",
			"♻️ 延迟选优",
			"🚑 故障转移",
			"⚖️ 负载均衡(散列)",
			"☁️ 负载均衡(轮询)",
			"🔗 全局直连",
		],
		"include-all": true,
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/apple.svg",
	},
	{
		...groupBaseOption,
		name: "Ⓜ️ 微软服务",
		type: "select",
		proxies: [
			"⚙️ 节点选择",
			"🔗 全局直连",
			"♻️ 延迟选优",
			"🚑 故障转移",
			"⚖️ 负载均衡(散列)",
			"☁️ 负载均衡(轮询)",
		],
		"include-all": true,
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/microsoft.svg",
	},
	{
		...groupBaseOption,
		name: "🔗 全局直连",
		type: "select",
		proxies: [
			"DIRECT",
			"⚙️ 节点选择",
			"♻️ 延迟选优",
			"🚑 故障转移",
			"⚖️ 负载均衡(散列)",
			"☁️ 负载均衡(轮询)",
		],
		"include-all": true,
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/link.svg",
	},
	{
		...groupBaseOption,
		name: "❌ 全局拦截",
		type: "select",
		proxies: ["REJECT", "DIRECT"],
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/block.svg",
	},
	{
		...groupBaseOption,
		name: "🐬 自定义直连",
		type: "select",
		"include-all": true,
		proxies: [
			"🔗 全局直连",
			"⚙️ 节点选择",
			"♻️ 延迟选优",
			"🚑 故障转移",
			"⚖️ 负载均衡(散列)",
			"☁️ 负载均衡(轮询)",
		],
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/unknown.svg",
	},
	{
		...groupBaseOption,
		name: "🐳 自定义代理",
		type: "select",
		"include-all": true,
		proxies: [
			"⚙️ 节点选择",
			"♻️ 延迟选优",
			"🚑 故障转移",
			"⚖️ 负载均衡(散列)",
			"☁️ 负载均衡(轮询)",
			"🔗 全局直连",
		],
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/openwrt.svg",
	},
	{
		...groupBaseOption,
		name: "🐟 漏网之鱼",
		type: "select",
		proxies: [
			"⚙️ 节点选择",
			"♻️ 延迟选优",
			"🚑 故障转移",
			"⚖️ 负载均衡(散列)",
			"☁️ 负载均衡(轮询)",
			"🔗 全局直连",
		],
		"include-all": true,
		icon: "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/fish.svg",
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
