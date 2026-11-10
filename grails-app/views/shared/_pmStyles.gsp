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



.pm-shell { min-height:100%; background:var(--pm-bg)!important; color:var(--pm-text)!important; }
.pm-shell { --pm-bg:#202427; --pm-surface:#292e33; --pm-sidebar:#08294b; --pm-text:#e5edf4; --pm-muted:#b5c3cf; --pm-border:#414a53; }
.pm-shell[data-pm-theme="light"] { --pm-bg:#f1f4f7; --pm-surface:#ffffff; --pm-sidebar:#e4edf5; --pm-text:#182735; --pm-muted:#465968; --pm-border:#c7d2dd; }
.pm-main { min-height:100vh; background:var(--pm-bg); }
.pm-header { position:sticky; top:0; }
.pm-nav-svg,.pm-icon svg { width:34px;height:34px;display:block; }
.pm-icon { width:36px;flex-basis:36px;display:flex;align-items:center;justify-content:center; }
.pm-module {padding:0 14px; gap:16px; height:62px;}
.pm-sidebar {background:var(--pm-sidebar);}
.pm-content { background:var(--pm-bg); min-height:calc(100vh - 60px); }
.pm-content .cm { max-width:none; margin:0; padding:0 10px; color:var(--pm-text); }
.pm-content .cm section { background:var(--pm-surface); border:1px solid var(--pm-border); padding:22px; }
.pm-content .cm table { width:100%; }
.pm-content .cm th { background:color-mix(in srgb,var(--pm-sidebar) 50%,var(--pm-surface)); }
.pm-content .cm td { color:var(--pm-text); }
.pm-content .cm label { display:inline-flex; flex-direction:column; align-items:flex-start; gap:7px; margin:6px 12px 10px 0; vertical-align:top; }
.pm-content .cm form { display:flex; flex-wrap:wrap; align-items:flex-end; gap:8px; }
.pm-content .cm form label {margin:0;}
.pm-content .cm input,.pm-content .cm select,.pm-content .cm textarea { min-height:38px; background:var(--pm-bg); color:var(--pm-text); border:1px solid var(--pm-border); }
.pm-content .cm a {color:var(--pm-text);}
.pm-content .cm a:hover {color:#80c2ff;}
.pm-content .cm .btn {white-space:nowrap;}
.pm-content .cm .cm-nav {margin:0 0 16px;padding:0;}
.pm-content .cm .cm-tab {padding:9px 15px;}
.pm-content .cm section h2 {margin-bottom:18px;}
.pm-content .cm section h3 {margin-top:24px;}
.pm-header-action {display:inline-flex;align-items:center;justify-content:center;min-width:38px;min-height:38px;}
.pm-header .pm-account {gap:9px;}
.pm-content .cm .error {color:#ff7b7b;}


/* Single authoritative sidebar/header geometry. */
.pm-shell { --pm-width:64px; }
.pm-shell.pm-expanded { --pm-width:260px; }
.pm-shell > #pm-sidebar { width:var(--pm-width)!important; overflow:visible!important; }
.pm-shell > .pm-main { margin-left:var(--pm-width)!important; }
.pm-shell #pm-sidebar .pm-label {display:none!important;visibility:hidden!important;}
.pm-shell.pm-expanded #pm-sidebar .pm-label {display:inline-block!important;min-width:0;overflow:hidden;text-overflow:ellipsis;}
.pm-shell #pm-sidebar .pm-module,.pm-shell #pm-sidebar .pm-toggle {width:100%;box-sizing:border-box;overflow:hidden;white-space:nowrap;}
.pm-shell #pm-sidebar .pm-flyout {left:100%;top:0;position:absolute;display:none;min-width:230px;}
@media(hover:hover){.pm-shell #pm-sidebar .pm-entry:hover > .pm-flyout{display:block;}}
.pm-shell #pm-sidebar .pm-entry:focus-within > .pm-flyout,.pm-shell #pm-sidebar .pm-entry.pm-open > .pm-flyout{display:block;}
.pm-shell #pm-sidebar .pm-home {margin-bottom:8px;border-bottom:1px solid var(--pm-border);padding-bottom:8px;}
/* This top-fixed blue header overlays the extra text emitted by the host page. */
.pm-shell .pm-header {position:fixed!important;top:0!important;left:var(--pm-width)!important;right:0!important;height:64px!important;z-index:950!important;margin:0!important;box-sizing:border-box;box-shadow:0 -8px 0 8px var(--pm-blue);}
.pm-shell .pm-content {padding-top:86px!important;}
.pm-shell .pm-sidebar {top:0!important;}
.pm-shell .cm-create-dcn form {display:flex;gap:14px;flex-wrap:wrap;align-items:end;}
.pm-shell .cm-create-dcn form label {display:flex;flex-direction:column;gap:7px;}
@media(max-width:650px){.pm-shell.pm-expanded > .pm-main{margin-left:64px!important;}.pm-shell.pm-expanded .pm-header{left:64px!important;}}
</style>
<style>
/* Explicit wrapper geometry: works even when the host renders a SiteMesh body. */
.pm-shell {position:relative;min-height:100vh;isolation:isolate;--pm-width:64px;}
.pm-shell.pm-expanded {--pm-width:260px;}
.pm-shell > .pm-sidebar {position:fixed!important;top:0!important;bottom:0!important;left:0!important;width:var(--pm-width)!important;z-index:1100!important;overflow:visible!important;}
.pm-shell > .pm-main {margin-left:var(--pm-width)!important;min-width:0!important;}
.pm-shell .pm-sidebar .pm-label {display:none!important;visibility:hidden!important;}
.pm-shell.pm-expanded .pm-sidebar .pm-label {display:inline!important;visibility:visible!important;}
.pm-shell .pm-sidebar .pm-module,.pm-shell .pm-sidebar .pm-toggle {overflow:hidden!important;box-sizing:border-box!important;}
.pm-shell .pm-header {position:fixed!important;top:0!important;left:var(--pm-width)!important;right:0!important;height:64px!important;margin:0!important;z-index:1050!important;box-shadow:0 -20px 0 20px var(--pm-blue)!important;}
.pm-shell .pm-content {padding-top:86px!important;}
</style>

<style>
/* The earlier #pm-sidebar rule has greater specificity than the expanded
   .pm-sidebar rule. Match the ID in both states. */
.pm-shell:not(.pm-expanded) #pm-sidebar .pm-label {
    display:none !important;
    visibility:hidden !important;
}
.pm-shell.pm-expanded #pm-sidebar .pm-label {
    display:inline-block !important;
    visibility:visible !important;
    opacity:1 !important;
    flex:1 1 auto;
    min-width:0;
    overflow:hidden;
    text-overflow:ellipsis;
    white-space:nowrap;
    font-size:14px;
}
.pm-shell.pm-expanded #pm-sidebar .pm-module {
    display:flex !important;
    align-items:center;
    gap:15px;
    padding-left:14px;
    padding-right:12px;
}
.pm-shell.pm-expanded #pm-sidebar .pm-toggle {
    display:flex !important;
    gap:15px;
    align-items:center;
}
.pm-shell #pm-sidebar .pm-icon {flex:0 0 36px;}
</style>
