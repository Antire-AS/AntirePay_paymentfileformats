<?xml version="1.0" encoding="UTF-8"?>
<Document xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03 pain.001.001.03.xsd">
<CstmrCdtTrfInitn>
    <GrpHdr>
        <MsgId>{{setMaxLength proposalid 8}}</MsgId>
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
                            <Cd>BANK</Cd>
                        </SchmeNm>
                    </Othr>
                </OrgId>
            </Id>
        </InitgPty>
    </GrpHdr>
    {{#each trandetails}}    
    {{#ifCompare PayTypeNO "==" "Domestic"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
        <NbOfTxs>1</NbOfTxs>
        <CtrlSum>{{BillAmount}}</CtrlSum>
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        <Dbtr>
            <Nm>{{TrDbtrNm}}</Nm>
            <PstlAdr>
                <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
            </PstlAdr>
            <Id>
                <OrgId>
                    <Othr>
                        <Id>{{TrDbtrOrg}}</Id>
                    </Othr>
                </OrgId>
            </Id>
        </Dbtr>
        <DbtrAcct>
            <Id>  
                <IBAN>{{TrDbtrIBAN}}</IBAN>
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
            <Cdtr>
                {{#ifCompare CdtrNm "!=" ""}}
                <Nm>{{CdtrNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                </PstlAdr>
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
            {{#ifCompare CdtrReportingCdNO "!=" ""}}
            <RgltryRptg>
                <Dtls>
                    <Cd>14</Cd>
                    <Inf>Purchase, sale of goods</Inf>
                </Dtls>
            </RgltryRptg>
            {{/ifCompare}}
            <RmtInf>
                {{#ifCompare KID "!=" ""}}
                <Strd>
                    <RfrdDocInf>
                        <Tp>
                            <CdOrPrtry>
                                <Cd>CINV</Cd>
                            </CdOrPrtry>
                        </Tp>
                        <RltdDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"}}</RltdDt>
                    </RfrdDocInf>
                    <RfrdDocAmt>
                        <RmtdAmt Ccy="{{BillCurrency}}">{{BillOrgAmount}}</RmtdAmt>
                    </RfrdDocAmt>
                    <CdtrRefInf>
                    <Tp>
                        <CdOrPrtry>
                            <Cd>SCOR</Cd>
                        </CdOrPrtry>
                    </Tp>
                    <Ref>{{KID}}</Ref>
                    </CdtrRefInf>
                </Strd>
                    {{#ifCompare billcreditdetails "!=" ""}}
                    {{#each billcreditdetails}} 
                    <Strd>
                        <RfrdDocInf>
                            <Tp>
                                <CdOrPrtry>
                                    <Cd>CREN</Cd>
                                </CdOrPrtry>
                            </Tp>
                            <Nb>{{BillCreditRef}}</Nb>
                        </RfrdDocInf>
                        <RfrdDocAmt>
                            <CdtNoteAmt Ccy="{{BillCreditCurrency}}">{{BillCreditFxAmount}}</CdtNoteAmt>
                        </RfrdDocAmt>
                    </Strd>
                    {{/each}}
                    {{/ifCompare}}
                {{else}}
                <Ustrd>{{Ref}}</Ustrd>
                {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{#ifCompare PayTypeNO "==" "SEPA"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
        <NbOfTxs>1</NbOfTxs>
        <CtrlSum>{{BillAmount}}</CtrlSum>
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        <Dbtr>
            <Nm>{{TrDbtrNm}}</Nm>
            <PstlAdr>
                <StrtNm>{{TrDbtrAddr}}</StrtNm>
                <PstCd>{{TrDbtrZip}}</PstCd>
                <TwnNm>{{TrDbtrCity}}</TwnNm>
                <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
                <AdrLine>{{TrDbtrAddr}}, {{TrDbtrZip}}, {{TrDbtrCity}}, {{getCountryCode TrDbtrCtry}}</AdrLine>
            </PstlAdr>
            <Id>
                <OrgId>
                    <Othr>
                        <Id>{{TrDbtrOrg}}</Id>
                        <SchmeNm>
                            <Cd>CUST</Cd>
                        </SchmeNm>
                    </Othr>
                    <Othr>
                        <Id>{{TrDbtrDiv}}</Id>
                        <SchmeNm>
                            <Cd>BANK</Cd>
                        </SchmeNm>
                    </Othr>
                </OrgId>
            </Id>
        </Dbtr>
        <DbtrAcct>
            <Id>
                <IBAN>{{TrDbtrIBAN}}</IBAN>
            </Id>
            <Ccy>{{TrDbtrCur}}</Ccy>
        </DbtrAcct>
        <DbtrAgt>
            <FinInstnId>
                <BIC>{{TrDbtrBIC}}</BIC>
            </FinInstnId>
        </DbtrAgt>
        <ChrgBr>SLEV</ChrgBr>
        <CdtTrfTxInf>
            <PmtId>
                <InstrId>{{PayRef}}</InstrId>
                <EndToEndId>{{PayRef}}</EndToEndId>
            </PmtId>
            <Amt>
                <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
            </Amt>
            {{#ifCompare CdtrBankCode "!=" ""}}
            <IntrmyAgt1>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                </FinInstnId>
            </IntrmyAgt1>
            {{/ifCompare}}
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                    <PstlAdr>
                        {{#ifCompare CdtrAddr "!=" ""}}
                        <StrtNm>{{CdtrAddr}}</StrtNm>
                        {{/ifCompare}}
                        {{#ifCompare CdtrZip "!=" ""}}
                        <PstCd>{{CdtrZip}}</PstCd>
                        {{/ifCompare}}
                        {{#ifCompare CdtrCity "!=" ""}}
                        <TwnNm>{{CdtrCity}}</TwnNm>
                        {{/ifCompare}}
                        {{#ifCompare CdtrBankCtry "!=" ""}}
                        <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                        {{/ifCompare}}
                    </PstlAdr>
                </FinInstnId>
            </CdtrAgt>
            <Cdtr>
                {{#ifCompare CdtrNm "!=" ""}}
                <Nm>{{CdtrNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare CdtrAddr "!=" ""}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrZip "!=" ""}}
                    <PstCd>{{CdtrZip}}</PstCd>
                    {{/ifCompare}}
                    {{#ifCompare CdtrCity "!=" ""}}
                    <TwnNm>{{CdtrCity}}</TwnNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrBankCtry "!=" ""}}
                    <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    {{/ifCompare}}
                </PstlAdr>
            </Cdtr>
            <CdtrAcct>
                <Id>
                    <IBAN>{{CdtrIBAN}}</IBAN>
                </Id>
            </CdtrAcct>
            {{#ifCompare CdtrReportingCdNO "!=" ""}}
            <RgltryRptg>
                <Dtls>
                    <Cd>14</Cd>
                    <Inf>Purchase, sale of goods</Inf>
                </Dtls>
            </RgltryRptg>
            {{/ifCompare}}
            <RmtInf>
                {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{Ref}} - Credit: {{BillCrRef}}</Ustrd>
                {{/each}}
                <Ustrd>{{Ref}}</Ustrd>
                {{else}}
                {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{#ifCompare PayTypeNO "==" "International IBAN"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
        <NbOfTxs>1</NbOfTxs>
        <CtrlSum>{{BillAmount}}</CtrlSum>
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        <Dbtr>
            <Nm>{{TrDbtrNm}}</Nm>
            <PstlAdr>
                <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
            </PstlAdr>
            <Id>
                <OrgId>
                    <Othr>
                        <Id>{{TrDbtrOrg}}</Id>
                    </Othr>
                </OrgId>
            </Id>
        </Dbtr>
        <DbtrAcct>
            <Id>
                <IBAN>{{TrDbtrIBAN}}</IBAN>
            </Id>
        </DbtrAcct>
        <DbtrAgt>
            <FinInstnId>
                <BIC>{{TrDbtrBIC}}</BIC>
            </FinInstnId>
        </DbtrAgt>
        <ChrgBr>SHAR</ChrgBr>
        <CdtTrfTxInf>
            <PmtId>
                <EndToEndId>{{PayRef}}</EndToEndId>
            </PmtId>
            <Amt>
                <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
            </Amt>
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
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare CdtrAddr "!=" ""}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrZip "!=" ""}}
                    <PstCd>{{CdtrZip}}</PstCd>
                    {{/ifCompare}}
                    {{#ifCompare CdtrCity "!=" ""}}
                    <TwnNm>{{CdtrCity}}</TwnNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrBankCtry "!=" ""}}
                    <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    {{/ifCompare}}
                </PstlAdr>
            </Cdtr>
            <CdtrAcct>
                <Id>
                    <IBAN>{{CdtrIBAN}}</IBAN>
                </Id>
            </CdtrAcct>
            {{#ifCompare CdtrReportingCdNO "!=" ""}}
            <RgltryRptg>
                <Dtls>
                    <Cd>14</Cd>
                    <Inf>Purchase, sale of goods</Inf>
                </Dtls>
            </RgltryRptg>
            {{/ifCompare}}
            <RmtInf>
                {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{BillRef}} - Credit: {{BillCreditRef}}</Ustrd>
                {{else}}
                <Ustrd>{{Ref}}</Ustrd>
                {{/each}}
                {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{#ifCompare PayTypeNO "==" "International NON IBAN"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
        <NbOfTxs>1</NbOfTxs>
        <CtrlSum>{{BillAmount}}</CtrlSum>
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        <Dbtr>
            <Nm>{{TrDbtrNm}}</Nm>
            <PstlAdr>
                <StrtNm>{{TrDbtrAddr}}</StrtNm>
                <PstCd>{{TrDbtrZip}}</PstCd>
                <TwnNm>{{TrDbtrCity}}</TwnNm>
                <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
                <AdrLine>{{TrDbtrAddr}}, {{TrDbtrZip}}, {{TrDbtrCity}}, {{getCountryCode TrDbtrCtry}}</AdrLine>
            </PstlAdr>
            <Id>
                <OrgId>
                    <Othr>
                        <Id>{{TrDbtrOrg}}</Id>
                        <SchmeNm>
                            <Cd>CUST</Cd>
                        </SchmeNm>
                    </Othr>
                    <Othr>
                        <Id>{{TrDbtrDiv}}</Id>
                        <SchmeNm>
                            <Cd>BANK</Cd>
                        </SchmeNm>
                    </Othr>
                </OrgId>
            </Id>
        </Dbtr>
        <DbtrAcct>
            <Id>
                <IBAN>{{TrDbtrIBAN}}</IBAN>
            </Id>
        </DbtrAcct>
        <DbtrAgt>
            <FinInstnId>
                <BIC>{{TrDbtrBIC}}</BIC>
            </FinInstnId>
        </DbtrAgt>
        <ChrgBr>DEBT</ChrgBr>
        <CdtTrfTxInf>
            <PmtId>
                <InstrId>{{PayRef}}</InstrId>
                <EndToEndId>{{PayRef}}</EndToEndId>
            </PmtId>
            <Amt>
                <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
            </Amt>
            {{#ifCompare CdtrBankCode "!=" ""}}
            <IntrmyAgt1>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                </FinInstnId>
            </IntrmyAgt1>
            {{/ifCompare}}
            {{#ifCompare CdtrBIC "!=" ""}}
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                </FinInstnId>
            </CdtrAgt>
            {{else}}
            <CdtrAgt>
                <FinInstnId>
                    <ClrSysMmbId>
                        <ClrSysId>
                            <Cd>{{CdtrClearing}}</Cd>
                        </ClrSysId>
                        <MmbId>{{CdtrBankCode}}</MmbId>
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
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare CdtrAddr "!=" ""}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrZip "!=" ""}}
                    <PstCd>{{CdtrZip}}</PstCd>
                    {{/ifCompare}}
                    {{#ifCompare CdtrCity "!=" ""}}
                    <TwnNm>{{CdtrCity}}</TwnNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrBankCtry "!=" ""}}
                    <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    {{/ifCompare}}
                </PstlAdr>
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
            {{#ifCompare CdtrReportingCdNO "!=" ""}}
            <RgltryRptg>
                <Dtls>
                    <Cd>14</Cd>
                    <Inf>Purchase, sale of goods</Inf>
                </Dtls>
            </RgltryRptg>
            {{/ifCompare}}
            <RmtInf>
                {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{BillRef}} - Credit: {{BillCreditRef}}</Ustrd>
                {{else}}
                <Ustrd>{{Ref}}</Ustrd>
                {{/each}}
                {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{/each}}
</CstmrCdtTrfInitn>
</Document>