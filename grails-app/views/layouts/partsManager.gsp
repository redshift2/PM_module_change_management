<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title><g:layoutTitle default="Change Management"/></title>
  <style>
/* Parts Manager shared shell; no Taack UI dependency */
:root { --pm-blue:#1664ad; --pm-sidebar:#152333; --pm-surface:#202b36; --pm-bg:#111a23; --pm-text:#eef4fa; --pm-muted:#b6c6d5; --pm-border:#394959; }
.pm-shell[data-pm-theme="light"] { --pm-sidebar:#e7eef5; --pm-surface:#fff; --pm-bg:#f2f5f9; --pm-text:#1b2b3a; --pm-muted:#4d6070; --pm-border:#cdd8e3; }
.pm-shell { margin:0; background:var(--pm-bg); color:var(--pm-text); font-family:system-ui,-apple-system,sans-serif; --pm-width:64px; }
.pm-shell.pm-expanded { --pm-width:240px; }
.pm-sidebar { position:fixed; inset:0 auto 0 0; width:var(--pm-width); background:var(--pm-sidebar); z-index:1000; transition:width .18s; overflow:visible; border-right:1px solid var(--pm-border); }
.pm-toggle { width:100%; height:60px; border:0; background:transparent; color:var(--pm-text); display:flex; align-items:center; gap:19px; padding:0 22px; font-size:23px; cursor:pointer; white-space:nowrap; }
.pm-label { display:none; font-size:14px; white-space:nowrap; }
.pm-expanded .pm-label { display:inline; }
.pm-nav { padding:12px 0; }
.pm-entry { position:relative; }
.pm-module { display:flex; height:54px; gap:20px; align-items:center; padding:0 18px; color:var(--pm-text); text-decoration:none; }
.pm-module:hover,.pm-module:focus-visible,.pm-entry.pm-active>.pm-module { background:var(--pm-blue); color:#fff; }
.pm-icon { width:28px; flex:0 0 28px; text-align:center; font-size:23px; }
.pm-flyout { display:none; position:absolute; left:100%; top:0; width:210px; background:var(--pm-surface); border:1px solid var(--pm-border); box-shadow:0 8px 20px #0005; padding:10px 0; z-index:1010; }
.pm-flyout strong { display:block; padding:9px 16px; font-size:13px; color:var(--pm-muted); }
.pm-flyout a { display:block; padding:11px 16px; color:var(--pm-text); text-decoration:none; }
.pm-flyout a:hover,.pm-flyout a:focus-visible { background:var(--pm-blue); color:#fff; }
@media (hover:hover) { .pm-entry:hover>.pm-flyout { display:block; } }
.pm-entry:focus-within>.pm-flyout,.pm-entry.pm-open>.pm-flyout { display:block; }
.pm-main { margin-left:var(--pm-width); transition:margin-left .18s; min-width:0; }
.pm-header { height:60px; box-sizing:border-box; background:var(--pm-blue); color:#fff; position:sticky; top:0; z-index:900; display:flex; align-items:center; justify-content:space-between; padding:0 20px; gap:12px; }
.pm-title { font-weight:650; font-size:19px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
.pm-account { display:flex; align-items:center; gap:12px; }
.pm-user { max-width:170px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
.pm-header-action { background:transparent; border:0; color:#fff; font-size:21px; cursor:pointer; padding:7px; text-decoration:none; line-height:1; }
.pm-header-action:hover,.pm-header-action:focus-visible { background:#ffffff29; border-radius:5px; }
.pm-logout { margin:0; }
.pm-content { padding:22px; }
@media(max-width:650px) { .pm-shell.pm-expanded .pm-sidebar { box-shadow:0 0 0 100vw #0008; } .pm-shell.pm-expanded .pm-main { margin-left:64px; } .pm-user { display:none; } .pm-content { padding:12px; } }

/* Change Management content inside Parts Manager shell */
.cm { max-width: 1600px; margin:0 auto; color:var(--pm-text); font:14px system-ui,sans-serif; }
.cm * {box-sizing:border-box}
.cm-page-header {display:flex;align-items:center;justify-content:space-between;gap:12px;padding:4px 0 12px;border-bottom:1px solid var(--pm-border)}
.cm-page-header h1 {font-size:23px;margin:0;color:var(--pm-text)}
.cm-nav {display:flex;gap:9px;flex-wrap:wrap;margin:18px 0}
.cm section {background:var(--pm-surface);border:1px solid var(--pm-border);border-radius:7px;margin:14px 0;padding:18px}
.cm h2 {font-size:18px;margin:0 0 14px}.cm h3 {font-size:16px;margin:18px 0 12px}
.cm p {line-height:1.5}
.cm .btn,.cm button,.cm .cm-tab {display:inline-block;background:var(--pm-surface);color:var(--pm-text);border:1px solid var(--pm-border);border-radius:5px;padding:9px 13px;text-decoration:none;cursor:pointer;font:inherit}
.cm .btn:hover,.cm button:hover,.cm .cm-tab:hover {background:var(--pm-blue);color:white}
.cm .btn-primary,.cm button.primary,.cm .cm-tab.active {background:var(--pm-blue);color:white}
.cm .table-wrap {overflow-x:auto}
.cm table {width:100%;border-collapse:collapse;color:var(--pm-text);margin:12px 0}
.cm th,.cm td {padding:11px;border-bottom:1px solid var(--pm-border);text-align:left}
.cm th {background:var(--pm-sidebar)}
.cm input,.cm select,.cm textarea {background:var(--pm-bg);color:var(--pm-text);border:1px solid var(--pm-border);border-radius:5px;padding:9px;max-width:100%}
.cm .inline {display:inline-block;margin:4px}
.cm .error {color:#ff7777;font-weight:600}

</style>
  <g:layoutHead/>
</head>
<body class="pm-shell" data-pm-theme="dark">
  <aside class="pm-sidebar" id="pm-sidebar" aria-label="Module navigation">
    <button class="pm-toggle" id="pm-toggle" type="button" aria-expanded="false" aria-controls="pm-sidebar" title="Expand navigation">☰ <span class="pm-label">Parts Manager</span></button>
    <nav class="pm-nav" aria-label="Modules">
      <div class="pm-entry"><a class="pm-module" href="${g.createLink(uri:'/')}" aria-label="Home"><span class="pm-icon">⌂</span><span class="pm-label">Home</span></a></div>
      <div class="pm-entry" data-pm-module="plm"><a class="pm-module" href="${g.createLink(controller:'plm',action:'parts')}" aria-label="PLM"><span class="pm-icon">▣</span><span class="pm-label">PLM</span></a><div class="pm-flyout"><strong>PLM</strong><a href="${g.createLink(controller:'plm',action:'parts')}">Parts</a></div></div>
      <div class="pm-entry" data-pm-module="materials"><a class="pm-module" href="${g.createLink(controller:'material',action:'index')}" aria-label="Materials"><span class="pm-icon">⬡</span><span class="pm-label">Materials</span></a><div class="pm-flyout"><strong>Materials</strong><a href="${g.createLink(controller:'material',action:'index')}">Materials Library</a></div></div>
      <div class="pm-entry" data-pm-module="changeManagement"><a class="pm-module" href="${g.createLink(controller:'changeManagement',action:'index')}" aria-label="Change Management"><span class="pm-icon">⇄</span><span class="pm-label">Change Management</span></a><div class="pm-flyout"><strong>Change Management</strong><a href="${g.createLink(controller:'changeManagement',action:'index',params:[tab:'dcn'])}">DCNs</a><a href="${g.createLink(controller:'changeManagement',action:'index',params:[tab:'projects'])}">Projects</a></div></div>
      <div class="pm-entry" data-pm-module="serverAdmin"><a class="pm-module" href="${g.createLink(controller:'serverAdmin',action:'index')}" aria-label="Server Administration"><span class="pm-icon">⚙</span><span class="pm-label">Server Administration</span></a><div class="pm-flyout"><strong>Server Administration</strong><a href="${g.createLink(controller:'serverAdmin',action:'index')}">Dashboard</a></div></div>
    </nav>
  </aside>
  <div class="pm-main">
    <header class="pm-header">
      <div class="pm-title"><g:layoutTitle default="Parts Manager"/></div>
      <div class="pm-account">
        <span class="pm-user"><sec:username/></span>
        <a class="pm-header-action" href="${g.createLink(uri:'/')}" title="Settings" aria-label="Settings">⚙</a>
        <button class="pm-header-action" id="pm-theme" type="button" title="Toggle light/dark theme" aria-label="Toggle light/dark theme">☀</button>
        <g:form controller="logout" method="POST" class="pm-logout"><button class="pm-header-action" type="submit" title="Log out" aria-label="Log out">⏻</button></g:form>
      </div>
    </header>
    <main class="pm-content"><g:layoutBody/></main>
  </div>
  <script>
(function () {
  'use strict';
  var body=document.body, toggle=document.getElementById('pm-toggle'), theme=document.getElementById('pm-theme');
  function setExpanded(value) { body.classList.toggle('pm-expanded',value); toggle.setAttribute('aria-expanded',String(value)); try { localStorage.setItem('pm-sidebar-expanded',String(value)); } catch(e) {} }
  try { setExpanded(localStorage.getItem('pm-sidebar-expanded')==='true'); } catch(e) { setExpanded(false); }
  toggle.addEventListener('click',function(){ setExpanded(!body.classList.contains('pm-expanded')); });
  function setTheme(value) { body.setAttribute('data-pm-theme',value); theme.textContent=value==='dark'?'☀':'☾'; try { localStorage.setItem('pm-theme',value); } catch(e) {} }
  try { setTheme(localStorage.getItem('pm-theme')==='light'?'light':'dark'); } catch(e) { setTheme('dark'); }
  theme.addEventListener('click',function(){ setTheme(body.getAttribute('data-pm-theme')==='dark'?'light':'dark'); });
  var current=(location.pathname.split('/')[1]||'').toLowerCase();
  document.querySelectorAll('[data-pm-module]').forEach(function(entry) {
    if (entry.dataset.pmModule.toLowerCase()===current) entry.classList.add('pm-active');
    var link=entry.querySelector('.pm-module');
    link.addEventListener('click',function(ev) {
      if (window.matchMedia('(hover:none)').matches && !entry.classList.contains('pm-open')) {
        ev.preventDefault(); document.querySelectorAll('.pm-entry.pm-open').forEach(function(e){e.classList.remove('pm-open');}); entry.classList.add('pm-open');
      }
    });
  });
  document.addEventListener('keydown',function(ev){if(ev.key==='Escape') document.querySelectorAll('.pm-entry.pm-open').forEach(function(e){e.classList.remove('pm-open');});});
  document.addEventListener('click',function(ev){if(!ev.target.closest('.pm-entry')) document.querySelectorAll('.pm-entry.pm-open').forEach(function(e){e.classList.remove('pm-open');});});
})();

</script>
</body>
</html>
