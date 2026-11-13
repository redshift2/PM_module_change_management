<style>
/* Scoped DCN layout: override inherited shell form and label rules. */
.pm-shell .cm .cm-dcn-card {width:100%;max-width:1100px;margin:16px auto;padding:24px;}
.pm-shell .cm .cm-dcn-form {display:grid!important;grid-template-columns:repeat(2,minmax(0,1fr));gap:18px 22px;width:100%;max-width:none;align-items:start;}
.pm-shell .cm .cm-dcn-form > label {display:flex!important;flex-direction:column!important;align-items:stretch!important;justify-content:flex-start!important;gap:7px;margin:0!important;min-width:0;width:100%;font-weight:600;}
.pm-shell .cm .cm-dcn-form > label:nth-child(2) {grid-column:1/-1;}
.pm-shell .cm .cm-dcn-form .cm-dcn-row {display:grid!important;grid-column:1/-1;grid-template-columns:repeat(2,minmax(0,1fr));gap:22px;width:100%;}
.pm-shell .cm .cm-dcn-form .cm-dcn-row > label {display:flex!important;flex-direction:column!important;align-items:stretch!important;gap:7px;margin:0!important;min-width:0;font-weight:600;}
.pm-shell .cm .cm-dcn-form input:not([type=hidden]),.pm-shell .cm .cm-dcn-form textarea,.pm-shell .cm .cm-dcn-form select {display:block!important;width:100%!important;max-width:none!important;min-width:0;box-sizing:border-box;margin:0!important;min-height:39px;font:inherit;}
.pm-shell .cm .cm-dcn-form textarea {min-height:120px;resize:vertical;}
.pm-shell .cm .cm-dcn-form .cm-dcn-actions {grid-column:1/-1;display:flex!important;flex-direction:row!important;justify-content:flex-end!important;align-items:center;gap:10px;margin:4px 0 0;padding-top:14px;border-top:1px solid var(--pm-border,#cbd5e1);}
.pm-shell .cm .cm-dcn-form .cm-dcn-actions .btn {width:auto!important;}
.pm-shell .cm .cm-dcn-heading {display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap;margin-bottom:20px;}
.pm-shell .cm .cm-dcn-heading h2 {margin:0;}
.pm-shell .cm .cm-dcn-status {display:inline-block;padding:6px 12px;border:1px solid var(--pm-border,#cbd5e1);border-radius:5px;font-weight:700;}
.pm-shell .cm .cm-readonly-field {width:100%;min-height:39px;padding:10px;border:1px solid var(--pm-border,#cbd5e1);border-radius:5px;white-space:pre-wrap;overflow-wrap:anywhere;font-weight:400;}
.pm-shell .cm .cm-description-display {min-height:120px;}
.pm-shell .cm .cm-dcn-audit {display:grid!important;grid-template-columns:repeat(2,minmax(0,1fr));gap:12px 24px;margin-top:22px;padding:18px 0;border-top:1px solid var(--pm-border,#cbd5e1);border-bottom:1px solid var(--pm-border,#cbd5e1);}
.pm-shell .cm .cm-dcn-workflow {margin-top:22px;}
.pm-shell .cm .cm-dcn-workflow form.inline,.pm-shell .cm .cm-dcn-actions form.inline {display:inline-block!important;width:auto!important;margin:4px 8px 4px 0;}
.pm-shell .cm .cm-dcn-card > .cm-dcn-actions {display:flex!important;justify-content:flex-start;gap:10px;margin-top:12px;}
@media(max-width:700px){.pm-shell .cm .cm-dcn-card{padding:16px}.pm-shell .cm .cm-dcn-form,.pm-shell .cm .cm-dcn-form .cm-dcn-row,.pm-shell .cm .cm-dcn-audit{grid-template-columns:minmax(0,1fr)}.pm-shell .cm .cm-dcn-form > label:nth-child(2){grid-column:1}.pm-shell .cm .cm-dcn-form .cm-dcn-actions{grid-column:1}}
</style>
