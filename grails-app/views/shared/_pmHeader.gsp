<header class="pm-header">
      <div class="pm-title">Change Management</div>
      <div class="pm-account">
        <span class="pm-user"><sec:username/></span>
        <a class="pm-header-action" href="${g.createLink(controller:'crew',action:'index')}" title="Crew / User settings" aria-label="Settings">⚙</a>
        <button class="pm-header-action" id="pm-theme" type="button" title="Toggle light/dark theme" aria-label="Toggle light/dark theme">☀</button>
        <g:form controller="logout" method="POST" class="pm-logout"><button class="pm-header-action" type="submit" title="Log out" aria-label="Log out">⏻</button></g:form>
      </div>
    </header>