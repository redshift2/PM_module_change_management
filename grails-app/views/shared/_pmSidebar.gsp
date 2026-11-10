<aside class="pm-sidebar" id="pm-sidebar" aria-label="Module navigation">
    <button class="pm-toggle" id="pm-toggle" type="button" aria-expanded="false" aria-controls="pm-sidebar" title="Expand navigation">☰ <span class="pm-label">Parts Manager</span></button>
    <nav class="pm-nav" aria-label="Modules">
<div class="pm-entry pm-home"><a class="pm-module" href="${g.createLink(uri:'/')}" title="Home" aria-label="Home"><span class="pm-icon"><svg class="pm-nav-svg" viewBox="0 0 24 24" aria-hidden="true"><path d="M3 11.5 12 4l9 7.5V21h-6v-6H9v6H3z" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linejoin="round"/></svg></span><span class="pm-label">Home</span></a></div>
<div class="pm-entry" data-pm-module="changeManagement"><a class="pm-module" href="${g.createLink(controller:'changeManagement',action:'index')}" aria-label="Change Management" title="Change Management"><span class="pm-icon"><svg class="pm-nav-svg" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><g transform="rotate(-42 32 32)"><rect x="24" y="4" width="16" height="56" rx="2" fill="#f4f6f8" stroke="#17202a" stroke-width="2"/><path d="M25 12h7m-7 7h5m-5 7h7m-7 7h5m-5 7h7m-7 7h5" stroke="#17202a" stroke-width="1.8"/></g><g transform="rotate(42 32 32)"><path d="M27 6h10v41l-5 12-5-12z" fill="#26b9ed" stroke="#12618a" stroke-width="2"/><path d="M27 13h10v5H27z" fill="#087db3"/><path d="M27 47h10l-5 12z" fill="#e5bd83" stroke="#17202a" stroke-width="1.4"/><path d="M32 53l-2 5h4z" fill="#17202a"/></g></svg></span><span class="pm-label">Change Management</span></a><div class="pm-flyout"><strong>Change Management</strong><a href="${g.createLink(controller:'changeManagement',action:'index',params:[tab:'dcn'])}">DCNs</a><a href="${g.createLink(controller:'changeManagement',action:'index',params:[tab:'projects'])}">Projects</a><g:if test="${request.isUserInRole('ROLE_ADMIN')}"><a href="${g.createLink(controller:'changeManagement',action:'index',params:[tab:'createDcn'])}">Create DCN</a></g:if></div></div>
<div class="pm-entry" data-pm-module="attachment"><a class="pm-module" href="${g.createLink(controller:'attachment',action:'index')}" aria-label="Attachments" title="Attachments"><span class="pm-icon"><svg class="pm-nav-svg" viewBox="0 0 100 100" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"><circle cx="50" cy="50" r="47" fill="#FFC52B"/><path d="M36 29v51" stroke="#1D497A" stroke-width="6" stroke-linecap="round"/><path d="M29 29v27h14V29c0-7-14-7-14 0" fill="#2476C1"/><path d="M36 54v28" stroke="#123D75" stroke-width="3"/><path d="M63 18v58" stroke="#D13B12" stroke-width="6" stroke-linecap="round"/><path d="M57 18v33h14V18c0-8-14-8-14 0" fill="#C52912"/><path d="M52 48h24" stroke="#B92A0C" stroke-width="5" stroke-linecap="round"/></svg></span><span class="pm-label">Attachments</span></a><div class="pm-flyout"><strong>Attachments</strong><a href="${g.createLink(controller:'attachment',action:'index')}">Files</a><a href="${g.createLink(controller:'attachment',action:'tagged')}">Tagged</a><a href="${g.createLink(controller:'attachment',action:'terms')}">Terms</a></div></div>
<div class="pm-entry" data-pm-module="materials"><a class="pm-module" href="${g.createLink(controller:'material',action:'index')}" aria-label="Materials Library" title="Materials Library"><span class="pm-icon"><svg class="pm-nav-svg" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64"><rect x="5" y="5" width="54" height="54" rx="9" fill="#2878B8"/><path d="M16 23 32 14 48 23v19L32 51 16 42Z M16 23l16 9 16-9M32 32v19" fill="none" stroke="#fff" stroke-width="3" stroke-linejoin="round"/></svg></span><span class="pm-label">Materials Library</span></a><div class="pm-flyout"><strong>Materials Library</strong><a href="${g.createLink(controller:'material',action:'index')}">Library</a><a href="${g.createLink(controller:'material',action:'categories')}">Manage Categories</a></div></div>
<div class="pm-entry" data-pm-module="plm"><a class="pm-module" href="${g.createLink(controller:'plm',action:'parts')}" aria-label="PLM" title="PLM"><span class="pm-icon">
<!-- Generator: Adobe Illustrator 19.0.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
<svg class="pm-nav-svg" aria-hidden="true" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 465.486 465.486" style="enable-background:new 0 0 465.486 465.486;" xml:space="preserve">
<g>
	<path style="fill:#666666;" d="M92.413,363.674C41.456,363.674,0,322.217,0,271.261s41.456-92.413,92.413-92.413
		s92.413,41.456,92.413,92.413S143.37,363.674,92.413,363.674z M92.413,199.848C53.036,199.848,21,231.884,21,271.261
		s32.036,71.413,71.413,71.413s71.413-32.036,71.413-71.413S131.79,199.848,92.413,199.848z"/>
	<path style="fill:#666666;" d="M373.073,363.674c-50.957,0-92.413-41.457-92.413-92.413s41.456-92.413,92.413-92.413
		s92.413,41.456,92.413,92.413S424.03,363.674,373.073,363.674z M373.073,199.848c-39.377,0-71.413,32.036-71.413,71.413
		c0,39.377,32.036,71.413,71.413,71.413s71.413-32.036,71.413-71.413C444.486,231.884,412.45,199.848,373.073,199.848z"/>
	<path style="fill:#008DB3;" d="M380.576,271.253c0,2.72-1.49,5.34-4.07,6.67c-3.68,1.9-8.2,0.46-10.1-3.23l-56.71-110.03
		l-56.45,88.09l-12.62-8.09l55.8-87.08h-113.68l44.05,86.33l-13.36,6.82l-43.64-85.53l-61.27,94.91l-12.6-8.13l65.99-102.22
		l-18.9-37.04l13.36-6.82l18.71,36.68h123.23l-15.37-29.83c-1.56-3.02-0.93-6.82,1.82-9.17c1.39-1.19,3.21-1.77,5.03-1.77h47.62
		l7.08,0.533c13.11,0,24,10.027,24.22,23.087c0.22,13.44-11.13,24.43-24.57,24.43h-8.27c-2.07,0-3.95-0.84-5.3-2.19
		c-1.36-1.36-2.2-3.24-2.2-5.31c0-4.14,3.36-7.5,7.5-7.5h8.82c5.18,0,9.35-4.38,9-9.64c-0.32-4.79-4.494-8.929-9.294-8.929
		l-6.986,0.519h-35.501l77.82,151.01C380.306,268.922,380.576,270.093,380.576,271.253z"/>
	<path style="fill:#F7CF52;" d="M182.749,116.817h-55.083c-4.143,0-7.5-3.358-7.5-7.5s3.357-7.5,7.5-7.5h55.083
		c4.143,0,7.5,3.358,7.5,7.5S186.892,116.817,182.749,116.817z"/>
	<path style="fill:#999999;" d="M92.406,260.657c-3.928,0-7.229-3.057-7.479-7.031c-0.259-4.134,2.882-7.695,7.016-7.955
		l139.91-8.772c4.153-0.255,7.695,2.882,7.955,7.016c0.259,4.134-2.882,7.695-7.016,7.955l-139.91,8.772
		C92.723,260.652,92.563,260.657,92.406,260.657z"/>
	<path style="fill:#999999;" d="M232.33,305.638c-0.158,0-0.316-0.005-0.477-0.015l-139.91-8.772
		c-4.134-0.259-7.274-3.821-7.016-7.955c0.259-4.134,3.813-7.264,7.955-7.016l139.91,8.772c4.134,0.259,7.274,3.821,7.016,7.955
		C239.56,302.581,236.258,305.638,232.33,305.638z"/>
	<path style="fill:#F7CF52;" d="M368.824,125.466c0.22,13.44-11.471,24.57-24.911,24.57h-8.117c-2.07,0-3.95-0.84-5.3-2.19
		c-1.36-1.36-2.292-3.43-2.292-5.5c0-4.14,3.652-7.615,7.792-7.615h8.82c5.18,0,8.905-4.084,8.555-9.344
		c-0.32-4.79-4.195-8.575-8.995-8.575h-6.96v-15h7.28C358.371,101.813,368.604,112.406,368.824,125.466z"/>
	<path style="fill:#F7CF52;" d="M232.323,305.638c-18.955,0-34.377-15.421-34.377-34.377c0-18.955,15.422-34.376,34.377-34.376
		s34.377,15.421,34.377,34.376S251.278,305.638,232.323,305.638z M232.323,251.884c-10.685,0-19.377,8.692-19.377,19.376
		c0,10.685,8.692,19.377,19.377,19.377s19.377-8.692,19.377-19.377C251.7,260.577,243.008,251.884,232.323,251.884z"/>
	<path style="fill:#F7CF52;" d="M92.413,296.865c-14.118,0-25.604-11.486-25.604-25.604s11.486-25.604,25.604-25.604
		s25.604,11.486,25.604,25.604S106.531,296.865,92.413,296.865z M92.413,260.657c-5.848,0-10.604,4.757-10.604,10.604
		s4.757,10.604,10.604,10.604s10.604-4.757,10.604-10.604S98.26,260.657,92.413,260.657z"/>
	<path style="fill:#008DB3;" d="M219.313,321.11c-0.73,0-1.474-0.107-2.208-0.333c-3.959-1.218-6.182-5.415-4.964-9.374
		l13.01-42.347c1.216-3.96,5.413-6.185,9.371-4.969c3.959,1.216,6.185,5.411,4.969,9.371l-13.012,42.355
		C225.487,319.038,222.52,321.11,219.313,321.11z"/>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
</svg>
</span><span class="pm-label">PLM</span></a><div class="pm-flyout"><strong>PLM</strong><a href="${g.createLink(controller:'plm',action:'parts')}">Parts</a><a href="${g.createLink(controller:'plm',action:'parentParts')}">Parent Parts</a><a href="${g.createLink(controller:'plm',action:'obsoleteParts')}">Obsolete</a></div></div>
<div class="pm-entry" data-pm-module="serverAdmin"><a class="pm-module" href="${g.createLink(controller:'serverAdmin',action:'index')}" aria-label="Server Administration" title="Server Administration"><span class="pm-icon"><svg class="pm-nav-svg" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64"><rect x="7" y="8" width="50" height="48" rx="7" fill="#195d8f"/><rect x="14" y="16" width="36" height="11" rx="2" fill="#eaf4fb"/><rect x="14" y="34" width="36" height="11" rx="2" fill="#eaf4fb"/><circle cx="43" cy="21" r="3" fill="#33a56f"/><circle cx="43" cy="39" r="3" fill="#33a56f"/></svg></span><span class="pm-label">Server Administration</span></a><div class="pm-flyout"><strong>Server Administration</strong><a href="${g.createLink(controller:'serverAdmin',action:'serverInfo')}">Server Info</a><a href="${g.createLink(controller:'serverAdmin',action:'jobQueue')}">Job Queue</a><g:if test="${request.isUserInRole('ROLE_ADMIN')}"><a href="${g.createLink(controller:'serverAdmin',action:'authorization')}">Authorization</a></g:if><g:if test="${request.isUserInRole('ROLE_ADMIN')}"><a href="${g.createLink(controller:'serverAdmin',action:'maintenance')}">Server Maintenance</a></g:if><g:if test="${request.isUserInRole('ROLE_ADMIN')}"><a href="${g.createLink(controller:'serverAdmin',action:'events')}">Event Manager</a></g:if><g:if test="${request.isUserInRole('ROLE_ADMIN')}"><a href="${g.createLink(controller:'serverAdmin',action:'emailServer')}">Email Server</a></g:if><g:if test="${request.isUserInRole('ROLE_ADMIN')}"><a href="${g.createLink(controller:'serverAdmin',action:'workers')}">Workers</a></g:if></div></div>
<div class="pm-entry" data-pm-module="workspace"><a class="pm-module" href="${g.createLink(controller:'workspace',action:'index')}" aria-label="Global Workspace" title="Global Workspace"><span class="pm-icon">${raw(taack.app.TaackAppRegisterService.apps.find { it.entryPoint?.toString()?.toLowerCase()?.contains('workspace') }?.svg ?: '<svg class="pm-nav-svg" viewBox="0 0 64 64" aria-hidden="true"><path d="M6 16h22l6 7h24v32H6z" fill="#e9ad30"/><path d="M6 23h52v30H6z" fill="#f5c54f"/><rect x="18" y="29" width="32" height="19" rx="2" fill="#2878b8"/><path d="M23 35h21M23 41h15" stroke="white" stroke-width="3"/></svg>')}</span><span class="pm-label">Global Workspace</span></a><div class="pm-flyout"><strong>Global Workspace</strong><a href="${g.createLink(controller:'workspace',action:'index')}">Workspaces</a></div></div>
</nav>
  </aside>