(() => {
  if (location.protocol === "file:") return;

  const pathParts = location.pathname.split("/").filter(Boolean);
  const base = pathParts.length > 0 ? `/${pathParts[0]}` : "";
  const indexPath = `${base}/`;

  if (location.pathname === indexPath || location.pathname === `${base}/index.html`) return;

  const authKey = "chiiyodo_auth_v1";
  const authed = sessionStorage.getItem(authKey) === "1";
  if (authed) return;

  const next = location.pathname + location.search + location.hash;
  location.replace(`${indexPath}?next=${encodeURIComponent(next)}`);
})();
