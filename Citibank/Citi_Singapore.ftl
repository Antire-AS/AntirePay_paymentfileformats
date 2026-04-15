<?xml version="1.0" encoding="UTF-8"?>
<Document xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
  <CstmrCdtTrfInitn>
    <GrpHdr>
      <MsgId>{{setMaxLength proposalid 35}}</MsgId>
      <CreDtTm>{{dateFormat "" "yyyy-MM-DDTHH:mm:ss"}}</CreDtTm>
      <NbOfTxs>{{numberofxx}}</NbOfTxs>
      <CtrlSum>{{CtrlSum}}</CtrlSum>
      <InitgPty>
        <Nm>{{companybank.DbtrName}}</Nm>
        <Id>
          <OrgId>
            <Othr>
              <Id>{{companybank.OrgNr}}</Id>
              <SchmeNm>
                <Cd>CUST</Cd>
              </SchmeNm>
            </Othr>
          </OrgId>
        </Id>
      </InitgPty>
    </GrpHdr>
    {{#each trandetails}}
    {{#ifCompare PayType "==" "Domestic"}}
    <PmtInf>
      <PmtInfId>{{PayRef}}</PmtInfId>
      <PmtMtd>TRF</PmtMtd>
      <BtchBookg>false</BtchBookg>
      <NbOfTxs>1</NbOfTxs>
      <CtrlSum>{{BillAmount}}</CtrlSum>
      <PmtTpInf>
        <SvcLvl>
          <Cd>URGP</Cd>
        </SvcLvl>
      </PmtTpInf>
      {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
      <ReqdExctnDt>{{dateFormat "" "yyyy-MM-DD"}}</ReqdExctnDt>
      {{/ifCompare}}
      {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
      <ReqdExctnDt>{{dateFormat ReqdExctnDt "yyyy-MM-DD"}}</ReqdExctnDt>
      {{/ifCompare}}
      <Dbtr>
        <Nm>{{TrDbtrNm}}</Nm>
      </Dbtr>
      <DbtrAcct>
        <Id>
          <Othr>
            <Id>{{TrDbtrBBAN}}</Id>
            <SchmeNm>
              <Cd>BBAN</Cd>
            </SchmeNm>
          </Othr>
        </Id>
        <Ccy>{{TrDbtrCur}}</Ccy>
      </DbtrAcct>
      <DbtrAgt>
        <FinInstnId>
          <BIC>{{TrDbtrBIC}}</BIC>
        </FinInstnId>
      </DbtrAgt>
      <CdtTrfTxInf>
        <PmtId>
          <InstrId>{{PayRef}}</InstrId>
          <EndToEndId>{{PayRef}}</EndToEndId>
        </PmtId>
        <Amt>
          <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
        </Amt>
        <ChrgBr>DEBT</ChrgBr>
        {{#ifCompare CdtrBankCode "!=" ""}}
        <CdtrAgt>
          <FinInstnId>
            <BIC>{{CdtrBIC}}</BIC>
            <ClrSysMmbId>
              <ClrSysId>
                <Cd>SG</Cd>
              </ClrSysId>
              <MmbId>{{CdtrBankCode}}</MmbId>
            </ClrSysMmbId>
            <PstlAdr>
              <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
            </PstlAdr>
          </FinInstnId>
        </CdtrAgt>
        {{/ifCompare}}
        {{#ifCompare CdtrClearing "!=" ""}}
        <CdtrAgt>
          <FinInstnId>
            <BIC>{{CdtrBIC}}</BIC>
            <ClrSysMmbId>
              <ClrSysId>
                <Cd>SG</Cd>
              </ClrSysId>
              <MmbId>{{CdtrClearing}}</MmbId>
            </ClrSysMmbId>
            <PstlAdr>
              <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
            </PstlAdr>
          </FinInstnId>
        </CdtrAgt>
        {{/ifCompare}}
        <Cdtr>
          {{#ifCompare CdtrNm "!=" ""}}
          <Nm>{{CdtrNm}}</Nm>
          <PstlAdr>
            <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
          </PstlAdr>
          {{else}}
          <Nm>{{Cdtr}}</Nm>
          <PstlAdr>
            <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
          </PstlAdr>
          {{/ifCompare}}
        </Cdtr>
        <CdtrAcct>
          <Id>
            <Othr>
              <Id>{{CdtrAccount}}</Id>
              <SchmeNm>
                <Cd>BBAN</Cd>
              </SchmeNm>
            </Othr>
          </Id>
        </CdtrAcct>
        <RmtInf>
          {{#ifCompare billcreditdetails "!=" ""}}
          {{#each billcreditdetails}} 
          <Ustrd>{{Ref}} - Credit: {{BillCrRef}}</Ustrd>
          {{/each}}
          <Ustrd>{{Ref}}</Ustrd>
          {{else}}
          <Ustrd>{{Ref}}</Ustrd>
          {{/ifCompare}}
        </RmtInf>
      </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{#ifCompare PayType "==" "International NON IBAN"}}
    <PmtInf>
      <PmtInfId>{{PayRef}}</PmtInfId>
      <PmtMtd>TRF</PmtMtd>
      <BtchBookg>false</BtchBookg>
      <NbOfTxs>1</NbOfTxs>
      <CtrlSum>{{BillAmount}}</CtrlSum>
      <PmtTpInf>
        <SvcLvl>
          <Cd>URGP</Cd>
        </SvcLvl>
      </PmtTpInf>
      {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
      <ReqdExctnDt>{{dateFormat "" "yyyy-MM-DD"}}</ReqdExctnDt>
      {{/ifCompare}}
      {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
      <ReqdExctnDt>{{dateFormat ReqdExctnDt "yyyy-MM-DD"}}</ReqdExctnDt>
      {{/ifCompare}}
      <Dbtr>
        <Nm>{{TrDbtrNm}}</Nm>
      </Dbtr>
      <DbtrAcct>
        <Id>
          <Othr>
            <Id>{{TrDbtrBBAN}}</Id>
            <SchmeNm>
              <Cd>BBAN</Cd>
            </SchmeNm>
          </Othr>
        </Id>
        <Ccy>{{TrDbtrCur}}</Ccy>
      </DbtrAcct>
      <DbtrAgt>
        <FinInstnId>
          <BIC>{{TrDbtrBIC}}</BIC>
          <PstlAdr>
            <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
          </PstlAdr>
        </FinInstnId>
      </DbtrAgt>
      <CdtTrfTxInf>
        <PmtId>
          <InstrId>{{PayRef}}</InstrId>
          <EndToEndId>{{PayRef}}</EndToEndId>
        </PmtId>
        <Amt>
          <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
        </Amt>
        <ChrgBr>DEBT</ChrgBr>
        {{#ifCompare CdtrBankCode "!=" ""}}
        <CdtrAgt>
          <FinInstnId>
            {{#ifCompare CdtrBIC "!=" ""}}
            <BIC>{{CdtrBIC}}</BIC>
            {{/ifCompare}}
            <ClrSysMmbId>
              <ClrSysId>
                {{#ifCompare CdtrClearing "!=" ""}}
                <Cd>{{CdtrClearing}}</Cd>
                {{else}}
                {{#ifCompare (getCountryCode CdtrBankCtry) "==" "IN"}}
                <Cd>IN</Cd>
                {{/ifCompare}}
                {{#ifCompare (getCountryCode CdtrBankCtry) "==" "US"}}
                <Cd>USABA</Cd>
                {{/ifCompare}}
                {{#ifCompare (getCountryCode CdtrBankCtry) "==" "SG"}}
                <Cd>SG</Cd>
                {{/ifCompare}}
                {{#ifCompare (getCountryCode CdtrBankCtry) "==" "CA"}}
                <Cd>CACPA</Cd>
                {{/ifCompare}}
                {{#ifCompare (getCountryCode CdtrBankCtry) "==" "AU"}}
                <Cd>AUBSB</Cd>
                {{/ifCompare}}
                {{#ifCompare (getCountryCode CdtrBankCtry) "==" "NZ"}}
                <Cd>NZBNK</Cd>
                {{/ifCompare}}
                {{#ifCompare (getCountryCode CdtrBankCtry) "==" "HK"}}
                <Cd>HK</Cd>
                {{/ifCompare}}
                {{/ifCompare}}
              </ClrSysId>
              <MmbId>{{CdtrBankCode}}</MmbId>
            </ClrSysMmbId>
            <PstlAdr>
              <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
            </PstlAdr>
          </FinInstnId>
        </CdtrAgt>
        {{else}}
        {{#ifCompare CdtrBIC "!=" ""}}
        <CdtrAgt>
          <FinInstnId>
            <BIC>{{CdtrBIC}}</BIC>
            <PstlAdr>
              <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
            </PstlAdr>
          </FinInstnId>
        </CdtrAgt>
        {{/ifCompare}}
        {{/ifCompare}}
        <Cdtr>
          {{#ifCompare CdtrNm "!=" ""}}
          <Nm>{{CdtrNm}}</Nm>
          <PstlAdr>
            <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
          </PstlAdr>
          {{else}}
          <Nm>{{Cdtr}}</Nm>
          <PstlAdr>
            <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
          </PstlAdr>
          {{/ifCompare}}
        </Cdtr>
        <CdtrAcct>
          <Id>
            <Othr>
              <Id>{{CdtrAccount}}</Id>
              <SchmeNm>
                <Cd>BBAN</Cd>
              </SchmeNm>
            </Othr>
          </Id>
        </CdtrAcct>
        <RmtInf>
          {{#ifCompare billcreditdetails "!=" ""}}
          {{#each billcreditdetails}} 
          <Ustrd>{{Ref}} - Credit: {{BillCrRef}}</Ustrd>
          {{/each}}
          <Ustrd>{{Ref}}</Ustrd>
          {{else}}
          <Ustrd>{{Ref}}</Ustrd>
          {{/ifCompare}}
        </RmtInf>
      </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{#ifCompare PayType "==" "International IBAN"}}
    <PmtInf>
      <PmtInfId>{{PayRef}}</PmtInfId>
      <PmtMtd>TRF</PmtMtd>
      <BtchBookg>false</BtchBookg>
      <NbOfTxs>1</NbOfTxs>
      <CtrlSum>{{BillAmount}}</CtrlSum>
      <PmtTpInf>
        <SvcLvl>
          <Cd>URGP</Cd>
        </SvcLvl>
      </PmtTpInf>
      {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
      <ReqdExctnDt>{{dateFormat "" "yyyy-MM-DD"}}</ReqdExctnDt>
      {{/ifCompare}}
      {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
      <ReqdExctnDt>{{dateFormat ReqdExctnDt "yyyy-MM-DD"}}</ReqdExctnDt>
      {{/ifCompare}}
      <Dbtr>
        <Nm>{{TrDbtrNm}}</Nm>
      </Dbtr>
      <DbtrAcct>
        <Id>
          <Othr>
            <Id>{{TrDbtrBBAN}}</Id>
            <SchmeNm>
              <Cd>BBAN</Cd>
            </SchmeNm>
          </Othr>
        </Id>
        <Ccy>{{TrDbtrCur}}</Ccy>
      </DbtrAcct>
      <DbtrAgt>
        <FinInstnId>
          <BIC>{{TrDbtrBIC}}</BIC>
          <PstlAdr>
            <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
          </PstlAdr>
        </FinInstnId>
      </DbtrAgt>
      <CdtTrfTxInf>
        <PmtId>
          <InstrId>{{PayRef}}</InstrId>
          <EndToEndId>{{PayRef}}</EndToEndId>
        </PmtId>
        <Amt>
          <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
        </Amt>
        <ChrgBr>DEBT</ChrgBr>
        <CdtrAgt>
          <FinInstnId>
            <BIC>{{CdtrBIC}}</BIC>
            <PstlAdr>
              <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
            </PstlAdr>
          </FinInstnId>
        </CdtrAgt>
        <Cdtr>
          {{#ifCompare CdtrNm "!=" ""}}
          <Nm>{{CdtrNm}}</Nm>
          <PstlAdr>
            <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
          </PstlAdr>
          {{else}}
          <Nm>{{Cdtr}}</Nm>
          <PstlAdr>
            <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
          </PstlAdr>
          {{/ifCompare}}
        </Cdtr>
        <CdtrAcct>
          <Id>
            <IBAN>{{CdtrIBAN}}</IBAN>
          </Id>
        </CdtrAcct>
        <RmtInf>
          {{#ifCompare billcreditdetails "!=" ""}}
          {{#each billcreditdetails}} 
          <Ustrd>{{Ref}} - Credit: {{BillCrRef}}</Ustrd>
          {{/each}}
          <Ustrd>{{Ref}}</Ustrd>
          {{else}}
          <Ustrd>{{Ref}}</Ustrd>
          {{/ifCompare}}
        </RmtInf>
      </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{/each}}
  </CstmrCdtTrfInitn>
</Document>