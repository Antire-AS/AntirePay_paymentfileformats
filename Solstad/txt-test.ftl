0|{{setMaxLength proposalid 8}}|{{dateFormat "" "yyyy-MM-DDTHH:mm:ss"}}|{{numberofxx}}|{{CtrlSum}}|{{companybank.DbtrName}}|{{companybank.OrgNr}}
{{#each trandetails}}
1|{{PayType}}|{{PayRef}}|{{dateFormat ReqdExctnDt "YYYY-MM-DD"}}|{{BillCurrency}}|{{BillAmount}}|{{#ifCompare CdtrNm "!=" ""}}{{CdtrNm}}{{else}}{{Cdtr}}{{/ifCompare}}|{{getCountryCode CdtrBankCtry}}|{{CdtrAccount}}|{{CdtrIBAN}}|{{CdtrBIC}}
{{/each}}
7|{{numberofxx}}|{{CtrlSum}}
