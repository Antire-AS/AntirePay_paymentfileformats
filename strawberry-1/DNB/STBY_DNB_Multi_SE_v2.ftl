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
                            <Cd>CUST</Cd>
                        </SchmeNm>
                    </Othr>
                    <Othr>
                        <Id>{{companybank.Division}}</Id>
                        <SchmeNm>
                            <Cd>BANK</Cd>
                        </SchmeNm>
                    </Othr>
                </OrgId>
            </Id>
        </InitgPty>
    </GrpHdr>
    {{#each trandetails}}    
    {{#ifCompare PayTypeSE "==" "Domestic"}}
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
        </Dbtr>
        <DbtrAcct>
            <Id>
                <IBAN>{{TrDbtrIBAN}}</IBAN>
            </Id>
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
            <CdtrAgt>
                <FinInstnId>
                    <ClrSysMmbId>
                        <ClrSysId>
                            <Cd>SESBA</Cd>
                        </ClrSysId>
                        <MmbId>5365</MmbId>
                    </ClrSysMmbId>
                </FinInstnId>
            </CdtrAgt>
            <Cdtr>
                {{#ifCompare EmpNm "!=" ""}}
                <Nm>{{EmpNm}}</Nm>
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
            {{#ifCompare CdtrReportingCdSE "!=" ""}}
            <RgltryRptg>
                <Dtls>
                <Cd>101</Cd>
                <Inf>Imp/exp of goods</Inf>
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
                        </RfrdDocInf>
                        <RfrdDocAmt>
                            <CdtNoteAmt Ccy="{{BillCreditCurrency}}">{{BillCreditFxAmount}}</CdtNoteAmt>
                        </RfrdDocAmt>
                        <CdtrRefInf>
                            <Tp>
                                <CdOrPrtry>
                                    <Cd>SCOR</Cd>
                                </CdOrPrtry>
                            </Tp>
                            <Ref>{{BillCreditRef}}</Ref>
                        </CdtrRefInf>
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
    {{#ifCompare PayTypeSE "==" "Bankgiro"}}	
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId>
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
        <CtrlSum>{{BillAmount}}</CtrlSum>
        <PmtTpInf>
            <SvcLvl>
                <Prtry>MPNS</Prtry>
            </SvcLvl>
            <LclInstrm>
                <Prtry>DO</Prtry>
            </LclInstrm>
        </PmtTpInf>
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
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
            <CdtrAgt>
            <FinInstnId>
                <ClrSysMmbId>
                    <ClrSysId>
                        <Cd>SESBA</Cd>
                    </ClrSysId>
                <MmbId>9900</MmbId>
                </ClrSysMmbId>
            </FinInstnId>
            </CdtrAgt>
            <Cdtr>
                {{#ifCompare EmpNm "!=" ""}}
                <Nm>{{EmpNm}}</Nm>
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
            {{#ifCompare CdtrReportingCdSE "!=" ""}}
            <RgltryRptg>
                <Dtls>
                <Cd>101</Cd>
                <Inf>Imp/exp of goods</Inf>
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
                        </RfrdDocInf>
                        <RfrdDocAmt>
                            <CdtNoteAmt Ccy="{{BillCreditCurrency}}">{{BillCreditFxAmount}}</CdtNoteAmt>
                        </RfrdDocAmt>
                        <CdtrRefInf>
                            <Tp>
                                <CdOrPrtry>
                                    <Cd>SCOR</Cd>
                                </CdOrPrtry>
                            </Tp>
                            <Ref>{{BillCreditRef}}</Ref>
                        </CdtrRefInf>
                    </Strd>
                    {{/each}}
                    {{/ifCompare}}
                {{/ifCompare}}
                {{#ifCompare KID "==" ""}}
                {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{BillRef}} - Credit: {{BillCreditRef}}</Ustrd>
                {{else}}
                <Ustrd>{{Ref}}</Ustrd>
                {{/each}}
                {{/ifCompare}}
                {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{#ifCompare PayTypeSE "==" "Plusgiro"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId>
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
        <CtrlSum>{{BillAmount}}</CtrlSum>
        <PmtTpInf>
            <SvcLvl>
                <Prtry>MPNS</Prtry>
            </SvcLvl>
            <LclInstrm>
                <Prtry>DO</Prtry>
            </LclInstrm>
        </PmtTpInf>
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
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
            <CdtrAgt>
            <FinInstnId>
                <ClrSysMmbId>
                    <ClrSysId>
                        <Cd>SESBA</Cd>
                    </ClrSysId>
                <MmbId>9960</MmbId>
                </ClrSysMmbId>
            </FinInstnId>
            </CdtrAgt>
            <Cdtr>
                {{#ifCompare EmpNm "!=" ""}}
                <Nm>{{EmpNm}}</Nm>
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
            {{#ifCompare CdtrReportingCdSE "!=" ""}}
            <RgltryRptg>
                <Dtls>
                <Cd>101</Cd>
                <Inf>Imp/exp of goods</Inf>
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
                        </RfrdDocInf>
                        <RfrdDocAmt>
                            <CdtNoteAmt Ccy="{{BillCreditCurrency}}">{{BillCreditFxAmount}}</CdtNoteAmt>
                        </RfrdDocAmt>
                        <CdtrRefInf>
                            <Tp>
                                <CdOrPrtry>
                                    <Cd>SCOR</Cd>
                                </CdOrPrtry>
                            </Tp>
                            <Ref>{{BillCreditRef}}</Ref>
                        </CdtrRefInf>
                    </Strd>
                    {{/each}}
                    {{/ifCompare}}
                {{/ifCompare}}
                {{#ifCompare KID "==" ""}}
                {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{Ref}} - Credit: {{BillCreditRef}}</Ustrd>
                {{else}}
                <Ustrd>{{Ref}}</Ustrd>
                {{/each}}
                {{/ifCompare}}
                {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{#ifCompare PayTypeSE "==" "International IBAN"}}
    {{#ifCompare BillCurrency "==" "EUR"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId>
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>true</BtchBookg>
        <NbOfTxs>1</NbOfTxs>
        <CtrlSum>{{BillAmount}}</CtrlSum>
        <PmtTpInf>
        <SvcLvl>
            <Cd>SEPA</Cd>
        </SvcLvl>
        </PmtTpInf>
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
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                </FinInstnId>
            </CdtrAgt>
            <Cdtr>
                {{#ifCompare EmpNm "!=" ""}}
                <Nm>{{EmpNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare EmpAddr "!=" ""}}
                    <StrtNm>{{EmpAddr}}</StrtNm>
                    {{else}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare EmpZip "!=" ""}}
                    <PstCd>{{EmpZip}}</PstCd>
                    {{else}}
                    <PstCd>{{CdtrZip}}</PstCd>                      
                    {{/ifCompare}}
                    {{#ifCompare EmpCity "!=" ""}}
                    <TwnNm>{{EmpCity}}</TwnNm>
                    {{else}}
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
            {{#ifCompare CdtrReportingCdSE "!=" ""}}
            <RgltryRptg>
                <Dtls>
                <Cd>101</Cd>
                <Inf>Imp/exp of goods</Inf>
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
    {{/ifCompare}}
    {{#ifCompare PayTypeSE "==" "International IBAN"}}
    {{#ifCompare BillCurrency "!=" "EUR"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>true</BtchBookg>
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
        <CdtTrfTxInf>
            <PmtId>
                <InstrId>{{PayRef}}</InstrId>
                <EndToEndId>{{PayRef}}</EndToEndId>
            </PmtId>
            <Amt>
                <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
            </Amt>
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                </FinInstnId>
            </CdtrAgt>
            <Cdtr>
                {{#ifCompare EmpNm "!=" ""}}
                <Nm>{{EmpNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare EmpAddr "!=" ""}}
                    <StrtNm>{{EmpAddr}}</StrtNm>
                    {{else}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare EmpZip "!=" ""}}
                    <PstCd>{{EmpZip}}</PstCd>
                    {{else}}
                    <PstCd>{{CdtrZip}}</PstCd>                      
                    {{/ifCompare}}
                    {{#ifCompare EmpCity "!=" ""}}
                    <TwnNm>{{EmpCity}}</TwnNm>
                    {{else}}
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
            {{#ifCompare CdtrReportingCdSE "!=" ""}}
            <RgltryRptg>
                <Dtls>
                <Cd>101</Cd>
                <Inf>Imp/exp of goods</Inf>
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
    {{/ifCompare}}
    {{#ifCompare PayTypeSE "==" "International NON IBAN"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>true</BtchBookg>
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
                    <BIC>{{CdtrBIC}}</BIC>
                </FinInstnId>
            </CdtrAgt>
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
                {{#ifCompare EmpNm "!=" ""}}
                <Nm>{{EmpNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare EmpAddr "!=" ""}}
                    <StrtNm>{{EmpAddr}}</StrtNm>
                    {{else}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare EmpZip "!=" ""}}
                    <PstCd>{{EmpZip}}</PstCd>
                    {{else}}
                    <PstCd>{{CdtrZip}}</PstCd>                      
                    {{/ifCompare}}
                    {{#ifCompare EmpCity "!=" ""}}
                    <TwnNm>{{EmpCity}}</TwnNm>
                    {{else}}
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
            {{#ifCompare CdtrReportingCdSE "!=" ""}}
            <RgltryRptg>
                <Dtls>
                <Cd>101</Cd>
                <Inf>Imp/exp of goods</Inf>
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
    {{#ifCompare PayTypeSE "==" "Intracompany"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>true</BtchBookg>
        <CtrlSum>{{BillAmount}}</CtrlSum>
        <PmtTpInf>
            <CtgyPurp>
                <Cd>INTC</Cd>
            </CtgyPurp>
        </PmtTpInf>
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
        </Dbtr>
        <DbtrAcct>
            <Id>
                <IBAN>{{TrDbtrIBAN}}</IBAN>
            </Id>
            <Ccy>{{DbtrCcy}}</Ccy>
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
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                </FinInstnId>
            </CdtrAgt>
            <Cdtr>
                {{#ifCompare EmpNm "!=" ""}}
                <Nm>{{EmpNm}}</Nm>
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