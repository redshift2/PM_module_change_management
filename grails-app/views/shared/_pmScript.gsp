<script>
(function(){
  function init(){
    var body=document.querySelector('.pm-shell');
    var toggle=document.getElementById('pm-toggle');
    var sidebar=document.getElementById('pm-sidebar');
    var theme=document.getElementById('pm-theme');
    if(!body || !toggle || !sidebar || toggle.dataset.pmBound==='true')return;
    toggle.dataset.pmBound='true';
    function expanded(on){
      body.classList.toggle('pm-expanded',on);
      toggle.setAttribute('aria-expanded',String(on));
      toggle.setAttribute('title',on?'Collapse navigation':'Expand navigation');
      try{localStorage.setItem('pm-sidebar-expanded',String(on));}catch(e){}
    }
    var saved=false;
    try{saved=localStorage.getItem('pm-sidebar-expanded')==='true';}catch(e){}
    expanded(saved);
    toggle.addEventListener('click',function(e){e.preventDefault();expanded(!body.classList.contains('pm-expanded'));});
    if(theme){
      function setTheme(value){body.setAttribute('data-pm-theme',value);theme.textContent=value==='dark'?'☀':'☾';try{localStorage.setItem('pm-theme',value);}catch(e){}}
      var t='dark';try{t=localStorage.getItem('pm-theme')==='light'?'light':'dark';}catch(e){}
      setTheme(t);
      theme.addEventListener('click',function(){setTheme(body.getAttribute('data-pm-theme')==='dark'?'light':'dark');});
    }
    document.querySelectorAll('#pm-sidebar .pm-entry[data-pm-module]').forEach(function(entry){
      if(location.pathname.toLowerCase().indexOf('/'+entry.dataset.pmModule.toLowerCase())===0)entry.classList.add('pm-active');
      var link=entry.querySelector('.pm-module');
      if(link)link.addEventListener('click',function(ev){if(window.matchMedia('(hover:none)').matches&&!entry.classList.contains('pm-open')){ev.preventDefault();document.querySelectorAll('.pm-entry.pm-open').forEach(function(x){x.classList.remove('pm-open');});entry.classList.add('pm-open');}});
    });
    document.addEventListener('keydown',function(ev){if(ev.key==='Escape')document.querySelectorAll('.pm-entry.pm-open').forEach(function(x){x.classList.remove('pm-open');});});
    document.addEventListener('click',function(ev){if(!ev.target.closest('.pm-entry'))document.querySelectorAll('.pm-entry.pm-open').forEach(function(x){x.classList.remove('pm-open');});});
  }
  if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',init);else init();
})();
</script>