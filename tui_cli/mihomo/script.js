// ====================
// 0. 本机固定规则（从 Clash Verge Rev 覆写脚本迁移）
// ====================

// 强制直连的域名后缀。
// 这里同时会加入 fake-ip-filter，避免这些站点被 fake-ip 影响直连体验。
const BYPASS_DOMAINS = [
  "sharepoint.com",
  "ac-gdfrvlf-shard-00-02.sun7s3n.mongodb.net",
  "vluv.space"
];

// 强制直连的进程名。steam.exe 是 CVR 里保留的 Windows 直连规则，
// 放在这里不会影响 macOS，后续 Windows 复用这份配置时仍然生效。
const DIRECT_PROCESS_NAMES = [
  "steam.exe"
];

// 强制走代理的域名后缀，对应 CVR 里的 Google 相关静态资源和 Play 下载域名。
const FORCE_PROXY_DOMAIN_SUFFIXES = [
  "googleapis.cn",
  "gstatic.com",
  "xn--ngstr-lra8j.com"
];

// 强制走代理的精确域名。
const FORCE_PROXY_DOMAINS = [
  "v2rayse.com"
];

// AI 规则沿用当前脚本的 AI 分组，并补上 CVR 里的 Perplexity。
const AI_GEOSITES = [
  "openai",
  "anthropic",
  "google-gemini",
  "xai",
  "perplexity"
];

// NSFW 规则：CVR 使用外部 category-porn 规则集；mihomo 本地 geosite.dat
// 已支持 category-porn，所以这里直接用 GEOSITE，少一个远程规则集依赖。
const NSFW_DOMAIN_SUFFIXES = [
  "88newline.jb-aiwei.cc"
];

// ====================
// 1. 常量配置
// ====================
const SETTINGS = {
  ICON_BASE: "https://cdn.jsdelivr.net/gh/Koolson/Qure@master/IconSet/Color/",
  GEOIP_URL: "https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geoip.dat",
  GEOSITE_URL: "https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geosite.dat",

  URL_TEST_EXTRA: {
    hidden: true,
    url: "https://www.g.cn/generate_204",
    interval: 900,
    tolerance: 50,
    lazy: true,
    timeout: 1000
  },

  // BetterFB 本质仍是 url-test，但新增 max-failed-times: 1
  // 解决“节点超时却不第一时间切换”的问题，同时保留高 tolerance 的稳定性
  BETTER_FB_EXTRA: {
    hidden: true,
    url: "https://www.g.cn/generate_204",
    interval: 900,
    tolerance: 750,
    lazy: true,
    timeout: 1000,
    "max-failed-times": 1   
  },

  FILTER_REGEX: /群|邀请|返利|官网|官方|网址|订阅|购买|续费|剩余|到期|过期|流量|备用|邮箱|客服|联系|工单|倒卖|防止|梯子|tg|telegram|电报|发布|重置/i
};

// ====================
// 2. 基础工具（以下全部保持不变）
// ====================
const uniq = (arr = []) => [...new Set(arr.filter(Boolean))];

const escapeRegex = (s = "") =>
  String(s).replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

const normalizeName = (name = "") =>
  String(name)
    .replace(/(IEPL|IPLC|BGP|RELAY|PRO|V\d+)/ig, " $1 ")
    .replace(/[【】\[\]（）()|_\-.,/:~]/g, " ")
    .replace(/🇭🇰/g, " HK ")
    .toUpperCase()
    .replace(/\s+/g, " ")
    .trim();

const buildRegex = (arr = []) =>
  new RegExp(
    arr
      .map((raw) => {
        const token = String(raw).trim().toUpperCase();
        const escaped = escapeRegex(token);
        return /^[A-Z]{2,3}$/.test(token)
          ? `(?:^|[^A-Z])${escaped}(?:[^A-Z]|$)`
          : escaped;
      })
      .join("|"),
    "i"
  );

const HK_REGEX = buildRegex(["香港", "HK", "HKG", "HONGKONG", "HONG KONG"]);

const buildFakeIpFilter = (bypass = []) =>
  uniq([
    "geosite:private",
    "geosite:google-cn",
    "geosite:synology",
    "geosite:cn",
    ...uniq(
      bypass.flatMap((domain) => {
        const d = String(domain || "").trim();
        if (!d) return [];
        return d.includes("*") || d.startsWith("+.") ? [d] : [`+.${d}`];
      })
    )
  ]);

const mergeRules = (baseRules = [], extraRules = []) => {
  const extra = Array.isArray(extraRules) ? extraRules.filter(Boolean) : [];
  if (!extra.length) return baseRules.slice();

  const matchIndex = baseRules.findIndex(
    (rule) => String(rule).trim().toUpperCase() === "MATCH,全部"
  );

  if (matchIndex === -1) return uniq([...baseRules, ...extra]);

  return uniq([
    ...baseRules.slice(0, matchIndex),
    ...extra,
    ...baseRules.slice(matchIndex)
  ]);
};

const pickDirectRules = (rules = []) =>
  rules.filter((rule) => {
    const r = String(rule || "").trim();
    if (!r || r.startsWith("#")) return false;
    return /,DIRECT(?:,|$)/i.test(r);
  });

// ====================
// 3. 固定规则
// ====================
const STATIC_RULES = [
  "GEOSITE,category-ads-all,REJECT",
  // CVR 迁移：进程级和域名级直连规则。
  ...uniq(DIRECT_PROCESS_NAMES).map((name) => `PROCESS-NAME,${name},DIRECT`),
  "GEOSITE,private,DIRECT",
  "GEOIP,private,DIRECT,no-resolve",
  "GEOSITE,google-cn,DIRECT",
  "GEOSITE,synology,DIRECT",
  "GEOSITE,microsoft@cn,DIRECT",
  ...uniq(BYPASS_DOMAINS).map((d) => `DOMAIN-SUFFIX,${d},DIRECT`),

  // CVR 迁移：这些域名在国内解析或访问经常不稳定，固定走“全部”代理组。
  ...uniq(FORCE_PROXY_DOMAIN_SUFFIXES).map((d) => `DOMAIN-SUFFIX,${d},全部`),
  ...uniq(FORCE_PROXY_DOMAINS).map((d) => `DOMAIN,${d},全部`),

  // AI 服务走独立 AI 分组，方便避开香港节点。
  ...uniq(AI_GEOSITES).map((tag) => `GEOSITE,${tag},AI`),

  // CVR 迁移：NSFW 相关站点走独立 NSFW 分组。
  ...uniq(NSFW_DOMAIN_SUFFIXES).map((d) => `DOMAIN-SUFFIX,${d},NSFW`),
  "GEOSITE,category-porn,NSFW",

  "GEOSITE,gfw,全部",
  "GEOSITE,cn,DIRECT",
  "GEOIP,CN,DIRECT,no-resolve",
  "MATCH,全部"
];

const STATIC_FAKE_IP_FILTER = buildFakeIpFilter(BYPASS_DOMAINS);

// ====================
// 4. 节点处理
// ====================
const ensureConfigObject = (input) =>
  input && typeof input === "object" ? input : {};

const getOriginalProxies = (input) =>
  Array.isArray(input.proxies) ? input.proxies : [];

const makeProxyNamesUnique = (proxies = []) => {
  const used = new Set();
  const nextIdx = new Map();

  proxies.forEach((p) => {
    if (!p || !p.name) return;
    const base = String(p.name);
    if (!used.has(base)) {
      used.add(base);
      nextIdx.set(base, 1);
      return;
    }
    let idx = nextIdx.get(base) ?? 1;
    let candidate = `${base}_${idx}`;
    while (used.has(candidate)) candidate = `${base}_${++idx}`;
    p.name = candidate;
    used.add(candidate);
    nextIdx.set(base, idx + 1);
  });
};

const splitInfoAndNormalProxies = (proxies = [], filterRegex) =>
  proxies.reduce(
    (acc, proxy) => {
      if (!proxy || !proxy.name) return acc;
      (filterRegex.test(proxy.name) ? acc.infoProxies : acc.normalProxies).push(proxy);
      return acc;
    },
    { infoProxies: [], normalProxies: [] }
  );

const buildAiProxyList = (allNames = []) => {
  const nonHk = allNames.filter((n) => !HK_REGEX.test(normalizeName(n)));
  return nonHk.length ? nonHk : allNames;
};

// ====================
// 5. 策略组
// ====================
const buildProxyGroups = ({ allNames, aiNames, infoNames }) => {
  const groups = [];
  const add = (name, type, proxies, icon = "Available.png", extra = {}) => {
    proxies = uniq(proxies);
    if (name && proxies.length) {
      groups.push({
        name,
        type,
        proxies,
        icon: SETTINGS.ICON_BASE + icon,
        ...extra
      });
    }
  };

  if (allNames.length) {
    add("URL Test - 全部", "url-test", allNames, "Available.png", SETTINGS.URL_TEST_EXTRA);
    add("BetterFB - 全部", "url-test", allNames, "Available.png", SETTINGS.BETTER_FB_EXTRA);
    add("全部", "select", ["BetterFB - 全部", "URL Test - 全部", ...allNames], "Available.png");
  }

  if (aiNames.length) {
    add("URL Test - AI", "url-test", aiNames, "ChatGPT.png", SETTINGS.URL_TEST_EXTRA);
    add("BetterFB - AI", "url-test", aiNames, "ChatGPT.png", SETTINGS.BETTER_FB_EXTRA);
    add("AI", "select", ["BetterFB - AI", "URL Test - AI", ...aiNames], "ChatGPT.png");
  }

  if (allNames.length) {
    add(
      "NSFW",
      "select",
      ["全部", "BetterFB - 全部", "URL Test - 全部", ...allNames],
      "Available.png"
    );
  }

  if (infoNames.length) {
    add("Info", "select", infoNames, "Available.png");
  }

  add(
    "GLOBAL",
    "select",
    [
      ...(allNames.length ? ["全部"] : []),
      ...(aiNames.length ? ["AI"] : []),
      ...(allNames.length ? ["NSFW"] : []),
      ...(infoNames.length ? ["Info"] : [])
    ],
    "Global.png"
  );

  return groups;
};

// ====================
// 6. 网络配置
// ====================
const applyGeoData = (cfg) => {
  cfg["geodata-mode"] = true;
  cfg["geo-auto-update"] = true;
  cfg["geo-update-interval"] = 24;
  cfg["geox-url"] = {
    ...(cfg["geox-url"] || {}),
    geoip: SETTINGS.GEOIP_URL,
    geosite: SETTINGS.GEOSITE_URL
  };
};

const applySniffer = (cfg) => {
  cfg.sniffer = {
    ...(cfg.sniffer || {}),
    enable: true,
    "force-dns-mapping": true,
    "parse-pure-ip": true,
    "override-destination": true,
    sniff: {
      HTTP: { ports: [80, "8080-8880"], "override-destination": true },
      TLS: { ports: [443, 8443] },
      QUIC: { ports: [443, 8443] }
    }
  };
};

const applyTun = (cfg) => {
  cfg.tun = {
    ...(cfg.tun || {}),
    enable: true,
    stack: "system",
    "auto-route": true,
    "auto-detect-interface": true,
    "strict-route": true,
    "dns-hijack": ["any:53", "tcp://any:53"]
  };
};

const applyDns = (cfg) => {
  const dns = cfg.dns || {};
  const fakeIpFilter = Array.isArray(dns["fake-ip-filter"]) ? dns["fake-ip-filter"] : [];
  const nameserverPolicy = dns["nameserver-policy"] && typeof dns["nameserver-policy"] === "object" ? dns["nameserver-policy"] : {};

  cfg.dns = {
    ...dns,
    enable: true,
    "cache-algorithm": "arc",
    listen: dns.listen,
    ipv6: dns.ipv6,
    "enhanced-mode": "fake-ip",
    "fake-ip-filter-mode": "blacklist",
    "fake-ip-filter": uniq([...fakeIpFilter, ...STATIC_FAKE_IP_FILTER]),
    "respect-rules": true,
    "default-nameserver": ["223.5.5.5", "119.29.29.29"],
    "nameserver-policy": {
      ...nameserverPolicy,
      "pdir.cc.cd": ["https://1.1.1.1/dns-query#全部", "https://8.8.8.8/dns-query#全部"],
      "vale.cc.cd": ["https://1.1.1.1/dns-query#全部", "https://8.8.8.8/dns-query#全部"],
      "geosite:cn": ["223.5.5.5#DIRECT", "119.29.29.29#DIRECT"],
      "geosite:private": "system",
      "geosite:google-cn": ["223.5.5.5#DIRECT", "119.29.29.29#DIRECT"],
      "geosite:synology": ["223.5.5.5#DIRECT", "119.29.29.29#DIRECT"],
      "geosite:openai": ["https://1.1.1.1/dns-query#AI", "https://8.8.8.8/dns-query#AI"],
      "geosite:anthropic": ["https://1.1.1.1/dns-query#AI", "https://8.8.8.8/dns-query#AI"],
      "geosite:google-gemini": ["https://1.1.1.1/dns-query#AI", "https://8.8.8.8/dns-query#AI"],
      "geosite:xai": ["https://1.1.1.1/dns-query#AI", "https://8.8.8.8/dns-query#AI"]
    },
    nameserver: ["https://1.1.1.1/dns-query#全部", "https://8.8.8.8/dns-query#全部"],
    "proxy-server-nameserver": ["223.5.5.5#DIRECT", "119.29.29.29#DIRECT", "system"],
    "direct-nameserver": ["223.5.5.5#DIRECT", "119.29.29.29#DIRECT", "system"],
    "direct-nameserver-follow-policy": true
  };
};

const applyProfile = (cfg) => {
  cfg.profile = {
    ...(cfg.profile || {}),
    "store-selected": true,
    "store-fake-ip": false
  };
};

const applyRuntime = (cfg) => {
  cfg.mode = "rule";
  cfg["log-level"] = "warning";
};

// ====================
// 7. 主流程
// ====================
function main(config) {
  config = ensureConfigObject(config);
  const originalProxies = getOriginalProxies(config);
  const existingRules = Array.isArray(config.rules) ? config.rules : [];
  delete config["rule-providers"];
  config.rules = mergeRules(STATIC_RULES, pickDirectRules(existingRules));

  if (originalProxies.length) {
    makeProxyNamesUnique(originalProxies);
    const { infoProxies, normalProxies } = splitInfoAndNormalProxies(originalProxies, SETTINGS.FILTER_REGEX);
    const baseProxies = normalProxies;
    const allNames = uniq(baseProxies.map((p) => p.name));
    const infoNames = uniq(infoProxies.map((p) => p.name));
    const aiNames = buildAiProxyList(allNames);
    config["proxy-groups"] = buildProxyGroups({ allNames, aiNames, infoNames });
    config.proxies = originalProxies;
  }

  applyGeoData(config);
  applyRuntime(config);
  applySniffer(config);
  applyTun(config);
  applyDns(config);
  applyProfile(config);

  return config;
}
