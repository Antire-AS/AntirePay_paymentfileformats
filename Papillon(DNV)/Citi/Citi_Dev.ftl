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
          <Cd>NURG</Cd>
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
          <ClrSysMmbId>
            <ClrSysId>
              <Cd>SG</Cd>
            </ClrSysId>
            <MmbId>013044</MmbId>
          </ClrSysMmbId>
        </FinInstnId>
      </DbtrAgt>
      <ChrgBr>SHAR</ChrgBr>
      <CdtTrfTxInf>
        <PmtId>
          <InstrId>{{PayRef}}</InstrId>
          <EndToEndId>{{PayRef}}</EndToEndId>
        </PmtId>
        <Amt>
          <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
        </Amt>
        {{#ifCompare CdtrBankCode "!=" ""}}
        <CdtrAgt>
          <FinInstnId>
            <ClrSysMmbId>
              <ClrSysId>
                <Cd>SG</Cd>
              </ClrSysId>
              <MmbId>{{CdtrBankCode}}</MmbId>
            </ClrSysMmbId>
          </FinInstnId>
        </CdtrAgt>
        {{/ifCompare}}
        {{#ifCompare CdtrClearing "!=" ""}}
        <CdtrAgt>
          <FinInstnId>
            <ClrSysMmbId>
              <ClrSysId>
                <Cd>SG</Cd>
              </ClrSysId>
              <MmbId>{{CdtrClearing}}</MmbId>
            </ClrSysMmbId>
          </FinInstnId>
        </CdtrAgt>
        {{/ifCompare}}
        <Cdtr>
          {{#ifCompare CdtrNm "!=" ""}}
          <Nm>{{CdtrNm}}</Nm>
          {{else}}
          <Nm>{{Cdtr}}</Nm>
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
    {{#ifCompare PayType "==" "International Non IBAN"}}
    <PmtInf>
      <PmtInfId>{{PayRef}}</PmtInfId>
      <PmtMtd>TRF</PmtMtd>
      <BtchBookg>false</BtchBookg>
      <NbOfTxs>1</NbOfTxs>
      <CtrlSum>{{BillAmount}}</CtrlSum>
      <PmtTpInf>
        <SvcLvl>
          <Cd>NURG</Cd>
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
          <ClrSysMmbId>
            <ClrSysId>
              <Cd>SG</Cd>
            </ClrSysId>
            <MmbId>013044</MmbId>
          </ClrSysMmbId>
        </FinInstnId>
      </DbtrAgt>
      <ChrgBr>SHAR</ChrgBr>
      <CdtTrfTxInf>
        <PmtId>
          <InstrId>{{PayRef}}</InstrId>
          <EndToEndId>{{PayRef}}</EndToEndId>
        </PmtId>
        <Amt>
          <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
        </Amt>
        {{#ifCompare CdtrBankCode "!=" ""}}
        <CdtrAgt>
          <FinInstnId>
            <ClrSysMmbId>
              <ClrSysId>
                <Cd>SG</Cd>
              </ClrSysId>
              <MmbId>{{CdtrBankCode}}</MmbId>
            </ClrSysMmbId>
          </FinInstnId>
        </CdtrAgt>
        {{/ifCompare}}
        {{#ifCompare CdtrClearing "!=" ""}}
        <CdtrAgt>
          <FinInstnId>
            <ClrSysMmbId>
              <ClrSysId>
                <Cd>SG</Cd>
              </ClrSysId>
              <MmbId>{{CdtrClearing}}</MmbId>
            </ClrSysMmbId>
          </FinInstnId>
        </CdtrAgt>
        {{/ifCompare}}
        <Cdtr>
          {{#ifCompare CdtrNm "!=" ""}}
          <Nm>{{CdtrNm}}</Nm>
          {{else}}
          <Nm>{{Cdtr}}</Nm>
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
    {{/each}}
  </CstmrCdtTrfInitn>
</Document>