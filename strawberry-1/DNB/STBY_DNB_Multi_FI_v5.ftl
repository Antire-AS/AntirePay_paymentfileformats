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
    {{#ifCompare PayTypeFI "==" "Domestic"}}
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
                {{#ifCompare CdtrNm "!=" ""}}
                <Nm>{{CdtrNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare CdtrAddr "!=" ""}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{else}}
                    <StrtNm>{{TrDbtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrZip "!=" ""}}
                    <PstCd>{{CdtrZip}}</PstCd>
                    {{else}}
                    <PstCd>{{TrDbtrZip}}</PstCd>
                    {{/ifCompare}}
                    {{#ifCompare CdtrCity "!=" ""}}
                    <TwnNm>{{CdtrCity}}</TwnNm>
                    {{else}}
                    <TwnNm>{{TrDbtrCity}}</TwnNm>
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
                        {{#ifCompare BillCreditKID "!=" ""}}
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
                            <CdtrRefInf>
                                <Tp>
                                    <CdOrPrtry>
                                        <Cd>SCOR</Cd>
                                    </CdOrPrtry>
                                </Tp>
                                <Ref>{{BillCreditKID}}</Ref>
                            </CdtrRefInf>
                        </Strd>
                        {{/ifCompare}}
                        {{#ifCompare BillCreditKID "==" ""}}
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
                        {{/ifCompare}}
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
    {{#ifCompare PayTypeFI "==" "International IBAN"}}
    {{#ifCompare BillCurrency "==" "EUR"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId>
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
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
                    <PstlAdr>
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    <PstCd>{{CdtrZip}}</PstCd>
                    <TwnNm>{{CdtrCity}}</TwnNm>
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
                    {{else}}
                    <StrtNm>{{TrDbtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrZip "!=" ""}}
                    <PstCd>{{CdtrZip}}</PstCd>
                    {{else}}
                    <PstCd>{{TrDbtrZip}}</PstCd>
                    {{/ifCompare}}
                    {{#ifCompare CdtrCity "!=" ""}}
                    <TwnNm>{{CdtrCity}}</TwnNm>
                    {{else}}
                    <TwnNm>{{TrDbtrCity}}</TwnNm>
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
            <Purp>
                <Cd>SUPP</Cd>
            </Purp>
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
                        {{#ifCompare BillCreditKID "!=" ""}}
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
                            <CdtrRefInf>
                                <Tp>
                                    <CdOrPrtry>
                                        <Cd>SCOR</Cd>
                                    </CdOrPrtry>
                                </Tp>
                                <Ref>{{BillCreditKID}}</Ref>
                            </CdtrRefInf>
                        </Strd>
                        {{/ifCompare}}
                        {{#ifCompare BillCreditKID "==" ""}}
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
                        {{/ifCompare}}
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
    {{/ifCompare}}
    {{#ifCompare PayTypeFI "==" "International IBAN"}}
    {{#ifCompare BillCurrency "!=" "EUR"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
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
                {{#ifCompare CdtrNm "!=" ""}}
                <Nm>{{CdtrNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare CdtrAddr "!=" ""}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{else}}
                    <StrtNm>{{TrDbtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrZip "!=" ""}}
                    <PstCd>{{CdtrZip}}</PstCd>
                    {{else}}
                    <PstCd>{{TrDbtrZip}}</PstCd>
                    {{/ifCompare}}
                    {{#ifCompare CdtrCity "!=" ""}}
                    <TwnNm>{{CdtrCity}}</TwnNm>
                    {{else}}
                    <TwnNm>{{TrDbtrCity}}</TwnNm>
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
            <RmtInf>
            {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{BillRef}} - Credit: {{BillCrRef}}</Ustrd>
                {{/each}}
                <Ustrd>{{Ref}}</Ustrd>
                {{else}}
            {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{/ifCompare}}
    {{#ifCompare PayTypeFI "==" "International NON IBAN"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
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
            {{#ifCompare (getCountryCode CdtrBankCtry) "==" "CA"}}
            {{#ifCompare BillCurrency "==" "CAD"}}
            <CdtrAgt>
                <FinInstnId>
                    <ClrSysMmbId>
                    <ClrSysId>
                        <Cd>CACPA</Cd>
                    </ClrSysId>
                    <MmbId>{{CdtrBankCode}}</MmbId>
                    </ClrSysMmbId>
                    <PstlAdr>
                        <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    </PstlAdr>
                </FinInstnId>
            </CdtrAgt>
            {{else}}
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                </FinInstnId>
            </CdtrAgt>
            {{/ifCompare}}
            {{/ifCompare}}
            {{#ifCompare (getCountryCode CdtrBankCtry) "==" "US"}}
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                    <ClrSysMmbId>
                        <ClrSysId>
                            <Cd>USABA</Cd>
                        </ClrSysId>
                    <MmbId>{{CdtrBankCode}}</MmbId>
                    </ClrSysMmbId>
                    <PstlAdr>
                        <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    </PstlAdr>
                </FinInstnId>
            </CdtrAgt>
            {{/ifCompare}}
            {{#ifCompare (getCountryCode CdtrBankCtry) "==" "AU"}}
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                    <ClrSysMmbId>
                        <ClrSysId>
                            <Cd>AUBSB</Cd>
                        </ClrSysId>
                    <MmbId>{{CdtrBankCode}}</MmbId>
                    </ClrSysMmbId>
                    <PstlAdr>
                        <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    </PstlAdr>
                </FinInstnId>
            </CdtrAgt>
            {{/ifCompare}}
            {{#ifCompare (getCountryCode CdtrBankCtry) "==" "NZ"}}
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                    <ClrSysMmbId>
                        <ClrSysId>
                            <Cd>NZBNK</Cd>
                        </ClrSysId>
                    <MmbId>{{CdtrBankCode}}</MmbId>
                    </ClrSysMmbId>
                    <PstlAdr>
                        <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    </PstlAdr>
                </FinInstnId>
            </CdtrAgt>
            {{/ifCompare}}                        
            {{#ifCompare (getCountryCode CdtrBankCtry) "==" "SG"}}
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
            {{#ifCompare (getCountryCode CdtrBankCtry) "==" "HK"}}
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                    <ClrSysMmbId>
                        <ClrSysId>
                            <Cd>HK</Cd>
                        </ClrSysId>
                    <MmbId>{{CdtrBankCode}}</MmbId>
                    </ClrSysMmbId>
                    <PstlAdr>
                        <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    </PstlAdr>
                </FinInstnId>
            </CdtrAgt>
            {{/ifCompare}} 
            {{#ifCompare (getCountryCode CdtrBankCtry) "==" "IN"}}
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                    <ClrSysMmbId>
                        <ClrSysId>
                            <Cd>INIFSC</Cd>
                        </ClrSysId>
                    <MmbId>{{CdtrBankCode}}</MmbId>
                    </ClrSysMmbId>
                    <PstlAdr>
                        <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    </PstlAdr>
                </FinInstnId>
            </CdtrAgt>
            {{/ifCompare}}
            {{else}}
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
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
            <RmtInf>
            {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{BillRef}} - Credit: {{BillCrRef}}</Ustrd>
                {{/each}}
                <Ustrd>{{Ref}}</Ustrd>
                {{else}}
            {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{#ifCompare PayTypeFI "==" "Intracompany"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
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
            <RmtInf>
            {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{BillRef}} - Credit: {{BillCrRef}}</Ustrd>
                {{/each}}
                <Ustrd>{{Ref}}</Ustrd>
                {{else}}
            {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{/each}}    
</CstmrCdtTrfInitn>
</Document>